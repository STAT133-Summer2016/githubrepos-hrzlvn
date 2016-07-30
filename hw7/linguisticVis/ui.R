library(knitr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata) 
library(dplyr)
library(stringr)
library(rvest)
library(readr)
library(tidyr)
library(shiny)
lingData <- read_csv("cleaned_lingData.csv")
questions = unique(lingData$question, na.rm = TRUE)
load('question_data.RData')
questions = quest.mat[[2]][questions]
questions = questions[!is.na(questions)]
shinyUI(fluidPage(
  
  titlePanel("Liguistic Survey Spatial Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select the question"),
      
      selectInput("question", 
                  label = h5("Select the question"),
                  choices = as.list(questions),
                  selected = questions[1])
    ),
    mainPanel(
      plotOutput("map")
    )
  )
))