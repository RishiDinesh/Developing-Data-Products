
library(shiny)
library(ggplot2)
suppressPackageStartupMessages(library(googleVis))

shinyServer(function(input, output) {
  
  choice<-reactive({
    switch(input$option,M="Murder",A="Assault",R="Rape","Murder")
  })
  
  output$choice<-renderText(choice())
  
  output$map<-renderGvis({
    USArrests$State<-row.names(USArrests)
    choice<-choice()
    gvisGeoChart(USArrests,locationvar="State",colorvar = choice,
                 options=list(title="Heated map",
                              region='US',displayMode="regions", resolution="provinces",
                              colorAxis="{colors:['yellow','red']}",width=650,height=650))
  })
  
  output$table1<-renderGvis({
    USArrests$State<-row.names(USArrests)
    choice<-choice()
    gvisTable(USArrests[1:25,c("State",choice)],options = list(width=500))
  })
  
  output$table2<-renderGvis({
    USArrests$State<-row.names(USArrests)
    choice<-choice()
    gvisTable(USArrests[26:50,c("State",choice)],options = list(width=500))
  })
  
  output$summary<-renderText({
    choice<-choice()
    summary(USArrests[choice])
  })
  
  output$plot<-renderPlot({
    choice<-choice()
    switch(choice,Murder=qplot(UrbanPop,Murder,data=USArrests,geom=c("point","smooth")),
              Assault=qplot(UrbanPop,Assault,data=USArrests,geom=c("point","smooth")),
              Rape=qplot(UrbanPop,Rape,data=USArrests,geom=c("point","smooth")),
              qplot(UrbanPop,Murder,data=USArrests,geom=c("point","smooth")))
  })
  
})
