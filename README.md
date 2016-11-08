Status: Travis CI [![Build Status](https://travis-ci.org/LieberInstitute/shinycsv.svg?branch=master)](https://travis-ci.org/LieberInstitute/shinycsv), Codecov [![codecov.io](https://codecov.io/github/LieberInstitute/shinycsv/coverage.svg?branch=master)](https://codecov.io/github/LieberInstitute/shinycsv?branch=master)

shinycsv
========

This package allows interactive explorations of CSV files, data.frame objects stored in a Rdata file (only one data.frame stored), or other types of table files. You can view this shiny app deployed at [jhubiostatistics.shinyapps.io/shinycsv](https://jhubiostatistics.shinyapps.io/shinycsv/). If you are interested in the [showcase mode](http://shiny.rstudio.com/articles/display-modes.html), then check out [jhubiostatistics.shinyapps.io/shinycsv-showcase](https://jhubiostatistics.shinyapps.io/shinycsv-showcase/).

The vignette for this package is available at [LieberInstitute/shinycsv](http://Lieberinstitute.github.io/shinycsv/).

# Installation instructions

Get R 3.3.x from [CRAN](http://cran.r-project.org/).

```R
## If needed:
# install.packages('devtools')

library('devtools')
install_github('LieberInstitute/shinycsv')
```


# Citation

Below is the citation output from using `citation('shinycsv')` in R. Please 
run this yourself to check for any updates on how to cite __shinycsv__.

To cite the __shinycsv__ package in publications use:

Leonardo Collado-Torres and Stephen Semick and Andrew E. Jaffe (2016). shinycsv: Explore a CSV or a Rdata with a data.frame in a shiny application. R package version 0.99.5. https://github.com/LieberInstitute/shinycsv

@Manual{,
    title = {shinycsv: Commonly used functions by the Jaffe lab},
    author = {Leonardo Collado-Torres and Stephen Semick and Andrew E. Jaffe},
    year = {2016},
    note = {R package version 0.99.5},
    url = {https://github.com/LieberInstitute/shinycsv},
}

# Testing

Testing on is feasible thanks to [R Travis](http://docs.travis-ci.com/user/languages/r/) and [rhub](https://github.com/r-hub/rhub).
