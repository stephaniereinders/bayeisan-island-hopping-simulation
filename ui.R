library(shiny)
shinyUI(
  fluidPage(
    #--- new
    # Title
    titlePanel("Simple counter using reactiveValues() - An example"),
    
    sidebarLayout(      
      
      # Side panel
      sidebarPanel(
        actionButton("add1", "+ 1"),
        actionButton("sub1", "- 1"),
        actionButton("reset", "set to 0"),
        br()
      ),
      
      # Main panel
      mainPanel(
        textOutput("count")
      )
    )
  )
)