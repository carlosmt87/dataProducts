library(shiny)
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Car Miles per Galon (mpg) prediction" ),
    sidebarPanel(
      h4( 'Select the predictors values:'),
      sliderInput( 'hp',  'Horse Power',  110 , min =  52 , max =  335 , step =  5),
      sliderInput( 'wt',  'Weight',  2 , min =  1.5 , max =  5 , step = 0.1),
      radioButtons('am', label = 'Transmission type',
                   choices = list("Automatic" = 0, "Manual" = 1), 
                   selected = 1)
      
#       ,submitButton('Submit ')
    ),
    mainPanel(
      h4( 'Results  of prediction'),
      verbatimTextOutput( "prediction" ),
      h4( 'Comparing with the distribution of mpg'),
      plotOutput('hist'),
      h4('Documentation'),
      p('This is a simple prediction model of the Miles per Galon (mpg) of a car.'),
      p('The model was built using the mtcars data set from R, which was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models).'),
      p('The predictions are done using a multiple linear regression model, using miles per galon (mpg) as the output variable, and horse power (hp), weigth (wt) and transmission type as predictor variables.'),
      p('The R model details are as follows:'),
      verbatimTextOutput( "modelDetails" )
    )
  )
)