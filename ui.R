library(shiny)
library(ggplot2) 

shinyUI(fluidPage(
  titlePanel("Motor Trend Car Road Tests"),
  title = 'Examples of DataTables',
  sidebarLayout(
    sidebarPanel(
      radioButtons("variable", "Linear Regression Model  mpg ~ ",
                   c(
                     "Number of cylinders" = "cyl",
                     "Displacement" = "disp",
                     "Gross horsepower" = "hp",
                     "Weight (lb/1000)" = "wt",
                     "Transmission" = "am")),
      br(),
      
      conditionalPanel(
        'input.dataset === "mtcars"',
        helpText('Click the column header to sort a column.')
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Structure', verbatimTextOutput('mytable0')),
        tabPanel('Summary', verbatimTextOutput('mytable3')),
        tabPanel('Data', dataTableOutput('mytable2')),
        tabPanel('Correlations', plotOutput('mytable1')),
        tabPanel('Model', verbatimTextOutput('mytable4')),
        tabPanel('Diagnostic Plots', plotOutput('mytable5'))
      )
    )
  )
))      