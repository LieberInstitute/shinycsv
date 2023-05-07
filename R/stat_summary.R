#' Statistical summary for one variable
#'
#' Print the summary for a numeric variable that includes the SD and the
#' variance.
#'
#' @param info A numeric vector.
#'
#' @return The summary if `info` is numeric.
#'
#' @export
#' @author Leonardo Collado-Torres
#'
#' @importFrom stats sd var
#'
#' @examples
#' stat_summary(mtcars$mpg)
#'
stat_summary <- function(info) {
    if (class(info) == "numeric") {
        c(summary(info),
            SD = sd(info, na.rm = TRUE),
            Variance = var(info, na.rm = TRUE)
        )
    } else {
        NULL
    }
}
