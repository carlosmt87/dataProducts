library(caret)
data(mtcars)
set.seed(333)

mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 
mtcars$vs <- as.factor(mtcars$vs) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),labels=c("Automatic","Manual"))
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$carb <- as.factor(mtcars$carb) 

#Create a simple linear model
lm <- lm(mpg ~ hp + wt + am, data=mtcars)


shinyServer(
  function(input, output) {
    output$ohp  <- renderPrint({ input$hp})
    output$owt  <- renderPrint({ input$wt})
    output$otransmission <- renderPrint({factor(input$am,levels=c(0,1),labels=c("Automatic","Manual"))})
    output$prediction  <- renderPrint({ 
      newdata = data.frame(hp=input$hp, wt=input$wt, am=factor(input$am,levels=c(0,1),labels=c("Automatic","Manual")))
      predMpg <- predict(lm, newdata)
      print(predMpg)
      })
    output$hist <- renderPlot({
      newdata = data.frame(hp=input$hp, wt=input$wt, am=factor(input$am,levels=c(0,1),labels=c("Automatic","Manual")))
      predMpg <- predict(lm, newdata)
      d <- density(mtcars$mpg)
      #hist (mtcars$mpg ,  xlab ='Miles per galon',  col ='lightblue' ,main ='Histogram' )
      plot(d, main="Kernel Density of Miles Per Gallon")
      polygon(d, col="lightblue")
      lines (c(predMpg,  predMpg),  c(0, 200 ), col="red" ,lwd =5)
      text (63 ,  150 , paste (" mpg = ",  mpg ))
      
    })
    output$modelDetails  <- renderPrint({ summary(lm)})
    
  }
)