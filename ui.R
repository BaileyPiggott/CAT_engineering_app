
# user interface definition
# Engineering CAT data boxplots

library(shiny)

shinyUI(fluidPage(
  
  
  headerPanel("Engineering CAT Scores"), 
  
  sidebarPanel(
    selectInput("discipline", "Discipline:",
                c("Mechanical" = 1, 
                  "Electrical" = 2, 
                  "Computer" = 3,
                  "Civil" = 4,
                  "Chemical" = 5,
                  "Engineering Chemistry" = 6,
                  "Mining" = 7,
                  "Geological" = 8,
                  "Engineering Physics" = 9,
                  "Engineering Math" = 10
                )#end options
    ),#end selectInput
    
    downloadButton("downloadPDF", "Download PDF")
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("catPlot")
  )
  
))
