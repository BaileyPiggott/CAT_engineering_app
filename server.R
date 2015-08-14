

source("setup_eng_cat.R") # load libraries and set up dataframes for each discipline


shinyServer(function(input, output) {
  
  plotInput <- reactive({
    
    if(input$discipline == 1){
      df = mech
      disc_name = "Mechanical Engineering" # text string for title and legend
    }
    else if(input$discipline == 2){
      df = elec
      disc_name = "Electrical Engineering"
    }
    else if(input$discipline == 3){
      df = cmpe
      disc_name = "Computer Engineering"
    } 
    else if(input$discipline == 4){
      df = civl
      disc_name = "Civil Engineering"
    }    
    else if(input$discipline == 5){
      df = chem
      disc_name = "Chemical Engineering"
    } 
    else if(input$discipline == 6){
      df = ench
      disc_name = "Engineering Chemistry"
    } 
    else if(input$discipline == 7){
      df = mine
      disc_name = "Mining Engineering"
    } 
    else if(input$discipline == 8){
      df = geoe
      disc_name = "Geological Engineering"
      dummy <- fix
    } 
    else if(input$discipline == 9){
      df = enph
      disc_name = "Engineering Physics"
    } 
    else if (input$discipline == 10){
      df = mthe
      disc_name = "Math and Engineering"
    }
    else{
      df = fix # df is row bound to all eng ; don't want data twice and fix is a null data frame
      disc_name = "Engineering"
    }
    
    # set up data frame and titles for graph:
    
    #calculate sample sizes:
    n_1 <-  sum(with(df, year == 1 & score > 1), na.rm = TRUE)     
    year1 <- paste0("First Year\nn = ", n_1, "   n = ", n_eng_1) #text for xlabel &sample size
    n_2 <-  sum(with(df, year ==2 & score > 1), na.rm = TRUE)     
    year2 <- paste0("Second Year\nn = ", n_2, "   n = ", n_eng_2) #text string for xlabel
    n_3 <-  sum(with(df, year == 3 & score > 1), na.rm = TRUE)     
    year3 <- paste0("Third Year\nn = ", n_3, "   n = ", n_eng_3) #text string for xlabel
    n_4 <-  sum(with(df, year == 4 & score > 1), na.rm = TRUE)     
    year4 <- paste0("Fourth Year\nn = ", n_4, "   n = ", n_eng_4) #text string for xlabel
    

    # set up data frame and title
    data <- bind_rows(df, all_eng, fix) # combine with all queens data
    graph_title <- paste0(disc_name,  " CAT Scores")
    
    
## plot description -------------------------
    
ggplot(
  data = data, 
  aes(x = as.factor(year), y = score, fill = discipline)
  ) +
  geom_boxplot(
    width = 0.5
    ) +     
  coord_cartesian(xlim = c(0.5,4.5),ylim = c(0, 40)) +
  scale_x_discrete(labels = c(year1, year2, year3, year4)) + 
  labs(title = graph_title, x = "Year", y = "CAT Score")  +
  scale_fill_manual(
    values =  c("darkgoldenrod1", "steelblue3"),
    labels = c(disc_name, "All Engineering")
    )+
  theme(
    panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
    panel.grid.major.y = element_line("grey"), #change horizonatal line colour (from white)
    panel.background = element_rect("white"), #change background colour
    panel.grid.major.x = element_blank(),
    legend.title = element_blank(), #remove legend title
    legend.key = element_blank(), #remove grey background from legend items
    plot.title = element_text(size = 15),
    axis.title.x = element_blank(), # remove x axis title
    axis.title.y = element_text(size = 14),
    axis.text = element_text(size = 12) #size of x axis labels
    ) 


  }#end plot expression
  ) #end render plot
  
  
  # plot graph
  output$catPlot <- renderPlot({
    ggsave("plot.pdf", plotInput())
    plotInput()  
  })
  
  
  # download pdf of graph
  output$downloadPDF <- downloadHandler(
    filename = function() {"plot.pdf"},
    content = function(file) {
      file.copy("plot.pdf", file, overwrite=TRUE)
    }
  )
  
}#end function
) #end shiny server
