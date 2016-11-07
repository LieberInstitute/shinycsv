#' Plot two variables against each other
#'
#' This function tries to choose a good plot to show for comparing two
#' variables at a time.
#'
#' @param x A vector.
#' @param y A vector of the same length as `x`.
#' @param xvar The name of the x variable.
#' @param yvar The name of the y variable.
#' @param color A color to use in the plots that have one single color.
#' @param pal A color palette to use with \link[RColorBrewer]{brewer.pal} for
#' the \link[vcd]{mosaic} plots when `x` and `y` are factors.
#'
#' @return A plot of `x` versus `y`.
#'
#' @export
#' @author Leonardo Collado-Torres
#' 
#' @import RColorBrewer
#' @import vcd
#' @importFrom graphics plot boxplot axis title
#'
#' @examples
#' plot_twoway(as.factor(mtcars$gear), mtcars$mpg, xvar = 'gear', yvar = 'mpg')
#'

plot_twoway <- function(x, y, xvar, yvar, color = 'lightblue', pal = 'Set1') {
    stopifnot(pal %in% rownames(RColorBrewer::brewer.pal.info))
    
    ## For when the plot is made too fast
    if(length(x) == 0) return(NULL)
    
    if(is.character(x)) x <- as.factor(x)
    if(is.character(y)) y <- as.factor(y)
    y_factor <- class(y)[1] %in% c('factor', 'ordered')
    
    ## Now make the plot
    if(length(unique(x[!is.na(x)])) > 6) {
        if(y_factor & class(x)[1] %in% c('factor', 'ordered')) {
            return(plot_mosaic(x, y, xvar, yvar, pal))
        } else {
            plot(y ~ x, xlab = xvar, ylab = yvar, bg = color, pch = 21, las = 2)
        }
    } else {
        if(class(x)[1] == 'logical') {
            x <- as.character(x)
            if(any(is.na(x))) {
                x[is.na(x)] <- 'NA'
                x <- factor(x, levels = c('FALSE', 'TRUE', 'NA'))
            } else {
                x <- factor(x, levels = c('FALSE', 'TRUE'))
            }            
        }
        if(y_factor) {
            if(class(x)[1] %in% c('factor', 'ordered')) {
                return(plot_mosaic(x, y, xvar, yvar, pal))
            } else {
                y_lab <- levels(y)
                y <- as.integer(y)
            }
        }            
        boxplot(y ~ x, xlab = xvar, ylab = yvar, col = color,
            axes = ifelse(y_factor, FALSE, TRUE), las = 2)
        if(y_factor) {
            axis(2, at = seq_len(length(y_lab)), labels = y_lab, las = 2)
            axis(1)
            title('This plot might look better when swapping the axes')
        }
    }
}

plot_mosaic <- function(x, y, xvar, yvar, pal) {
    mosaic(table(y, x), labeling = labeling_values,
        labeling_args = list(alternate_labels = TRUE,
            set_varnames = c('x' = xvar, 'y' = yvar),
        spacing = spacing_equal), highlighting = 'x',
        highlighting_fill = brewer.pal(length(unique(x)), pal))
}
