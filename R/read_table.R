#' Reads a table and does some minor formatting
#'
#' This function reads a table and does some minor formatting on it. It
#' basically used \link[rio]{import} but can also handle `.rda` files.
#'
#' @param path the path to a single file.
#'
#' @return A data.frame where the POSIXct and POSIXt variables get
#' changed to Date variables.
#'
#' @author Leonardo Collado-Torres
#' @export
#' 
#' @import rio
#'
#'
#' @examples
#'
#' library('rio')
#' export(iris, 'iris1.csv')
#' df <- read_table('iris1.csv')
#'
read_table <- function(path) {
    
    ## Check input
    stopifnot(length(path) == 1)
    
    
    ## Try to guess format for .Rda/.Rda
    if(grepl('\\.rda$', tolower(path))) {
        df <- import(path, format = 'RData')
    } else {
        df <- import(path)
    }
    
    ## Fix column names
    colnames(df) <- gsub('#', 'num',
        gsub('\\.|\\(|\\)', '',
            gsub('/', '_',
                gsub(' |/ |-', '_', tolower(colnames(df)))
            )
        )
    )
    
    ## Transform POSIXct to date
    posix <- sapply(df, function(x) { any(class(x) %in% c('POSIXct',
        'POSIXt')) })
    if(any(posix)) {
        for(i in which(posix)) df[, i] <- as.Date(df[, i])
    }
    
    return(df)
}