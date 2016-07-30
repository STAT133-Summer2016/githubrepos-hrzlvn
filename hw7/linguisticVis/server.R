library(dplyr)
library(stringr)
library(xml2)
library(rvest)
library(readr)
library(tidyr)
library(plyr)
library(scales)
library(ggplot2)
library(grid)
library(ggmap)
library(mapdata)

lingData <- read.csv("cleaned_lingData.csv")
load("question_data.RData")
states = map_data("state")

shinyServer(function(input, output) {
  output$map <- renderPlot({
    
    question = input$question
    question_index = quest.mat[[1]][quest.mat[[2]] == question]
    
    
    lingData = lingData %>% 
      filter(question == question_index)
    
    lingData = left_join(states, lingData) 
    
    ggplot(lingData) + 
      geom_polygon(aes(x = long, y = lat, fill = answer, group = group), color = "black") + 
      coord_fixed(1.3) + 
      theme(
        axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank()
      ) +
      scale_fill_discrete(labels = scales::wrap_format(10)) +
      labs(title = question) +
      theme(plot.title = element_text(face = "bold"))
      
    
})
})