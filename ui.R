
library(shiny)

shinyUI(fluidPage(

    titlePanel(em(strong("Violent Crime Rates by US State"))),

    sidebarLayout(
        sidebarPanel(
            strong("Details"),
            h5("This data set contains statistics, in arrests per 100,000 residents for 
               assault, murder, and rape in each of the 50 US states in 1973. 
               Also given is the percent of the population living in urban areas"),
            radioButtons("option",strong("Crime Type"),c("Murder"="M","Assault"="A","Rape"="R")),
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Heatmap",h3(em(strong(textOutput("choice")))),htmlOutput("map")),
                tabPanel("Table",fluidRow(column(width=6,htmlOutput("table1")),
                                          column(width=6,htmlOutput("table2")))),
                tabPanel("Summary",verbatimTextOutput("summary"),
                         plotOutput("plot",width="650px",height="650px"))
            )
        )
    )
))
