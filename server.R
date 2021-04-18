library(shiny)
shinyServer(
  function(input, output, session) {
    
    # Keep track of dataframe
    df <- reactiveValues(df_data = NULL)
    
    #--- ON START
    observeEvent(input$startButton, {
      island_nums <- 1:input$num_islands
      df$df_data <- data.frame("island_nums"=island_nums)
    })
    
    #--- DISPLAY
    output$df <- renderTable({
      df$df_data
    })
    
  }
  
)