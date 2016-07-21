
shinyServer(function(input, output) {
  output$diamonds_plot <- renderPlot({
   
    class = input$class
    df = diamonds %>% 
      filter( cut %in% input$cut & color %in% input$color)
    
    ggplot(df, aes_string(y = "price", x = class)) +
      geom_point(fill = "darkgray")
  })
})
