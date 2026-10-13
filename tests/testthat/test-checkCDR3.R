test_that("checkCDR3 works without cdr3_start/cdr3_end columns", {
    rep <- data.frame(sequence_id = c("a", "b", "c"), sequence = c("ACGT", "ACGT", "ACGT"),
                      junction = c("TGTAAA", NA, "TGTCCC"), v_call = "IGHV1-2*01")
    out <- checkCDR3(rep)
    expect_equal(out$seqs_ids, c("a", "c"))
    expect_equal(out$cdr3_seqs, c("TGTAAA", "TGTCCC"))
})
