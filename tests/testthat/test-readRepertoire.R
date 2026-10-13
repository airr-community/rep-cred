test_that("readRepertoire downsamples while streaming", {
    file <- system.file("extdata", "ExampleDb.tsv", package = "repcred")
    full <- airr::read_rearrangement(file)

    set.seed(1)
    sub <- readRepertoire(file, n = 100, chunk_size = 37)  # small chunks cross boundaries
    expect_equal(nrow(sub), 100)
    expect_equal(attr(sub, "n_input"), nrow(full))
    expect_true(all(sub$sequence_id %in% full$sequence_id))
    expect_false(anyDuplicated(sub$sequence_id) > 0)

    set.seed(1)
    expect_equal(readRepertoire(file, n = 100)$sequence_id, sub$sequence_id)

    expect_equal(nrow(readRepertoire(file)), nrow(full))
    expect_equal(nrow(readRepertoire(file, n = 1e6)), nrow(full))
})
