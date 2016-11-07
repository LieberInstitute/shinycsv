context('Summaries')

test_that('One variable', {
    expect_equal(stat_summary('a'), NULL)
    expect_equal(stat_summary(as.numeric(1:10)), c(summary(1:10), 'SD' = sd(1:10), 'Variance' = var(1:10)))
    expect_equal(table_summary(1:10), table(1:10, dnn = c('information')))
    expect_equal(table_summary(paste(letters[1:10], collapse = ';')),
        table(letters[1:10], dnn = c('information')))
})

test_that('Drop NA', {
    expect_equal(nrow(dropEmpty_row(mtcars)), nrow(mtcars))
    expect_equal(nrow(dropEmpty_row(rbind(mtcars, NA))), nrow(mtcars))
})

test_that('Plot one variable', {
    expect_equal(plot_oneway(mtcars$mpg, 'mpg')$n, 32)
    expect_equal(plot_oneway(as.factor(mtcars$gear), 'gear'), matrix(c(0.7, 1.9, 3.1), ncol = 1))
})

test_that('Two variables plot', {
    expect_error(plot_twoway(as.factor(mtcars$gear), mtcars$mpg, xvar = 'gear', yvar = 'mpg', pal = 'random'))
    expect_equal(plot_twoway(as.factor(mtcars$gear), mtcars$mpg, xvar = 'gear', yvar = 'mpg'), NULL)
})