library(bslib)
library(shiny)
library(shinyjs)


ui <-  bslib::page_sidebar(
  theme = bslib::bs_theme(version = 5, bootswatch = "minty"),
  title = "Island Hopping Simulation",

  useShinyjs(),
  sidebar = bslib::sidebar(
    
    bslib::accordion(
      bslib::accordion_panel(
        "Introduction",
        p("This interactive simulation demonstrates the Metropolis-Hastings algorithm using a charity fundraising scenario. You're traveling between a chain of islands to raise money for charity. To maximize your fundraising success, you need to visit larger islands (with bigger populations) more often than smaller ones. Specifically, the frequency of your visits to each island should be proportional to that island's population size.")
      ),
      bslib::accordion_panel(
        "Choose Parameters for the Simulation",
        numericInput(inputId = "num_islands", 
                     label = "Number of islands",
                     min = 3,
                     max = 20,
                     value = 5),
        numericInput(inputId = "starting_island", 
                     label = "Starting island",
                     min = 1,
                     max = 20,
                     value = 3),
        numericInput(inputId = "max_pop", 
                     label = "Maximum population of each island",
                     min = 5,
                     max = 50,
                     value = 10)
      ),
      bslib::accordion_panel(
        "Simulations",
        p("Click 'Start trip' to begin the simulation. Click 'Visit island' decide whether to move to another island. The data frame below the islands plot tracks the number of visits to each island."),
        actionButton("startButton", "Start trip"),
        actionButton("visitButton", "Visit island"),
        p("Select the desired number of visits on the slider and click 'Simulate n visits' to simulate multiple visits all at once."),
        sliderInput(inputId="n",
                label="Number of visits",
                value = 250,
                min=2,
                max=10000),
    
        actionButton("simButton", "Simulate n visits"),
      )
    )
  ), # end sidebar
  
  
  h3(textOutput("current_island")),
  br(),
  
  # Plot
  plotOutput("plot_islands", height = "150px"),
  br(),
  
  tableOutput("df"),
  
) # end page_sidebar
