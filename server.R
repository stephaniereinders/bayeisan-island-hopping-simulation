library(shiny)
shinyServer(
  function(input, output, session) {
    
    # Keep track of dataframe
    df <- reactiveValues(df_data = NULL)
    
    #--- ON START
    observeEvent(input$startButton, {
      island_nums <- 1:input$num_islands
      island_pops <- sample.int(n=input$max_pop, size=input$num_islands, replace=TRUE)  # Randomly generates pops.
      df$df_data <- data.frame("island_nums"=island_nums, "island_pops"=island_pops)
    })
    
    #--- DISPLAY
    output$df <- renderTable({
      df$df_data
    })
    
  }
  
)