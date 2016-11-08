## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library('knitcitations')

## Load knitcitations with a clean bibliography
cleanbib()
cite_options(hyperlink = 'to.doc', citation_format = 'text', style = 'html')
# Note links won't show for now due to the following issue
# https://github.com/cboettig/knitcitations/issues/63

## Write bibliography information
bibs <- c(
    BiocStyle = citation('BiocStyle'),
    devtools = citation('devtools'),
    DT = citation('DT'),
    knitcitations = citation('knitcitations'),
    knitr = citation('knitr')[3],
    R = citation(),
    RColorBrewer = citation('RColorBrewer'),
    readxl = citation('readxl'),
    rio = citation('rio'),
    rmarkdown = citation('rmarkdown'),
    shinycsv = citation('shinycsv'),
    shiny = citation('shiny'),
    testthat = citation('testthat'),
    vcd = citation('vcd')
)

write.bibtex(bibs,
    file = 'quickstartRef.bib')
bib <- read.bibtex('quickstartRef.bib')

## Assign short names
names(bib) <- names(bibs)

## ----'installpkg', eval = FALSE----------------------------------
#  ## If needed:
#  # install.packages('devtools')
#  
#  library('devtools')
#  install_github('LieberInstitute/shinycsv')

## ----'use', eval = FALSE-----------------------------------------
#  shinycsv::explore()

## ----'citation'--------------------------------------------------
## Citation info
citation('shinycsv')

## ----createVignette, eval=FALSE----------------------------------
#  ## Create the vignette
#  library('rmarkdown')
#  system.time(render('shinycsv-quickstart.Rmd', 'BiocStyle::html_document'))
#  
#  ## Extract the R code
#  library('knitr')
#  knit('shinycsv-quickstart.Rmd', tangle = TRUE)

## ----createVignette2---------------------------------------------
## Clean up
file.remove('quickstartRef.bib')

## ----reproduce1, echo=FALSE--------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE--------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits=3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library('devtools')
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE--------------------------------------------------
## Print bibliography
bibliography()

