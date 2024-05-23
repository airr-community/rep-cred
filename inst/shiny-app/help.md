Good analysis requires good data, but how can how can a high-quality 
AIRR dataset be distinguished from a low-quality one? RepCred fills this need 
by identifying and reporting several key metrics that can be 
indicators of potential problems. Modeled after fastqc, RepCred provides an
easily digestible summary that can be used by novices and experts alike.

The only requirement to run RepCred is a file describing IG and/or TCR 
rearrangements in the [AIRR TSV format](https://docs.airr-community.org/en/stable/datarep/rearrangements.html). 
You can find a small <a href="https://raw.githubusercontent.com/airr-community/rep-cred/master/inst/extdata/ExampleDb.tsv" target="_blank">example repertoire here</a>.


By default, all repertoires are randomly down-sampled to 5000 rearrangements; 
we find that this still provides an accurate assessment of repertoire 
credibility while maintaining a reasonable run time.

Finally, if a custom 
(non-IMGT?) database was used to annotate the rearrangements, this should be 
provided to RepCred as well, so that SHM and related statistics can be 
calculated accurately.

To get help or report a bug, please file an issue on RepCred’s github 
page at [https://github.com/airr-community/rep-cred/issues](https://github.com/airr-community/rep-cred/issues).

RepCred is designed to be modular and accept new functions/metrics with ease. We welcome pull requests 
(please see [https://github.com/airr-community/airr-standards/blob/master/CONTRIBUTING.rst](https://github.com/airr-community/airr-standards/blob/master/CONTRIBUTING.rst)). Other feature requests will be evaluated and prioritized.


