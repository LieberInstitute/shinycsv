context('Summaries')

test_that('One variable', {
    expect_equal(stat_summary('a'), NULL)
    expect_equal(stat_summary(as.numeric(1:10)), c(summary(1:10), 'SD' = sd(1:10), 'Variance' = var(1:10)))
    expect_equal(table_summary(rnorm(10)), NULL)
    expect_equal(table_summary(1:10), table(1:10, dnn = c('information')))
    expect_equal(table_summary(paste(letters[1:10], collapse = ';')),
        table(letters[1:10], dnn = c('information')))
})

test_that('Drop NA', {
    expect_equal(nrow(dropEmpty_row(mtcars)), nrow(mtcars))
    expect_equal(nrow(dropEmpty_row(rbind(mtcars, NA))), nrow(mtcars))
})

mtcars$mine <- letters[seq_len(nrow(mtcars) / 2)]
mtcars$int <- seq_len(nrow(mtcars))

test_that('Plot one variable', {
    expect_equal(plot_oneway(mtcars$mpg, 'mpg')$n, 32)
    expect_equal(plot_oneway(as.factor(mtcars$gear), 'gear'), matrix(c(0.7, 1.9, 3.1), ncol = 1))
    expect_equal(class(plot_oneway(mtcars$int, 'int')), 'histogram')
    expect_equal(nrow(plot_oneway(mtcars$mine, 'mine')), nrow(mtcars) / 2)
})



test_that('Two variables plot', {
    expect_error(plot_twoway(as.factor(mtcars$gear), mtcars$mpg, xvar = 'gear', yvar = 'mpg', pal = 'random'))
    expect_equal(plot_twoway(as.factor(mtcars$gear), mtcars$mpg, xvar = 'gear', yvar = 'mpg'), NULL)
    expect_equivalent(as.table(plot_twoway(as.factor(mtcars$gear), as.factor(mtcars$gear), xvar = 'gear', yvar = 'gear')), table('x'= as.factor(mtcars$gear), 'y' = as.factor(mtcars$gear)))
    expect_equal(plot_twoway(mtcars$mine, mtcars$mpg, xvar = 'mine', yvar = 'mpg'), NULL)
    expect_equal(plot_twoway(mtcars$mpg, mtcars$mine, xvar = 'mpg', yvar = 'mine'), NULL)
})

test_that('Plot code', {
    expect_error(plot_code('mtcars.csv', mtcars$mpg, x = 'mpg'), selection = 1)
    expect_error(plot_code('mtcars.csv', mtcars, x = 'wooot'))
    expect_error(plot_code('mtcars.csv', mtcars, x = 'mpg', selection = 1e4))
    expect_error(plot_code('mtcars.csv', mtcars, x = 'mpg', y = 'woot'))
    expect_equal(plot_code('mtcars.csv', mtcars, x = 'mpg', selection = 1:5), "\n## Install shinycsv if needed\ninstall.packages('devtools')\ndevtools::install_github('LieberInstitute/shinycsv')\n\n## Load necessary code\nlibrary('shinycsv')\n\n## Load your data\ndf <- read_table('mtcars.csv')\n\n## If your file is not in the R current working directory (see it with getwd())\n## then you can run:\n# df <- read_table(file.choose())\n## Note that using file.choose() is not completely reproducible, which is why\n## we prefer the first option.\n\n## Drop empty rows\ndf <- dropEmpty_row(df)\n\n## Subset data\ndf <- df[, c(1, 2, 3, 4, 5)]\n\n## One variable plot\nplot_oneway(info = df$mpg, title = 'mpg', color = 'lightblue')\n\n## Reproducibility information\noptions(width = 120)\ndevtools::session_info()\nSys.time()\n\n")
    expect_equal(plot_code('mtcars.csv', mtcars, x = 'mpg', y = 'vs'), "\n## Install shinycsv if needed\ninstall.packages('devtools')\ndevtools::install_github('LieberInstitute/shinycsv')\n\n## Load necessary code\nlibrary('shinycsv')\n\n## Load your data\ndf <- read_table('mtcars.csv')\n\n## If your file is not in the R current working directory (see it with getwd())\n## then you can run:\n# df <- read_table(file.choose())\n## Note that using file.choose() is not completely reproducible, which is why\n## we prefer the first option.\n\n## Drop empty rows\ndf <- dropEmpty_row(df)\n\n## Two variable plot\nplot_twoway(x = df$mpg, y = df$vs, xvar = 'mpg', yvar = 'vs', color = 'lightblue', pal = 'Set1')\n\n## Reproducibility information\noptions(width = 120)\ndevtools::session_info()\nSys.time()\n\n")
})