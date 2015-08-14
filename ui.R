
# user interface definition
# Engineering CAT data boxplots

library(shiny)

shinyUI(fluidPage(
  
  
  headerPanel("Engineering CAT Scores"), 
  
  sidebarPanel(
    selectInput("discipline", "Choose Discipline:",
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
    
    downloadButton("downloadPDF", "Download Plot"),
    
    #text description of app ------------------------
    
    br(),br(), 
    h4("About This App"),
    p("This app displays the CAT (Critical Thinking Assessment Test) scores of engineering students from each 
      of the 10 disciplines. This test has a maximum score of 36."),
    p("First and second year samples are the same students who wrote the CAT test both years."),
    br(),
    p("Learn more about the HEQCO Learning Outcomes Assessment Project", 
      a("here.", href = "http://www.queensu.ca/qloa/"))
    # end text description    
    
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("catPlot")
  )
  
))
