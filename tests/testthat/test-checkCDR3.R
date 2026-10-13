test_that("checkCDR3 works without cdr3_start/cdr3_end columns", {
    rep <- data.frame(sequence_id = c("a", "b", "c"), sequence = c("ACGT", "ACGT", "ACGT"),
                      junction = c("TGTAAA", NA, "TGTCCC"), v_call = "IGHV1-2*01")
    out <- checkCDR3(rep)
    expect_equal(out$seqs_ids, c("a", "c"))
    expect_equal(out$cdr3_seqs, c("TGTAAA", "TGTCCC"))
})

test_that("getVCalls returns character columns for any table type", {
    rep <- data.frame(sequence_id = c("a", "b", "c"), sequence = "ACGT",
                      junction = "TGTAAA", v_call = c("IGHV1-2*01", "IGHV3-23*01", "IGHV1-2*02"))
    for (r in list(rep, tibble::as_tibble(rep), data.table::as.data.table(rep))) {
        out <- getVCalls(checkCDR3(r), r, FALSE)
        expect_equal(out$seq_ids, c("a", "b", "c"))
        expect_equal(out$v_call_genes, c("IGHV1-2", "IGHV3-23", "IGHV1-2"))
        expect_true(all(vapply(out, is.character, logical(1))))
    }
})

test_that("getGeneAlleleStat adds each unobserved reference gene once", {
    rep <- data.frame(sequence_id = "a", v_call = "IGHV1-2*01")
    ref <- c("IGHV1-2*01" = "ACGT", "IGHV1-58*01" = "ACGT", "IGHV1-58*02" = "ACGT")
    invisible(capture.output(out <- getGeneAlleleStat(rep, reference = ref, call = "v_call")))
    expect_equal(sum(out$gene_data$gene == "IGHV1-58"), 1)
})
