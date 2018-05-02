library('shinycsv')
library('RColorBrewer')
library('DT')
library('shiny')
library('devtools')
library('ggedit')
library('ggplot2')
library('plotly')
library('GGally')
library('shinyjs')
#library('shinyAce')

if(Sys.getenv('SHINY_PORT') == '') {
    options(shiny.maxRequestSize = 500 * 1024^2)
} else {
    options(shiny.maxRequestSize = 25 * 1024^2)
}

shinyServer(function(input, output, session) {
      
    fullData <- reactive({
        if(!is.null(input$tablefile)) {
#            print(input$tablefile$datapath)
#            print(input$tablefile$name)
            df <- read_table(input$tablefile$datapath, input$tablefile$name)
        } else {
            df <- mtcars
            df$cyl <- as.factor(df$cyl)
            df$vs <- as.factor(df$vs)
            df$am <- as.factor(df$am)
            df$gear <- as.factor(df$gear)
        }
        df <- dropEmpty_row(df)
        return(df)
    })
    
    selectedData <- reactive({
        fullData()[input$raw_data_rows_all, , drop = FALSE]
    })
    
    observeEvent(input$palette, {
        updateSliderInput(session, 'colorn',
            max = brewer.pal.info$maxcolors[
            rownames(brewer.pal.info) == input$palette], value = 2)
    })
    
    selectedColor <- reactive({
        brewer.pal(brewer.pal.info$maxcolors[
            rownames(brewer.pal.info) == input$palette],
            input$palette)[input$colorn]
    })
    
    selectInfo <- reactive({
        selectedData()[, input$summary_var]
    })
    
    ## Raw data
    output$raw_data <- DT::renderDataTable(
        DT::datatable( dropEmpty_row ( fullData() ),
            style = 'bootstrap', rownames = FALSE, filter = 'top',
            options = list(pageLength = 10) )
    )
    
    ## Raw summary
    output$raw_summary <- renderPrint(
        summary( selectedData() ),
        width = 80
    )
    
    ## Input options for which variable to plot
    output$summary <- renderUI({
        selectInput('summary_var', 'Variable to display',
            sort(colnames(selectedData())) )
    })
    
    ## One variable plot
    output$summary_plot <- renderPlot({
        plot_oneway(selectedData()[, input$summary_var], input$summary_var, selectedColor())
    })
    
    ## One variable summary: type of summary depends on the type of variable
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
    
    ## Code for one variable plot
    output$plot_code_one <- renderPrint({
        if(is.null(input$tablefile)) {
            code <- plot_code(filename = 'mtcars.csv', fulldata = mtcars,
            selection = input$raw_data_rows_all, x = input$summary_var,
            color = selectedColor(), pal = input$palette)
        } else {
            code <- plot_code(input$tablefile$name, fulldata = selectedData(),
            selection = input$raw_data_rows_all, x = input$summary_var,
            color = selectedColor(), pal = input$palette)
        }
        cat(code)
    })
    
    
    ## Input options for displaying two variables
    output$summary_two_x <- renderUI({
        selectInput('summary_var_x', 'Variable to display on X axis',
            sort(colnames(selectedData())) )
    })
    output$summary_two_y <- renderUI({
        selectInput('summary_var_y', 'Variable to display on Y axis',
            sort(colnames(selectedData())) )
    })
    
    ## Two-way plot
    output$summary_plot_two <- renderPlot({
        input$goTwo
        
        x <- isolate(selectedData()[, input$summary_var_x])
        y <- isolate(selectedData()[, input$summary_var_y])
        isolate(plot_twoway(x, y, input$summary_var_x, input$summary_var_y,
            selectedColor(), input$palette))
    })
    
    ## Two-way table
    output$summary_table_two <- renderPrint({
        input$goTwo
        
        x <- isolate(selectedData()[, input$summary_var_x])
        y <- isolate(selectedData()[, input$summary_var_y])
        if(length(x) == 0) return(NULL)
        isolate(table(x, y, useNA = 'ifany'))
    }, width = 60)
    
    ## Code for two-way plot
    output$plot_code_two <- renderPrint({
        input$goTwo
        
        if(is.null(input$tablefile)) {
            code <- plot_code(filename = 'mtcars.csv', fulldata = mtcars,
            selection = input$raw_data_rows_all, x = input$summary_var_x,
            y = input$summary_var_y, color = selectedColor(),
            pal = input$palette)
        } else {
            code <- plot_code(input$tablefile$name, fullData(),
            selection = input$raw_data_rows_all, x = input$summary_var_x,
            y = input$summary_var_y, color = selectedColor(),
            pal = input$palette)
        }
        cat(code)
    })
    
    
    ## Testing area
    output$summary_two_col <- renderUI({
        selectInput('summary_var_col', 'Variable to use for coloring (if possible)',
            c('', sort(colnames(selectedData()))) )
    })
    
   #
   #  plot_pairs <- reactiveVal()
   #
   #  observe({
   #      input$goTwo
   #
   #      plot_data <- isolate(selectedData()[, c(input$summary_var_x, input$summary_var_y, input$summary_var_col)])
   #      if(length(plot_data) != 0) {
   #          p <- isolate(if(input$summary_var_col == '') ggpairs(plot_data, columns = 1:2) else ggpairs(plot_data, columns = 1:2, aes_(colour = as.name(input$summary_var_col))))
   #          plot_pairs(p)
   #      } else {
   #          plot_pairs(ggmatrix(list(ggplot()), nrow = 2, ncol = 2))
   #      }
   #  })
   #
   # outGGedit <- callModule(ggEdit, 'ggEditOut', obj = reactive(list(p1 = plot_pairs()[1, 2], p2 = plot_pairs()[2, 1])), showDefaults = TRUE)
   
   
   

    plot_pairs <- reactive({
        input$goTwo
        
        if(length(input$summary_var_col) != 0) {
            plot_data <- isolate(if(input$summary_var_col == '') selectedData()[, c(input$summary_var_x, input$summary_var_y)] else selectedData()[, c(input$summary_var_x, input$summary_var_y, input$summary_var_col)])
        } else {
            plot_data <- NULL
        }
#        if(!is.factor(plot_data[, 3])) plot_data[, 3] <- as.factor(plot_data[, 3])
        if(length(plot_data) == 0) {
            #ggmatrix(list(ggplot()), nrow = 2, ncol = 2)
            return(NULL)
        } else {
            isolate(if(input$summary_var_col == '') ggpairs(plot_data, columns = 1:2) else ggpairs(plot_data, columns = 1:2, aes_(colour = as.name(input$summary_var_col))))
        }
    })



    observe({
        input$goTwo
        p <- isolate(plot_pairs())
        if(!is.null(p)) {
            outGGedit <- callModule(ggEdit, 'ggEditOut', obj = reactive(
                list(
                    'p1 (1,1): X' = p[1, 1],
                    'p2 (1,2): X vs Y' = p[1, 2],
                    'p3 (2,1): Y vs X' = p[2, 1],
                    'p4 (2,2): Y' = p[2, 2])
                ), showDefaults = TRUE, session = session)
        } else {
            outGGedit <- NULL
        }
        shinyjs::disable('SetThemeGlobal')

    })
    

    
    
    output$plot_test <- renderPlot({
        input$goTwo
        p <- isolate(plot_pairs())
        if(!is.null(p)) {
            return(p)
        } else{
            return(NULL)
        }
    })
    
    output$plot_plotly <- renderPlotly({
        input$goTwo
        p <- isolate(plot_pairs())
        if(!is.null(p)) {
            return(isolate(ggplotly(p)))
        } else{
            return(NULL)
        }
    })
        
    
   
    ## Download selected data
    output$downloadData <- downloadHandler(
        filename = function() {
            paste0('shinycsv_selection_', Sys.time(), '.csv')
        },
        content = function(file) {
            write.csv(selectedData(), file, row.names = FALSE)
        }
    )
    
    ## Download raw summary table
    output$download_summary <- downloadHandler(
        filename = function() {
            paste0('shinycsv_raw_summary_', Sys.time(), '.csv')
        },
        content = function(file) {
            write.csv(summary(selectedData()), file = file, na = '',
                row.names = FALSE)
        }
    )
    
    ## Colors
    output$colors <- renderPlot({display.brewer.all()}, height = 800)

    ## Reproducibility info
    output$session_info <- renderPrint(session_info(), width = 120)
    
    
})
        