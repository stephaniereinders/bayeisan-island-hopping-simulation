library(shiny)
shinyUI(
  fluidPage(
    titlePanel("Island Hopping Simulation"),
    
    fluidRow(
      column(3,
      # Data
      tableOutput("df"),
      br(),
      )
    ),
    
    hr(),
    textOutput("current_island"),
    br(),
    hr(),
    
    fluidRow(      
      column(3,
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
                     value = 3)
        ),
      column(4,
        
        # Buttons
        br(),
        actionButton("startButton", "Start your trip"),
        actionButton("visitButton", "Visit another island?"),
        
        sliderInput(inputId="n",
                    label="Number of visits to simulate",
                    value = 250,
                    min=2,
                    max=10000),
        
        actionButton("simButton", "Simulate n visits?"),
        br()
        )
      )
    )
  )