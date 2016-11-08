shinyUI(navbarPage(title = 'shinycsv',
    tabPanel('Explore data',
        sidebarLayout(
            sidebarPanel(
                fileInput('tablefile', 'File to explore'),
                hr(),
                downloadButton('downloadData', 'Download table'),
                helpText('Useful in case you subsetted your data'),
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
                        uiOutput('summary_info'),
                        hr(),
                        p('Code for reproducing the figure:'),
                        verbatimTextOutput('plot_code_one')
                    ),
                    tabPanel('Two variables',
                        uiOutput('summary_two_x'),
                        uiOutput('summary_two_y'),
                        helpText('Sometimes the plot will look better if you swap the X and Y axis variables.'),
                        actionButton('goTwo', 'Make two-way plot'),
                        helpText('If your data set is large, this might take a while. Please be patient!'),
                        plotOutput('summary_plot_two'),
                        verbatimTextOutput('summary_table_two'),
                        hr(),
                        p('Code for reproducing the figure:'),
                        verbatimTextOutput('plot_code_two')
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
                        p('All columns of the ', strong('raw data'), ' table are sortable and searchable. Subsetting on the raw data will affect summary statistics and plots in the other tabs.'),
                        hr(),
                        p('To use this Shiny app you have to upload a file that has a table stored in it. It can be any of the formats described at ', HTML('<a href="https://cran.r-project.org/web/packages/rio/vignettes/rio.html">the rio vignette</a>'), ' as long as the file only contains one table. For example, a table in the first sheet of a Excel file. If you do not upload any file the example mtcars data set will be shown. Files with extensions .fwf or .yml might not work.'),
                        p('The two-way summary plots can take some time to compute if you have a large data set, that is why you have to click on the ', strong('calculate two-way summary'), ' button to create the plot and update the summary table.')
                    )
                )
            )
        )
    ),
    tabPanel('Help or feedback',
        p('Please get in touch with Stephen Semick and Leonardo Collado-Torres at ', HTML('<a href="https://github.com/LieberInstitute/shinycsv/issues">LieberInstitute/shinycsv</a>.')),
        hr(),
        p('The following information will be useful to them:'),
        verbatimTextOutput('session_info'),
        p('Also try to include a small reproducible example so they can figure out what went wrong. Thank you!')
    )
))


