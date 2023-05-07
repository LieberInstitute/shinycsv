#' Univariate plot
#'
#' Tries to guess the best plot to show for a single variable.
#'
#' @param info A vector.
#' @param title The title to use in the plot.
#' @param color A color to use in the plot.
#'
#' @return A plot.
#'
#' @export
#' @author Leonardo Collado-Torres
#'
#' @importFrom graphics boxplot hist barplot
#'
#' @examples
#' plot_oneway(mtcars$mpg, "mpg")
#' plot_oneway(as.factor(mtcars$gear), "gear")
#'
plot_oneway <- function(info, title, color = "lightblue") {
    if (class(info) == "logical") info <- as.factor(info)

    if (class(info) == "numeric") {
        boxplot(info, main = title, col = color)
    } else if (class(info) == "integer") {
        hist(info,
            main = title, col = color,
            breaks = seq(min(info, na.rm = TRUE) - 0.5,
                max(info, na.rm = TRUE) + 0.5,
                by = 1
            ),
            xlim = range(info, na.rm = TRUE) * c(0.8, 1.2)
        )
    } else if (class(info) %in% c("factor", "ordered", "logical")) {
        barplot(table(info, useNA = "ifany"),
            main = title, col = color,
            las = ifelse(length(levels(info)) > 5, 2, 1)
        )
    } else if (class(info) == "character") {
        info <- sort(table(gsub("^ ", "", unlist(strsplit(info, ";")))),
            decreasing = TRUE
        )
        barplot(info,
            main = title, col = color,
            las = ifelse(length(info) > 5, 2, 1)
        )
    }
}
