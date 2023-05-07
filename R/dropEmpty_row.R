#' Drop the empty rows of a data.frame
#'
#' This function drops the rows of a data.frame that are full of NAs.
#'
#' @param input_data A data.frame.
#'
#' @return A data.frame where at least one variable was observed per row.
#'
#' @export
#' @author Stephen Semick
#'
#' @examples
#' dropEmpty_row(mtcars)
#'
dropEmpty_row <- function(input_data) {
    output_data <- input_data[rowSums(is.na(input_data)) != length(input_data), ]
    return(output_data)
}
