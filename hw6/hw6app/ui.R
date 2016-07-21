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
              plotOutput("demo_plot")
              )
  )
))