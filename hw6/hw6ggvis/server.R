library(dplyr)
library(stringr)
library(xml2)
library(rvest)
library(readr)
library(tidyr)
library(plyr)
library(scales)
library(ggvis)


cleaned_demographics = read.csv("cleaned_demographics.csv")

shinyServer(function(input, output) {
  
  df <- reactive({cleaned_demographics %>% 
      filter(year == input$year) %>% 
      filter(lifeexpectancy < 80) %>% 
      filter(gdp > 500)
  })
  
  hover_df = cleaned_demographics
  hover_df$id = 1:nrow(hover_df)

  
  df %>% 
    ggvis(~log10(gdp), ~lifeexpectancy, key := ~country,
          fill = ~region, size = ~population, 
          stroke:= "black", fillOpacity := 0.7) %>% 
    layer_points() %>% 
    scale_numeric("size", range = c(20,2000)) %>%
    add_axis("x",
             ticks = 3,
             title = "GDP Per Capita (Inflation-Adjusted)") %>%
    add_axis("y", 
             title = "Life Expectancy at Birth") %>%

    scale_numeric("x", domain = c(log10(500), log10(120000))) %>%
    scale_numeric("y", domain = c(12, 80)) %>% 

    add_legend("fill") %>% 
    hide_legend("size") %>%

    add_tooltip(function(data)
    {paste0(data$country)}, "hover") %>% 
    bind_shiny("ggvis", "ggvis_ui")
})