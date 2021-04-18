library(shiny)
shinyServer(
  function(input, output, session) {
    
    # Keep track of dataframe
    df <- reactiveValues(df_data = NULL)
    
    # Keep track of current island
    current_island <- reactiveValues(islandnum = as.integer(0))
    
    # Keep track of current proposed island
    proposed_island <- reactiveValues(islandnum = as.integer(0))
    
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
    
    #--- ON VISIT
    observeEvent(input$visitButton, {
      # propose new island
      proposed_island$islandnum <- propose_island(current_island$islandnum, input$num_islands)
      # Decide whether to visit proposed island
      visit_yn <- visit_island_yn(current_island$islandnum, proposed_island$islandnum, df$df_data['island_pops'] )
      
      # If you decided to move, update current island and visits in dataframe
      if (visit_yn == 'y'){
        # set current island to proposed island
        current_island$islandnum <- proposed_island$islandnum
        # Add 1 to visits to current_island
        df$df_data[current_island$islandnum, 'visits'] <- as.integer(df$df_data[current_island$islandnum, 'visits'] + 1)  
      } 
      
    })
    
    #--- DISPLAY
    output$df <- renderTable({
      df$df_data
    })
    
    output$proposed_island <- renderText({
      paste("Proposed island is ", proposed_island$islandnum)
    })
    
  }
  
)