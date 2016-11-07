shinyUI(navbarPage(title = 'shinycsv',
    tabPanel('Explore data',
        sidebarLayout(
            sidebarPanel(
                fileInput('tablefile', 'File to explore',
                    accept = c('text/csv', '.csv',
                    'text/comma-separated-values,text/plain', '.RData',
                    '.Rdata', '.rda', '.Rda', '.tsv', '.csvy', '.feather',
                    '.psv', '.fwf', '.rds', '.RData', '.json', '.yml', '.dta',
                    '.sav', '.por', '.dbf', '.xls', '.xlsx', '.arff', '.R',
                    '.xml', '.html', '.sas7bdat', '.xpt', '.mtp', '.rec',
                    '.syd', '.dif', '.ods')
                ),
                hr(),
                downloadButton('downloadData', 'Download table'),
                width = 2
            ),
            mainPanel( 
                tabsetPanel(
                    tabPanel('Raw Data', DT::dataTableOutput('raw_data')),
                    tabPanel('Raw summary', 
                        downloadLink('download_summary',
                            'Download raw summary'),
                        verbatimTextOutput('raw_summary')
                    ),
                    tabPanel('One variable',
                        uiOutput('summary'),
                        plotOutput('summary_plot'),
                        uiOutput('summary_info')
                    ),
                    tabPanel('Two variables',
                        uiOutput('summary_two_x'),
                        uiOutput('summary_two_y'),
                        actionButton('goTwo', 'Make two-way plot'),
                        plotOutput('summary_plot_two'),
                        tableOutput('summary_table_two')
                    ),
                    tabPanel('Plot colors',
                        p('Select a palette and a color number from the options showed below'),
                        selectInput('palette', 'Color palette',
                            choices = rownames(RColorBrewer::brewer.pal.info),
                            selected = 'Set1'),
                        sliderInput('colorn', 'Color number', value = 2,
                            min = 1, max = 9, step = 1, round = TRUE,
                            ticks = FALSE),
                        plotOutput('colors')
                    ),
                    tabPanel('Documentation',
                        hr(),
                        p('All columns of the ', strong('raw data'), ' table are sortable and searchable. Subsetting on the raw data will affect summary statistics in the other tabs.'),
                        hr(),
                        p('To use this Shiny app you have to upload a file that has a table stored in it. It can be any of the formats described at ', HTML('https://cran.r-project.org/web/packages/rio/vignettes/rio.html'), ' as long as the file only contains one table. For example, a table in the first sheet of a Excel file. If you do not upload any file the example mtcars data set will be shown.'),
                        p('The two-way summary plots can take some time to compute if you have a large data set, that is why you have to click on the ', strong('calculate two-way summary'), ' button to create the plot and update the summary table.')
                    )
                )
            )
        )
    ),
    tabPanel('Help or feedback',
        p('Please get in touch with Stephen Semick and Leonardo Collado-Torres at ', HTML('https://github.com/LieberInstitute/shinycsv')),
        hr(),
        p('The following information will be useful to them:'),
        verbatimTextOutput('session_info'),
        p('Also try to include a small reproducible example so they can figure out what went wrong. Thank you!')
    )
))


