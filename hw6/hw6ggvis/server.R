library(dplyr)
library(stringr)
library(xml2)
library(rvest)
library(readr)
library(tidyr)
library(plyr)
library(scales)
library(ggplot2)
library(ggvis)

cleaned_demographics = read.csv("cleaned_demographics.csv")

shinyServer(function(input, output) {
 #which_year = reactive({year = input$year})
  #input_year <- reactive(input$year)
  cleaned_demographics %>% 
      filter(year == 2015) %>% 
      ggvis(~gdp, ~lifeexpectancy, 
            fill = ~region, size = ~population, 
            stroke:= "black", fillOpacity := 0.7) %>% 
      layer_points() %>% 
      add_axis("x", title = "GDP Per Capita (Inflation-Adjusted)") %>%
      add_axis("y", title = "Life Expectancy at Birth") %>%
      add_legend(c("fill","size")) %>% 
      bind_shiny("ggvis", "ggvis_ui")

})
