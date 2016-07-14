shinyUI(fluidPage(
  titlePanel("Diamonds Graph"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("class", 
                  label = "Choose the factor to compare against price",
                  choices = list("carat", 
                                 "depth",
                                 "table"
                  ),
                  selected = "carat"),
      
      checkboxGroupInput("cut", 
                         label = h3("cut"), 
                         choices = list("Ideal" = "Ideal", 
                                        "Premium" = "Premium", "Good" = "Good",
                                        "Very Good" = "Very Good", "Fair" = "Fair"),
                         selected = "Ideal"),
    
      #D < E < F < G < H < I < J
      checkboxGroupInput("color", 
                         label = h3("color"), 
                         choices = list("J" = "J", 
                                        "I" = "I", "H" = "H",
                                        "G" = "G", "F" = "F",
                                        "E" = "E", "D" = "D"),
                         selected = "J")),
      
    mainPanel(
      plotOutput("diamonds_plot")
    )
    )
  )
)