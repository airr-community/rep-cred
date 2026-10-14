test_that("Shiny app runs the analysis only when 'Run analysis' is clicked", {
    calls <- list()

    # Load the server with a stub that records the calls to repcred_report()
    # and writes a report into the run's output folder
    env <- new.env(parent = asNamespace("shiny"))
    env$repcred_report <- function(rep, outdir = NULL, genome_file = NULL,
                                   downsample = TRUE, downsample_n = 5000) {
        calls[[length(calls) + 1]] <<- list(outdir = outdir, genome_file = genome_file,
                                            downsample = downsample)
        report <- file.path(outdir, "results", "index.html")
        dir.create(dirname(report), recursive = TRUE)
        writeLines(paste("run", length(calls)), report)
        report
    }
    sys.source(system.file("shiny-app", "server.R", package = "repcred"), envir = env)

    shiny::testServer(shiny::shinyApp(shiny::fluidPage(), env$server), {
        session$setInputs(file1 = list(datapath = "rep.tsv", name = "rep.tsv"), input_downsample = TRUE,
                          input_downsample_n = 5000, input_chk = FALSE)
        expect_length(calls, 0)

        session$setInputs(go = 1)
        expect_length(calls, 1)
        expect_equal(dataValues$runs[[1]]$settings,
                     list(Repertoire = "rep.tsv", Downsampling = "5000 sequences", Germline = "None"))
        expect_match(output$openResultsBtn$html, "<dd>5000 sequences</dd>")

        # Changing the options doesn't re-run the analysis (#23)
        session$setInputs(input_downsample = FALSE)
        session$setInputs(input_downsample_n = 100)
        session$setInputs(input_chk = TRUE, genome = list(datapath = "germline.fasta", name = "germline.fasta"))
        expect_length(calls, 1)
        # The results link stays and still describes the previous run
        expect_match(output$openResultsBtn$html, "<dd>5000 sequences</dd>")

        session$setInputs(go = 2)
        expect_length(calls, 2)
        expect_equal(calls[[2]]$genome_file, "germline.fasta")
        expect_false(calls[[2]]$downsample)

        # An uploaded germline is ignored once the checkbox is unchecked
        session$setInputs(input_chk = FALSE)
        session$setInputs(go = 3)
        expect_null(calls[[3]]$genome_file)

        # Every run of the session has a card, newest first, each in its own folder
        html <- output$openResultsBtn$html
        expect_equal(unlist(regmatches(html, gregexpr("Run [0-9]+", html))),
                     c("Run 3", "Run 2", "Run 1"))
        expect_equal(lengths(regmatches(html, gregexpr("Latest", html))), 1)
        expect_equal(dataValues$runs[[2]]$settings,
                     list(Repertoire = "rep.tsv", Downsampling = "No", Germline = "germline.fasta"))
        expect_length(unique(vapply(calls, `[[`, "", "outdir")), 3)

        # Each zip holds its own results/, not the full temp path
        for (run_id in 1:3) {
            zip_file <- output[[paste0("downloadResults", run_id)]]
            expect_equal(utils::unzip(zip_file, list = TRUE)$Name,
                         c("results/", "results/index.html"))
            exdir <- tempfile()
            utils::unzip(zip_file, exdir = exdir)
            expect_equal(readLines(file.path(exdir, "results", "index.html")),
                         paste("run", run_id))
        }
    })
})
