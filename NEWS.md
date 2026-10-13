Development version
-------------------------------------------------------------------------------

New features:

+ The downsampling size is configurable: `downsample_n` (default 5000) in
  `repcred_report()` and `render_report()`, `-n/--downsample-n` on the command
  line, and a number input in the Shiny app.
+ The report lists the MD5 checksums of the repertoire and of each germline
  FASTA file, so it can be traced to the exact input files.
+ Large repertoires are downsampled while the file is read, instead of loading
  the whole file first. Peak memory no longer grows with file size (#37).
+ Downsampling is seeded, and the report shows the number of rows read and
  kept.
+ Quality control stats show the percentage of rows with missing values for
  each column (#11).
+ The non-nucleotide section reports the number of sequences and nucleotides
  the counts are relative to (#12).
+ The chimera check runs whenever `cdr3`, `junction` or `cdr3_start`/`cdr3_end`
  are available, not only when `sequence` is, and prints a message when it is
  skipped.
+ Sequence lengths are reported from `sequence` when `sequence_alignment` is
  empty (#41).

Bug fixes:

+ Fixed a crash in the gene usage section when a germline reference contains
  several alleles of a gene that is absent from the repertoire (dplyr >= 1.2).
+ Fixed a crash in the chimera check when the `cdr3_start`/`cdr3_end` columns
  are absent.
+ Fixed `NA` handling in the non-nucleotide section, which made the total `NA`
  and misaligned the example row (#12).
+ `getVCalls()` returns character columns instead of list columns.
+ PDF report: removed blank pages and restored the Quality Control heading
  (#34).
+ Docker: `docker run ... repcred -r ...` now passes its arguments to
  `repcred`.

General:

+ Added `tigger` and `markdown` to the dependencies.
+ Removed the unused `pairwiseAlignment` and `nucleotideSubstitutionMatrix`
  imports, which moved from Biostrings to pwalign in Bioconductor 3.19, and
  the blanket import of `xfun`.
+ Added an introduction to the README, wrote the vignette, and added
  CONTRIBUTING.md (#1, #3, #4, #5).
+ The vignette builds to HTML by default, so it does not need LaTeX.
+ Updated the GitHub Actions workflow.


Version 0.0.1: October 10, 2022
-------------------------------------------------------------------------------
+ Adapted package for CRAN submission
