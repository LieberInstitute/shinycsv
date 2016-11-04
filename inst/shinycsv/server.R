library('shiny')
library('DT')
library('devtools')
library('RColorBrewer')
library('shinycsv')


shinyServer(function(input, output, session) {
      
    selectedData <- reactive ({
        if(!is.null(input$csv)) {
            df <- read.csv(input$csv$datapath, check.names = FALSE,
                na.strings = c('NA', '', 'not filled in', 'Not Filled in',
                'Unknown'))
        } else if (!is.null(input$rdata)) {
            objname <- local({
               load(input$rdata$datapath)
               ls()[1]
            })
            loadObj <- function(objname) {
                load(input$rdata$datapath)
                get(objname)
            }
            df <- loadObj(objname) 
            stopifnot(is.data.frame(df))
        } else {
            df <- mtcars
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
    })
    
    observeEvent(input$palette, {
        updateSliderInput(session, 'colorn', max = brewer.pal.info$maxcolors[rownames(brewer.pal.info) == input$palette], value = 2)
    })
    
    selectedColor <- reactive({
        brewer.pal(brewer.pal.info$maxcolors[rownames(brewer.pal.info) == input$palette], input$palette)[input$colorn]
    })
    
    selectInfo <- reactive({
        dropEmpty_row ( selectedData() )[input$raw_data_rows_all, input$summary_var]
    })
    
    ## Raw data
    output$raw_data <- DT::renderDataTable(
        DT::datatable( dropEmpty_row ( selectedData() ),
            style = 'bootstrap', rownames = FALSE, filter = 'top',
            options = list(pageLength = 10) )
    )
    
    ## Raw summary
    output$raw_summary <- renderPrint(
        summary( dropEmpty_row ( selectedData() )[input$raw_data_rows_all, ] ),
        width = 80
    )
    
    ## Input options for which variable to plot
    output$summary <- renderUI({
        selectInput('summary_var', 'Variable to display',
            sort(colnames(selectedData())) )
    })
    
    output$summary_plot <- renderPlot({
        info <- dropEmpty_row ( selectedData() )[input$raw_data_rows_all, input$summary_var]
        plot_summary(info, input$summary_var, selectedColor())
    })
    
    output$summary_two_x <- renderUI({
        selectInput('summary_var_x', 'Variable to display on X axis',
            sort(colnames(selectedData())) )
    })
    output$summary_two_y <- renderUI({
        selectInput('summary_var_y', 'Variable to display on Y axis',
            sort(colnames(selectedData())) )
    })
    output$summary_plot_two <- renderPlot({
        input$goTwo
        
        x <- isolate(dropEmpty_row ( selectedData() )[input$raw_data_rows_all, input$summary_var_x])
        y <- isolate(dropEmpty_row ( selectedData() )[input$raw_data_rows_all, input$summary_var_y])
        isolate(plot_twoway(x, y, input$summary_var_x, input$summary_var_y, selectedColor(), input$palette))
    })
    
    output$summary_table_two <- renderTable({
        input$goTwo
        
        x <- isolate(dropEmpty_row ( selectedData() )[input$raw_data_rows_all, input$summary_var_x])
        y <- isolate(dropEmpty_row ( selectedData() )[input$raw_data_rows_all, input$summary_var_y])
        if(length(x) == 0) return(NULL)
        table(x, y)
    })
    
    output$summary_info <- renderUI({
        info <- selectInfo()
        if(class(info) == 'numeric') {
            verbatimTextOutput('summary_stat')
        } else {
            tableOutput('summary_table')
        }
    })
    
    output$summary_stat <- renderPrint({ stat_summary(selectInfo()) },
        width = 60)
    
    output$summary_table <- renderTable({
        table_summary(selectInfo())        
    })
    
    output$downloadData <- downloadHandler(
        filename = function() { paste0('shinycsv_selection_', Sys.time(), '.csv') },
        content = function(file) {
            current <- dropEmpty_row(selectedData() )[input$raw_data_rows_all, ]
            write.csv(current, file, row.names = FALSE)
        }
    )
    
    output$download_summary <- downloadHandler(
        filename = function() {
            paste0('shinycsv_raw_summary_', Sys.time(), '.csv')
        },
        content = function(file) {
            write.csv(summary(
                dropEmpty_row(selectedData())[input$raw_data_rows_all, ] ),
                file = file, na = '', row.names = FALSE)
        }
    )

    ## Reproducibility info
    output$session_info <- renderPrint(session_info(), width = 120)
    
    ## Colors
    output$colors <- renderPlot({display.brewer.all()}, height = 800)
})
        