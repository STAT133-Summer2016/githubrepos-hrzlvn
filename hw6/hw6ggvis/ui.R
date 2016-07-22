library(dplyr)
library(stringr)
library(xml2)
library(rvest)
library(readr)
library(tidyr)
library(plyr)
library(scales)
library(ggvis)

shinyUI(fluidPage(
  titlePanel("Life Expectancy and Income"),
  
  sidebarLayout(
    sidebarPanel(
                 sliderInput("year",
                             label = h5("Year:"),
                             min = 1800,
                             max = 2015,
                             value = 1800, 
                             format = "####", 
                             step = 1,
                             animate=TRUE
                             )),
    mainPanel(
      uiOutput("ggvis_ui"),
      ggvisOutput("ggvis")
      )
  )
))