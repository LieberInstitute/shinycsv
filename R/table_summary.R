#' Simple univariate table summary
#' 
#' Prints a simple univariate table summary
#'
#' @param information A vector.
#' 
#' @return A univariate table displaying the NAs if present. If `information` is a
#' character vector, it will split it by semicolons and show the table of the
#' resulting vector.
#'
#' @export
#' @author Leonardo Collado-Torres
#'
#' @examples
#' table_summary(mtcars$mpg)
#'

table_summary <- function(information) {
    if(class(information) == 'numeric') {
        NULL
    } else if (class(information) %in% c('factor', 'ordered', 'logical', 'integer')) {
        table(information, useNA = 'ifany')
    } else if (class(information) == 'character') {
        information <- gsub('^ ', '', unlist(strsplit(information, ';')))
        sort(table(information), decreasing = TRUE)
    }
}
