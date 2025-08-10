library(shiny)
library(shinyjs)
library(shinythemes)

shinyUI(
  fluidPage(
    theme = shinytheme("cerulean"),
    useShinyjs(),
    
    titlePanel("Island Hopping Simulation"),
    
    p("This interactive simulation demonstrates the Metropolis-Hastings algorithm using a charity fundraising scenario. You're traveling between a chain of islands to raise money for charity. To maximize your fundraising success, you need to visit larger islands (with bigger populations) more often than smaller ones. Specifically, the frequency of your visits to each island should be proportional to that island's population size."),
    
    sidebarLayout(
      sidebarPanel(width = 3,
        
        # Parameters
        h4("Choose Parameters for the Simulation"),
        fluidRow(
          column(width = 12, p("Choose the number of islands (between 3 and 20), the starting island, and the maximum possible population for each island. The application will randomly select populations between 1 and the maximum population with replacement.")),
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
          column(width = 12, 
                 p("Click 'Start trip' to begin the simulation. Click 'Visit island' decide whether to move to another island. The data frame below the islands plot tracks the number of visits to each island.")),
          column(width = 6,
                 actionButton("startButton", "Start trip")
            
          ),
          column(width = 6,
                 actionButton("visitButton", "Visit island"),
          )
        ),
        
        br(),
        fluidRow(column(width = 12, 
                        p("Select the desired number of visits on the slider and click 'Simulate n visits' to simulate multiple visits all at once."))),
        
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