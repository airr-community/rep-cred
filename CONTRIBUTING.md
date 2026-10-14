# Contributing to RepCred

RepCred is developed by the AIRR Community Software Working Group. Bug reports,
feature requests and pull requests are welcome.

## Reporting a problem

Open an [issue](https://github.com/airr-community/repcred/issues) and include:

- how you ran RepCred (Shiny app, `repcred` command line, Docker, or `repcred_report()` in R),
- the command or options used,
- the error message and, if possible, a small repertoire that reproduces it.

## Making changes

1. Fork the repository and create a branch from `master`.
2. Keep each pull request focused on one fix or feature, and reference the issue it addresses.
3. Before opening the pull request, check that the package still builds and that
   the report still renders on the test repertoires:

   ```r
   devtools::document()
   devtools::check()
   devtools::install()
   ```

   ```bash
   Rscript inst/repcred.R -r inst/extdata/ExampleDb.tsv -o outdir -f html
   Rscript inst/repcred.R -r test_repertoires/airr-covid-19.tsv -o outdir -f pdf
   ```

4. New report sections go in
   `inst/rstudio/templates/project/project_files/index.Rmd`; reusable logic goes in
   `R/` with a roxygen header and, where possible, a test in `tests/testthat/`.
5. The GitHub Actions workflow runs `R CMD check` and renders the test
   repertoires in html and pdf format; it must pass before merging.

Contributions are made under the package license (CC BY-SA 4.0). See also the
[AIRR Community contributing guidelines](https://github.com/airr-community/airr-standards/blob/master/CONTRIBUTING.rst).
