[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Documentation Status](https://readthedocs.org/projects/rep-cred/badge/?version=latest)](https://rep-cred.readthedocs.io/en/latest/?badge=latest)
[![Docker Image CI](https://github.com/airr-community/rep-cred/actions/workflows/docker-image.yml/badge.svg)](https://github.com/airr-community/rep-cred/actions/workflows/docker-image.yml)



# RepCred: Repertoire Credibility

Good analysis requires good data, but how can a high-quality AIRR dataset be
distinguished from a low-quality one? RepCred identifies and reports several key
metrics that can indicate potential problems in a repertoire. Modeled after
FastQC, it provides an easily digestible summary for novices and experts alike.

The only input required is a file describing IG and/or TCR rearrangements in the
[AIRR TSV format](https://docs.airr-community.org/en/stable/datarep/rearrangements.html).
A small example repertoire is available at
[inst/extdata/ExampleDb.tsv](inst/extdata/ExampleDb.tsv). Optionally, the germline
reference set (FASTA) used for annotation can be provided, so that gene and allele
calls can be checked against it.

By default, repertoires are randomly downsampled to 5000 rearrangements, which
keeps the run time short while still giving an accurate assessment.

RepCred is maintained by the
[Software Working Group](https://www.antibodysociety.org/the-airr-community/airr-working-groups/software/)
of the [Adaptive Immune Receptor Repertoire Community (AIRR-C)](https://www.antibodysociety.org/the-airr-community/).
To get help or report a bug, please open an
[issue](https://github.com/airr-community/rep-cred/issues). Contributions are
welcome, see [CONTRIBUTING.md](CONTRIBUTING.md).

# Running RepCred

## Docker - GUI

Pull the container:

```
docker pull airrc/rep-cred:latest
```

To launch the shiny application use the command below. Then open in your browser
` http://localhost:3838`. 

```
docker run --rm -ti --user shiny -p 3838:3838 airrc/rep-cred:latest
```

If you are using linux, you may need to use the command line

```
docker run --rm --network host -ti --user shiny -p 3838:3838 airrc/rep-cred:latest
```

To open a terminal inside the container use:

```
docker run --rm -ti --user shiny -p 3838:3838 airrc/rep-cred:latest bash
```

## Docker - command line

Pull the container:

```
docker pull airrc/rep-cred:latest
```

Get example data:

```
wget https://raw.githubusercontent.com/airr-community/rep-cred/master/inst/extdata/ExampleDb.tsv
```

Run `repcred`:

```
docker run --rm -v $(pwd):/home:z airrc/rep-cred:latest repcred -r ExampleDb.tsv -o repcred-report
```

## Local Installation

## Pre-requisites

RepCred requires a recent version of [pandoc](https://pandoc.org). This is installed with Rstudio and the easiest approach is to check that you are using a recent version, although other installation methods are described in the [documentation](https://pkg.yihui.org/rmarkdown-cookbook/install-pandoc.html).
 
## Installing RepCred

Repdred can be installed from github:

```
devtools::install_github('airr-community/rep-cred')
```

## Running RepCred

RepCred can be started from an R prompt as follows:

```
library(repcred)   
repcredWeb()  
```

## Binder

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/airr-community/rep-cred/master?urlpath=shiny/binder/)
