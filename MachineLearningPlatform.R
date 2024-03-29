#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(readxl)

pcalist <- c('PC1','PC2','PC3','PC4','PC5')
Fileupload <- c('csv','xlsx','xls','other/forgein')
data_base_connections <- c('Microsft SQL Server','Oracle',
                            'PostgreSQL','Amazon Redshift',
                             'Apache Hive','Apache Impala','Salesforce','Teradata')
colChoices <- c('positivity','anger','anticipation','disgust','fear','joy',
                'sadness','surprise','trust')
allChoices <- c('PC1','PC2','PC3','PC4','PC5',
                'positivity','anger','anticipation','disgust','fear','joy',
                'sadness','surprise','trust')

# Define UI for application that draws a histogram
ui <- fluidPage(

###### Machine Learing Ui########

    navbarPage("Machine Learning Platform",
               
               ###Database/File upload tab#####
               
               tabPanel("Database/File setup",
                        fluidPage(
                            sidebarLayout(
                                    position = 'left',
                                    sidebarPanel("DataInput",
                                    checkboxInput("Database_Input","Database",FALSE),
                                    checkboxInput("file_Input","File",FALSE),
                                    selectInput("databaseformat","Database format",choices = data_base_connections),
                                    textInput("dbserver", "Servername",value=""),
                                    textInput("dbname", "dbname",value =""),
                                    fileInput("fileupload", "file",multiple = FALSE,accept = c("text/csv",
                                                                                               "text/comma-separated-values,text/plain",
                                                                                               ".csv"),buttonLabel = "Upload file")
                                            ),
                                    mainPanel(
                                    tabsetPanel(id = 'Initial_data',
                                                tabPanel("Database Upload",value="dbload"),
                                                tabPanel("Database Upload",value="dbload",tableOutput("Database view")),
                                                tabPanel("File Upload",value="fileloadload",tableOutput("File view")),
                                                tabPanel("Summary View",DT::dataTableOutput("Summary view")),
                                                tabPanel("Pre-Cleaning",tableOutput("Pre-Cleaning view"))
                                                )
                                             )
                                        )
                                )
                     )
            ,
               #####PreProccessing Tab#####
               navbarMenu("Data/Cleaning - Visual plots",
               tabPanel("Pre Analysis/Statisitcs",
                        fluidPage(sidebarLayout(
                            sidebarPanel(
                                selectInput("investigation", "Plot",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph','Scatter')),
                                selectInput("investigationx", "X",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                selectInput("investigationy", "Y",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                checkboxInput("summary", "Summary View",
                                            value = T),
                                
                                
                                
                                
                                actionButton("update", "Update")
                            ),
                            
                            mainPanel(verbatimTextOutput("summary"),
                                      tableOutput("view"),
                                      tableOutput("view")
                                      
                                        )
                                    )
                                )
                        ),
               tabPanel("Graphical Analytics",
                        fluidPage(sidebarLayout(
                            sidebarPanel(
                                selectInput("Feature/Features",
                                            "Data columns",
                                            "features"),
                                
                                selectInput("PlotType", "Plot Type",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph','Scatter')),
                                selectInput("univariate", "Feature",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                selectInput("investigation_x", "X",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                selectInput("investigation_y", "Y",
                                            choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                
                                
                                
                                
                                actionButton("update", "Update")
                            ),
                            
                            mainPanel(verbatimTextOutput("summary"),
                                      tableOutput("view"),
                                      tableOutput("view")
                                      
                            )
                        )
                        )
               ),
               tabPanel("Univariate analytics",
                        fluidPage(sidebarLayout(
                            sidebarPanel(
                                selectInput("variables",
                                            "Features",
                                            c("f1","f2","f3")),
                                selectInput("plot_type", "Plot",
                                            choices = c("Histogram","Bar Graph","Column Graph")),

                                
                                checkboxInput("featuresummary","Display Summary",value = FALSE),
                                
                                
                                
                                
                                actionButton("Plot/Update", "Update")
                            ),
                            
                            mainPanel(verbatimTextOutput("summary"),
                                      tableOutput("view")
                            )
                        )
                        )
               ),tabPanel("Multivariatre Analysis",
                          fluidPage(sidebarLayout(
                              sidebarPanel(
                                  selectInput("variable1",
                                              "Features 1",
                                              c("f1","f2","f3")),
                                  selectInput("variable2",
                                              "Features 2",
                                              c("f1","f2","f3")),
                                  selectInput("plot_type", "Plot",
                                              choices = c("Histogram","Bar Graph","Column Graph")),
                                  
                                  
                                  checkboxInput("CrossTabsummary","Display Cross Tab",value = FALSE),
                                  checkboxInput("featuresummary","Display Summary",value = FALSE),
                                  
                                  
                                  
                                  
                                  actionButton("Plot/Update", "Update")
                              ),
                              
                              mainPanel(verbatimTextOutput("summary"),
                                        tableOutput("view")
                              )
                          )
                          )
               ),
               tabPanel("Data Cleaning and imputation",
                         fluidPage(sidebarLayout(
                             sidebarPanel(
                                 selectInput("variables",
                                             "Features",
                                             c("f1","f2","f3")),
                                 selectInput("plot_type", "Plot",
                                             choices = c("Histogram","Bar Graph","Column Graph")),
                                 
                                 
                                 checkboxInput("featuresummary","Display Summary",value = FALSE),
                                 
                                 
                                 
                                 
                                 actionButton("Plot/Update", "Update")
                             ),
                             
                             mainPanel(verbatimTextOutput("summary"),
                                       tableOutput("view")
                             )
                         )
                         )
               ),
               tabPanel("Normalisation and Transformation",
                        fluidPage(sidebarLayout(
                            sidebarPanel(
                                selectInput("variables",
                                            "Features",
                                            c("f1","f2","f3")),
                                selectInput("Transformation", "Transformation Technique",
                                            choices = c("Normalise","Standardise")),
                                selectInput("Normalise_method", "Normalise Technique",
                                            choices = c("max/min","Histogram","Bar Graph","Column Graph")),
                                selectInput("Standardise_method", "Standardise Technique",
                                            choices = c("Best Methode","Histogram","Bar Graph","Column Graph")),
                                
                                
                                checkboxInput("Normalise_summary","Normalise Summary",value = FALSE),
                                checkboxInput("Standardise_summary","Normalise Summary",value = FALSE),
                                
                                
                                
                                
                                actionButton("Update", "Update")
                            ),
                            
                            mainPanel(verbatimTextOutput("summary"),
                                      tableOutput("view"),
                                      plotOutput("HistOld"),
                                      plotOutput("HistTransfomed")
                            )
                        )
                        )
               ),
               tabPanel("Data Selection",
                        fluidPage(sidebarLayout(
                            sidebarPanel(
                                selectInput("variables",
                                            "Features",
                                            c("f1","f2","f3")),
                                selectInput("plot_type", "Plot",
                                            choices = c("Histogram","Bar Graph","Column Graph")),
                                
                                
                                checkboxInput("featuresummary","Display Summary",value = FALSE),
                                
                                
                                
                                
                                actionButton("Plot/Update", "Update")
                            ),
                            
                            mainPanel(verbatimTextOutput("summary"),
                                      tableOutput("view")
                            )
                        )
                        )
               )
               
                    ),
               #####Model Selection#####
               navbarMenu("Model Selection",
                          tabPanel("Regression",
                                   fluidPage(sidebarLayout(
                                       sidebarPanel(
                                           selectInput("features",
                                                       "Data columns",
                                                       "features"),
                                           selectInput("investigation_type", "Univaraite/Parwise",
                                                       choices = c("Univaraite","Parewise")),
                                           selectInput("investigation", "Plot",
                                                       choices = c('BoxPlot','Histogram','Bar Graph','Column Graph','Scatter')),
                                           selectInput("investigation", "X",
                                                       choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                           selectInput("investigation", "Y",
                                                       choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                           
                                           
                                           
                                           
                                           actionButton("update", "Update")
                                       ),
                                       
                                       mainPanel(verbatimTextOutput("summary"),
                                                 tableOutput("view")
                                       )
                                   )
                                   )
                          ),
                          tabPanel("Classification",
                                   fluidPage(sidebarLayout(
                                       sidebarPanel(
                                           selectInput("variables",
                                                       "Features",
                                                       c("f1","f2","f3")),
                                           selectInput("plot_type", "Plot",
                                                       choices = c("Histogram","Bar Graph","Column Graph")),
                                           
                                           
                                           checkboxInput("featuresummary","Display Summary",value = FALSE),
                                           
                                           
                                           
                                           
                                           actionButton("Plot/Update", "Update")
                                       ),
                                       
                                       mainPanel(verbatimTextOutput("summary"),
                                                 tableOutput("view")
                                       )
                                   )
                                   )
                          ),tabPanel("Multivariate regression",
                                     fluidPage(sidebarLayout(
                                         sidebarPanel(
                                             selectInput("variable1",
                                                         "Features 1",
                                                         c("f1","f2","f3")),
                                             selectInput("variable2",
                                                         "Features 2",
                                                         c("f1","f2","f3")),
                                             selectInput("plot_type", "Plot",
                                                         choices = c("Histogram","Bar Graph","Column Graph")),
                                             
                                             
                                             checkboxInput("CrossTabsummary","Display Cross Tab",value = FALSE),
                                             checkboxInput("featuresummary","Display Summary",value = FALSE),
                                             
                                             
                                             
                                             
                                             actionButton("Plot/Update", "Update")
                                         ),
                                         
                                         mainPanel(verbatimTextOutput("summary"),
                                                   tableOutput("view")
                                         )
                                     )
                                     )
                          ),
                          tabPanel("Multivariate Classification",
                                   fluidPage(sidebarLayout(
                                       sidebarPanel(
                                           selectInput("variables",
                                                       "Features",
                                                       c("f1","f2","f3")),
                                           selectInput("plot_type", "Plot",
                                                       choices = c("Histogram","Bar Graph","Column Graph")),
                                           
                                           
                                           checkboxInput("featuresummary","Display Summary",value = FALSE),
                                           
                                           
                                           
                                           
                                           actionButton("Plot/Update", "Update")
                                       ),
                                       
                                       mainPanel(verbatimTextOutput("summary"),
                                                 tableOutput("view")
                                       )
                                   )
                                   )
                          ),
                          tabPanel("Time Series",
                                   fluidPage(sidebarLayout(
                                       sidebarPanel(
                                           selectInput("variables",
                                                       "Features",
                                                       c("f1","f2","f3")),
                                           selectInput("plot_type", "Plot",
                                                       choices = c("Histogram","Bar Graph","Column Graph")),
                                           
                                           
                                           checkboxInput("featuresummary","Display Summary",value = FALSE),
                                           
                                           
                                           
                                           
                                           actionButton("Plot/Update", "Update")
                                       ),
                                       
                                       mainPanel(verbatimTextOutput("summary"),
                                                 tableOutput("view")
                                       )
                                   )
                                   )
                          )
                          
               ),
               #####Model Review and Predictions#####
               navbarMenu("Model Review and Predictions",
                          tabPanel("Features",
                                   fluidPage(sidebarLayout(
                                       sidebarPanel(
                                           selectInput("features",
                                                       "Data columns",
                                                       "features"),
                                           selectInput("investigation_type", "Univaraite/Parwise",
                                                       choices = c("Univaraite","Parewise")),
                                           selectInput("investigation", "Plot",
                                                       choices = c('BoxPlot','Histogram','Bar Graph','Column Graph','Scatter')),
                                           selectInput("investigation", "X",
                                                       choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                           selectInput("investigation", "Y",
                                                       choices = c('BoxPlot','Histogram','Bar Graph','Column Graph')),
                                           
                                           
                                           
                                           
                                           actionButton("update", "Update")
                                       ),
                                       
                                       mainPanel(verbatimTextOutput("summary"),
                                                 tableOutput("view")
                                                )
                                                        )
                                            )
                                    )
                            )
            )
    )


##### Define server logic required to draw a histogram#################
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
