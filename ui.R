library(shiny)
shinyUI(
  fluidPage(
    titlePanel("Island Hopping Simulation"),
    
    p("Simulate island hopping using Bayesian statistics and the Metropolis-Hastings algorithm. This interactive simulation demonstrates how populations influence movement decisions in a chain of islands."),
    
    sidebarLayout(
      sidebarPanel(width = 3,
        
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
        br(),
        actionButton("startButton", "Start your trip"),
        actionButton("visitButton", "Visit another island?"),
        
        sliderInput(inputId="n",
                    label="Number of visits to simulate",
                    value = 250,
                    min=2,
                    max=10000),
        
        actionButton("simButton", "Simulate n visits?"),
      
      ), # end sidebarPanel
      
      mainPanel(
        
        hr(),
        textOutput("current_island"),
        br(),
        hr(),
        
        fluidRow(
          column(6,
                 # Plot
                 plotOutput("plot_islands"),
                 br(),
          ),
          column(6,
                 # Data
                 tableOutput("df"),
                 br(),
          )
        )
      ) # end mainPanel
    ) # end sidebarLayout
  ) # end fluidPage
) # end shinyUI