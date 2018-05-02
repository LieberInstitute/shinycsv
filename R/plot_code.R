#' Get the code for reproducing a plot
#' 
#' This function creates the code in text needed for reproducing a plot
#' from \link{explore}.
#'
#' @param filename The filename (preferably the full path) for the data
#' used.
#' @param fulldata The data.frame with the original full data displayed in
#' \link{explore}.
#' @param selection An integer vector of the rows of the \code{fulldata}
#' without empty rows (see \link{dropEmpty_row}) to be used in the plot.
#' @param x A variable name in \code{fulldata}.
#' @param y A variable name in \code{fulldata}. If missing, the code for a 
#' one way plot is shown.
#' @inheritParams plot_twoway
#'
#' @return A character vector with the code to reproduce a figure.
#' 
#' @author Leonardo Collado-Torres
#' @export
#' 
#' @examples
#' cat(plot_code('mtcars.csv', mtcars, x = 'mpg', selection = 1:5))
#' cat(plot_code('mtcars.csv', mtcars, x = 'mpg', y = 'vs'))



plot_code <- function(filename, fulldata, selection = seq_len(nrow(fulldata)),
    x, y = NULL, color = 'lightblue', pal = 'Set1') {
    
    stopifnot(is.data.frame(fulldata))
    stopifnot(max(selection) <= nrow(fulldata))
    stopifnot(x %in% colnames(fulldata))
    if(is.null(y)) {
        plot <- paste0("## One variable plot
plot_oneway(info = df$", x, ", title = '", x, "', color = '", color, "')
")
    } else {
        stopifnot(y %in% colnames(fulldata))
        plot <- paste0("## Two variable plot
plot_twoway(x = df$", x, ", y = df$", y, ", xvar = '", x, "', yvar = '", y, "', color = '", color, "', pal = '", pal, "')
")
    }
    
    df <- dropEmpty_row(fulldata)
    
    if(!identical(seq_len(nrow(df)), selection)) {
        select <- paste0("## Subset data
df <- df[, c(", paste(selection, collapse = ', '), ")]

")
    } else {
        select <- NULL
    }
    
    
    res <- paste0("
## Install shinycsv if needed
install.packages('devtools')
devtools::install_github('LieberInstitute/shinycsv')

## Load necessary code
library('shinycsv')

## Load your data
df <- read_table('", filename, "')

## If your file is not in the R current working directory (see it with getwd())
## then you can run:
# df <- read_table(file.choose())
## Note that using file.choose() is not completely reproducible, which is why
## we prefer the first option.

## Drop empty rows
df <- dropEmpty_row(df)

", select, plot,
"
## Reproducibility information
options(width = 120)
devtools::session_info()
Sys.time()

")
    
    return(res)
}