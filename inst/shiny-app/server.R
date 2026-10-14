server <- function(input, output, session) {

    # One entry per successful run in this session: report path, web path and settings
    dataValues <- reactiveValues(
        runs=list()
    )

    # Run the analysis only when the button is clicked. observeEvent()
    # isolates the handler, so changing the other inputs doesn't re-run it.
    observeEvent(input$go, {
        req(input$file1)
        genome_file <- if (isTRUE(input$input_chk)) input$genome$datapath else NULL
        # Record the settings, so each run's card says what it was run with
        settings <- list(
            Repertoire=input$file1$name,
            Downsampling=if (isTRUE(input$input_downsample)) paste(input$input_downsample_n, "sequences") else "No",
            Germline=if (is.null(genome_file)) "None" else paste(input$genome$name, collapse = ", ")
        )
        # Each run gets its own folder, so earlier reports are not overwritten.
        # Its name is random because resource paths are shared by all sessions.
        run_dir <- tempfile("repcred-")
        report_path <- NULL

        withProgress(
            tryCatch(
                {
                    report_path <- repcred_report(input$file1$datapath,
                                                  outdir=run_dir,
                                                  genome_file=genome_file,
                                                  downsample = input$input_downsample,
                                                  downsample_n = input$input_downsample_n)
                },
                error = function(e) {
                    showNotification(paste("Analysis failed:", conditionMessage(e)),
                                     type = "error", duration = NULL)
                }
            ),
            message="Analyzing repertoire..."
        )

        if (!is.null(report_path)) {
            #repcred::replaceChapterClassType(report_path)
            run_id <- length(dataValues$runs) + 1
            prefix <- basename(run_dir)
            shiny::addResourcePath(prefix, dirname(report_path))

            output[[paste0("downloadResults", run_id)]] <- downloadHandler(
                filename = function() {
                    paste0("report", run_id, ".zip")
                },
                content = function(fname) {
                    # Zip from the parent folder so the archive holds results/, not the full temp path
                    results_dir <- dirname(report_path)
                    old_wd <- setwd(dirname(results_dir))
                    on.exit(setwd(old_wd))
                    zip(zipfile=fname, files=basename(results_dir))
                    if(file.exists(paste0(fname, ".zip"))) {file.rename(paste0(fname, ".zip"), fname)}
                },
                contentType = "application/zip"
            )

            dataValues$runs[[run_id]] <- list(
                url=file.path(".", prefix, basename(report_path)),
                time=format(Sys.time(), "%H:%M"),
                settings=settings
            )
        }
    })

    # A results box with one card per run, newest first
    output$openResultsBtn <- renderUI({
        req(length(dataValues$runs) > 0)
        n_runs <- length(dataValues$runs)
        cards <- lapply(rev(seq_len(n_runs)), function(run_id) {
            run <- dataValues$runs[[run_id]]
            div(class="panel panel-default repcred-run",
                div(class="panel-heading",
                    strong(paste("Run", run_id)),
                    span(class="text-muted", run$time),
                    if (run_id == n_runs) span(class="label label-primary", "Latest")
                ),
                div(class="panel-body",
                    tags$dl(class="dl-horizontal",
                            lapply(names(run$settings), function(name) {
                                tagList(tags$dt(name), tags$dd(run$settings[[name]]))
                            })
                    ),
                    actionButton(inputId=paste0('openResultsBtn', run_id),
                                 label= 'Open analysis results',
                                 icon = icon("link"),
                                 style="color: #fff; background-color: #f39c12; border-color: #f39c12",
                                 onclick =paste0("window.open('", run$url, "', '_blank')")
                    ),
                    downloadButton(paste0("downloadResults", run_id))
                )
            )
        })
        div(class="panel panel-default repcred-results",
            div(class="panel-heading", strong("Results"), span(class="badge", n_runs)),
            div(class="panel-body", cards)
        )
    })

}
