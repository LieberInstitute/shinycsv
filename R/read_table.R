#' Reads a table and does some minor formatting
#'
#' This function reads a table and does some minor formatting on it. It
#' basically used \link[rio]{import} but can also handle `.rda` files.
#'
#' @param path the path to a single file.
#' @param name the file name including the extension. Might be different
#' from `path` in the context of \link[shiny]{fileInput}.
#'
#' @return A data.frame where the POSIXct and POSIXt variables get
#' changed to Date variables.
#'
#' @author Leonardo Collado-Torres
#' @export
#'
#' @import rio
#' @import readxl
#'
#'
#' @examples
#'
#' library("rio")
#' export(iris, "iris1.csv")
#' df <- read_table("iris1.csv")
#'
read_table <- function(path, name = path) {
    ## Check input
    stopifnot(length(path) == 1)


    ## Try to guess format for .Rda/.Rda
    if (grepl("\\.rda$", tolower(name))) {
        df <- import(path, format = "RData")
    } else if (grepl("\\.xls$|\\.xlsx$", tolower(name))) {
        df <- as.data.frame(switch(readxl:::excel_format(name),
            xls = readxl:::read_xls(path),
            xlsx = readxl:::read_xlsx(path)
        ))
    } else {
        df <- import(path, format = rio:::get_ext(name))
    }

    ## Fix column names
    colnames(df) <- gsub(
        "#", "num",
        gsub(
            "\\.|\\(|\\)", "",
            gsub(
                "/", "_",
                gsub(" |/ |-", "_", tolower(colnames(df)))
            )
        )
    )

    ## Transform POSIXct to date
    posix <- sapply(df, function(x) {
        any(class(x) %in% c(
            "POSIXct",
            "POSIXt"
        ))
    })
    if (any(posix)) {
        for (i in which(posix)) df[, i] <- as.Date(df[, i])
    }

    return(df)
}
