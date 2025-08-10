library(shiny)
library(shinyjs)
library(shinythemes)

shinyUI(
  fluidPage(
    theme = shinytheme("cerulean"),
    useShinyjs(),
    
    titlePanel("Island Hopping Simulation"),
    
    p("Simulate island hopping using Bayesian statistics and the Metropolis-Hastings algorithm. This interactive simulation demonstrates how populations influence movement decisions in a chain of islands."),
    
    sidebarLayout(
      sidebarPanel(width = 3,
        
        # Parameters
        h4("Choose Parameters for the Simulation"),
        fluidRow(
          column(width = 6,
                 numericInput(inputId = "num_islands", 
                              label = "Number of islands",
                              min = 3,
                              max = 20,
                              value = 5)
          ),
          column(width = 6,
            numericInput(inputId = "starting_island", 
                         label = "Starting island",
                         min = 1,
                         max = 20,
                         value = 3)
          )
        ),
        
        numericInput(inputId = "max_pop", 
                     label = "Maximum population of each island",
                     min = 5,
                     max = 50,
                     value = 10),
        hr(),
        # Buttons
        h4("Simulations"),
        fluidRow(
          column(width = 6,
                 actionButton("startButton", "Start trip")
            
          ),
          column(width = 6,
                 actionButton("visitButton", "Visit island"),
          )
        ),
        
        br(),
        
        sliderInput(inputId="n",
                    label="Number of visits",
                    value = 250,
                    min=2,
                    max=10000),
        
        actionButton("simButton", "Simulate n visits"),
      
      ), # end sidebarPanel
      
      mainPanel(
        
        h3(textOutput("current_island")),
        br(),
        
        # Plot
        plotOutput("plot_islands", height = "150px"),
        br(),
        
        tableOutput("df"),
        
      ) # end mainPanel
    ) # end sidebarLayout
  ) # end fluidPage
) # end shinyUI