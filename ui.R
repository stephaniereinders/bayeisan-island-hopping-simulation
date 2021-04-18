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
        
        # Buttons
        actionButton("startButton", "Start your trip"),
        actionButton("sub1", "- 1"),
        actionButton("reset", "set to 0"),
        br()
      ),
      
      # Main panel
      mainPanel(
        tableOutput("df")
      )
    )
  )
)