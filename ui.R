library(shiny)
shinyUI(
  fluidPage(
    #--- new
    # Title
    titlePanel("Simple counter using reactiveValues() - An example"),
    
    sidebarLayout(      
      
      # Side panel
      sidebarPanel(
        
        # Parameters
        numericInput(inputId = "num_islands", 
                     label = "Number of islands:",
                     min = 3,
                     max = 20,
                     value = 5),
        
        numericInput(inputId = "max_pop", 
                     label = "Maximum population of each island:",
                     min = 5,
                     max = 50,
                     value = 10),
        
        numericInput(inputId = "starting_island", 
                     label = "Starting island:",
                     min = 1,
                     max = 20,
                     value = 3),
        
        # Buttons
        actionButton("startButton", "Start your trip"),
        actionButton("visitButton", "Visit another island?"),
        br()
      ),
      
      # Main panel
      mainPanel(
        tableOutput("df"),
        textOutput("proposed_island")
      )
    )
  )
)