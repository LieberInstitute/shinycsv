context('Reading data')

library('rio')


df <- iris
colnames(df) <- gsub('\\.', '', tolower(colnames(iris)))
df$date <- Sys.Date()

export(df, 'iris.xlsx')
save(df, file = 'iris.Rdata')
save(df, file = 'iris.rda')

test_that('reading data', {
    expect_equal(read_table('iris.xlsx')[, 1:4], df[, 1:4])
    expect_equal(read_table('iris.Rdata'), df)
    expect_equal(read_table('iris.rda'), df)
})

unlink(c('iris.xlsx', 'iris.Rdata', 'iris.rda'))
