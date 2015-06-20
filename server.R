library(shiny)
library(ellipse)

shinyServer(function(input, output) {
  
    data <- reactive({
      variable <- switch(input$variable,
                     cyl = cyl,
                     disp = disp,
                     hp = hp,
                     wt = wt,
                     am = am,
                     am)
      
      variable(input$variable)
    })
  
  output$mytable1 <- renderPlot({
    cor_mtcars <- cor(mtcars[,1:11])
    colorfun <- colorRamp(c("#CC0000","white","#3366CC"), space="Lab")
    plotcorr(cor_mtcars,col=rgb(colorfun((cor_mtcars+1)/2), maxColorValue=255))
  })
  
  output$mytable2 <- renderDataTable({
    mtcars
  }, options = list(orderClasses = TRUE))
  
  output$mytable3 <- renderPrint({
    summary(mtcars)
  })
  
  output$mytable0 <- renderPrint({
    str(mtcars)
  })
  
  output$mytable4 <- renderPrint({
    
    input$variable
    
    lrm <- lm(mpg ~ mtcars[,c(input$variable)], data = mtcars)
    summary(lrm)
  })
  
  output$mytable5 <- renderPlot({
    
    lrm <- lm(mpg ~ mtcars[,c(input$variable)], data = mtcars)
    par(mfrow = c(2, 2))
    plot(lrm)
  })
  
  
  
  
})