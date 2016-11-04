shinyUI(navbarPage(title = 'shinycsv',
    tabPanel('Explore data',
        sidebarLayout(
            sidebarPanel(
                fileInput('csv', 'CSV file to explore',
                    accept = c('text/csv', '.csv',
                    'text/comma-separated-values,text/plain')
                ),
                fileInput('rdata', 'Rdata with a data.frame to explore',
                    accept = c('.RData', '.Rdata', '.rda', '.Rda')
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
                    tabPanel('Summary',
                        uiOutput('summary'),
                        plotOutput('summary_plot'),
                        uiOutput('summary_info')
                    ),
                    tabPanel('Two-way summary',
                        uiOutput('summary_two_x'),
                        uiOutput('summary_two_y'),
                        actionButton('goTwo', 'Calculate two-way summary'),
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
                        p('To use this Shiny app you have to upload a csv file that has a header (column names on the first row) or a Rdata file that has a single data.frame object stored in it. If you do not upload any file the example mtcars data set will be shown.'),
                        p('The two-way summary plots can take some time to compute if you have a large data set, that is why you have to click on the ', strong('calculate two-way summary'), ' button to create the plot and update the summary table.')
                    )
                )
            )
        )
    ),
    tabPanel('Help or feedback',
        p('Please get in touch with Stephen Semick and Leonardo Collado-Torres.'),
        hr(),
        p('The following information will be useful to them:'),
        verbatimTextOutput('session_info'),
        p('Also try to include a small reproducible example so they can figure out what went wrong. Thank you!')
    )
))


