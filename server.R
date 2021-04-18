library(shiny)
shinyServer(
  function(input, output, session) {
    
    # Keep track of dataframe
    df <- reactiveValues(df_data = NULL)
    
    # Keep track of current island
    current_island <- reactiveValues(islandnum = as.integer(0))
    
    # Update starting island slider
    observe({
      max_val <- input$num_islands
      # Control the value, min, max, and step.
      # Step size is 2 when input value is even; 1 when value is odd.
      updateSliderInput(session, "starting_island", max=max_val)
    })
    
    #--- ON START
    observeEvent(input$startButton, {
      current_island$islandnum <- as.integer(input$starting_island)  # Set current island to starting island
      island_nums <- 1:input$num_islands
      island_pops <- sample.int(n=input$max_pop, size=input$num_islands, replace=TRUE)  # Randomly generates pops.
      df$df_data <- data.frame("island_nums"=island_nums, "island_pops"=island_pops, "visits"=as.integer(0))
      df$df_data[current_island$islandnum, 'visits'] <- as.integer(1)  # Set number of visits of starting island to 1
    })
    
    #--- DISPLAY
    output$df <- renderTable({
      df$df_data
    })
    
  }
  
)