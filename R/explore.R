#' Explore a CSV file or a data.frame stored in a Rdata file
#'
#' Opens the shiny application that allows you to explore a CSV file or a
#' data.frame stored in a Rdata file.
#'
#' @param ... Additional arguments passed to \link[shiny]{runApp}.
#'
#' @details This function runs the Shiny application including in this package. It is basically a wrapper for \link[shiny]{runApp}.
#'
#' @return The Shiny application is opened in your browser. To stop the
#' function from running you have to cancel the command using ctrl + c or the
#' equivalent shortcut in your system.
#'
#' @examples
#' \dontrun{
#' ## Open the Shiny application
#' explore()
#' ## Remember to cancel the command to get back to the R console once you are done analyzing your own data.
#' }
#' @export
#' @references For more information on what a Shiny app is check http://shiny.rstudio.com/
#' @rawNamespace import(shiny, except = c("dataTableOutput", "renderDataTable"))
#' @import DT
#' @importFrom devtools session_info
#' @import RColorBrewer
#'
#' @author Stephen Semick, Leonardo Collado-Torres

explore <- function(...) {
    ## Locate the Shiny code
    srcdir <- system.file("shinycsv",
        package = "shinycsv",
        mustWork = TRUE
    )

    ## Run the shiny application
    runApp(appDir = srcdir, ...)
}
