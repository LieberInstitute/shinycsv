
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinycsv

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Codecov test
coverage](https://codecov.io/gh/LieberInstitute/shinycsv/branch/devel/graph/badge.svg)](https://codecov.io/gh/LieberInstitute/shinycsv?branch=devel)
[![R build
status](https://github.com/LieberInstitute/shinycsv/workflows/R-CMD-check-bioc/badge.svg)](https://github.com/LieberInstitute/shinycsv/actions)
[![GitHub
issues](https://img.shields.io/github/issues/LieberInstitute/shinycsv)](https://github.com/LieberInstitute/shinycsv/issues)
[![GitHub
pulls](https://img.shields.io/github/issues-pr/LieberInstitute/shinycsv)](https://github.com/LieberInstitute/shinycsv/pulls)
[![DOI](https://zenodo.org/badge/72884509.svg)](https://zenodo.org/badge/latestdoi/72884509)
<!-- badges: end -->

This package allows interactive explorations of CSV files, data.frame
objects stored in a Rdata file (only one data.frame stored), or other
types of table files. You can view this shiny app deployed at
[libd.shinyapps.io/shinycsv](https://libd.shinyapps.io/shinycsv/). If
you are interested in the [showcase
mode](http://shiny.rstudio.com/articles/display-modes.html), then check
out
[libd.shinyapps.io/shinycsv-showcase](https://libd.shinyapps.io/shinycsv-showcase/).

The vignette for this package is available at
[LieberInstitute/shinycsv](http://Lieberinstitute.github.io/shinycsv/).

## Installation instructions

Get the latest stable `R` release from
[CRAN](http://cran.r-project.org/). Then install `shinycsv` from
[GitHub](https://github.com/LieberInstitute/shinycsv) with:

``` r
BiocManager::install("LieberInstitute/shinycsv")
```

## Citation

Below is the citation output from using `citation('shinycsv')` in R.
Please run this yourself to check for any updates on how to cite
**shinycsv**.

``` r
print(citation("shinycsv"), bibtex = TRUE)
#> To cite package 'shinycsv' in publications use:
#> 
#>   Collado-Torres L, Semick S, Jaffe AE (2020). _shinycsv: Explore a
#>   table interactively in a shiny application_. R package version
#>   0.99.9, <https://github.com/LieberInstitute/shinycsv>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {shinycsv: Explore a table interactively in a shiny application},
#>     author = {Leonardo Collado-Torres and Stephen Semick and Andrew E. Jaffe},
#>     year = {2020},
#>     note = {R package version 0.99.9},
#>     url = {https://github.com/LieberInstitute/shinycsv},
#>   }
```

Please note that the `shinycsv` was only made possible thanks to many
other R and bioinformatics software authors, which are cited either in
the vignettes and/or the paper(s) describing this package.

## Code of Conduct

Please note that the `shinycsv` project is released with a [Contributor
Code of Conduct](http://bioconductor.org/about/code-of-conduct/). By
contributing to this project, you agree to abide by its terms.

## Development tools

- Continuous code testing is possible thanks to [GitHub
  actions](https://www.tidyverse.org/blog/2020/04/usethis-1-6-0/)
  through *[usethis](https://CRAN.R-project.org/package=usethis)*,
  *[remotes](https://CRAN.R-project.org/package=remotes)*, and
  *[rcmdcheck](https://CRAN.R-project.org/package=rcmdcheck)* customized
  to use [Bioconductor’s docker
  containers](https://www.bioconductor.org/help/docker/) and
  *[BiocCheck](https://bioconductor.org/packages/3.17/BiocCheck)*.
- Code coverage assessment is possible thanks to
  [codecov](https://codecov.io/gh) and
  *[covr](https://CRAN.R-project.org/package=covr)*.
- The [documentation website](http://LieberInstitute.github.io/shinycsv)
  is automatically updated thanks to
  *[pkgdown](https://CRAN.R-project.org/package=pkgdown)*.
- The code is styled automatically thanks to
  *[styler](https://CRAN.R-project.org/package=styler)*.
- The documentation is formatted thanks to
  *[devtools](https://CRAN.R-project.org/package=devtools)* and
  *[roxygen2](https://CRAN.R-project.org/package=roxygen2)*.

For more details, check the `dev` directory.

This package was developed using
*[biocthis](https://bioconductor.org/packages/3.17/biocthis)*.
