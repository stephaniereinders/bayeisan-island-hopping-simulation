library(shiny)
library(tidyverse)

shinyServer(
  function(input, output, session) {
    
    # Keep track of current values and dataframe
    df <- reactiveValues(df_data = NULL)
    current_island <- reactiveValues(islandnum = as.integer(0))
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
      # Set current island to starting island
      current_island$islandnum <- as.integer(input$starting_island)  
      
      # Generate vector of island numbers (number islands seqentially)
      island_nums <- 1:input$num_islands
      
      # Randomly generate island populations with user input maximum population
      island_pops <- sample.int(n=input$max_pop, size=input$num_islands, replace=TRUE)  
      
      # Get total of all island populations
      total_pop = sum(island_pops)
      
      # Create dataframe
      df$df_data <- data.frame("island_nums"=island_nums, 
                               "island_pops"=island_pops,
                               "proportion_of_total_pop"=0,
                               "visits"=as.integer(0),
                               "proportion_of_total_visits"=0)
      
      # Set number of visits of starting island to 1
      df$df_data[current_island$islandnum, 'visits'] <- as.integer(1)
      df$df_data[current_island$islandnum, 'proportion_of_total_visits'] <- as.integer(1)
      
      # Add proportion of total population column
      df$df_data <- df$df_data %>% 
        mutate('proportion_of_total_pop' = island_pops/total_pop)
    })
    
    #--- ON CONSIDER
    observeEvent(input$considerButton, {
      # propose new island
      proposed_island$islandnum <- propose_island(current_island$islandnum, input$num_islands)
    
    })
    
    #--- ON VISIT
    observeEvent(input$visitButton, {
      
      # Decide whether to visit proposed island
      visit_yn <- visit_island_yn(current_island$islandnum, proposed_island$islandnum, df$df_data['island_pops'] )
      
      # If you decided to move, update current island and visits in dataframe
      if (visit_yn == 'y'){
        # set current island to proposed island
        current_island$islandnum <- proposed_island$islandnum
        
        # Add 1 to visit to current_island
        df$df_data[current_island$islandnum, 'visits'] <- as.integer(df$df_data[current_island$islandnum, 'visits'] + 1)
        
        # Recalculate proportion_of_total_visits
        total_visits = sum(df$df_data['visits'])
        df$df_data <- df$df_data %>% 
          mutate(proportion_of_total_visits = visits/total_visits)

      } 
      
    })
    
    #--- DISPLAY
    output$df <- renderTable({
      df$df_data
    })
    
    output$current_island <- renderText({
      paste("Current island is ", current_island$islandnum)
    })
    
    output$proposed_island <- renderText({
      paste("Proposed island is ", proposed_island$islandnum)
    })
    
  }
  
)