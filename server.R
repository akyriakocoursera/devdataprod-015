library(shiny)
library(ellipse)

shinyServer(function(input, output) {
  
  # a large table, reative to input$show_vars
#   output$mytable1 <- renderDataTable({
#     library(ggplot2)
#     diamonds[, input$show_vars, drop = FALSE]
#   })
  
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
  
  # sorted columns are colored now because CSS are attached to them
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
  
  
  
  # customize the length drop-down menu; display 5 rows per page by default
#   output$mytable3 <- renderDataTable({
#     iris
#   }, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  
})