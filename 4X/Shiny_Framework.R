# @ Author MMD
# Date 05/10/2018
# Shiny Framework

## app.R ##
library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "4X Demo"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Inputs", tabName = "Predictor", icon = icon("Predictor")),
      menuItem("Predictions", tabName = "Visualisations", icon = icon("Important Findings"))
      
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # Data Loader Contents =========================================================================================
      tabItem(tabName = "Predictor",tags$style(type="text/css",
                                               ".shiny-output-error { visibility: hidden; }",
                                               ".shiny-output-error:before { visibility: hidden; }"),
              fluidPage("",
                        fluidRow(
                fileInput('TextFile', 'Choose Text file to upload',
                          accept = c(
                            'text/csv',
                            'text/comma-separated-values',
                            'text/tab-separated-values',
                            'text/plain'
                          )
                ),
                tags$table(
                  tags$tr(
                    tags$td(
                      numericInput('COGS','Cost of goods sold',value=1)
                    ),
                    tags$td(
                      numericInput('QTY_Units','Quantity Units',value=1)
                    )
                  ),
                  tags$tr(
                    tags$td(
                      numericInput('NDeliv','Number of Deliveries',value=1)
                    ),
                    tags$td(
                      numericInput('N_Parts','Number of Parts',value=1)
                    )
                  ),
                  tags$tr(
                    tags$td(
                      numericInput('ALM','Assembly_Labour_Minutes',value=1)
                    ),
                    tags$td(
                      numericInput('MM','Machinery_Minutes',value=1)
                    )
                  ),
                  tags$tr(
                    
                    tags$td(
                      selectInput("Geographical_Region_IN", "Select country",
                                  c("APA"="APA","CEU"="CEU","CIN"="CIN","CSI"="CSI","FRA"="FRA",
                                    "IAM"="IAM","ITA"="ITA","NAM"="NAM","SAM"="SAM","SCA"="SCA","UKE"="UKE"))
                    ),
                    tags$td(
                      selectInput("Plant_IN", "Select Plant Location",
                                  c("Brasil"="Brasil","China"="China","FRA"="FRA","IND"="IND",
                                    "Northern"="Northern","Italy"="Italy",
                                    "Southern"="Southern","Italy"="Italy","Spain"="Spain","UK"="UK","USA"="USA"))
                    )
                  ),
                  tags$tr(
                    tags$td(
                      selectInput("Customer_Class_IN", "Select Customer Class",
                                  c("Nationals"="Nationals","Others"="Others","Strategic"="Strategic"))
                    ),
                    tags$td(
                      selectInput("Turnover_Range_IN", "Select Turnover Range",
                                  c("a 0-20"="a 0-20","b 20-100"="b 20-100","c 100-250"="c 100-250",
                                    "d 250-500"="d 250-500","e >500"="e >500","Strategic","Strategic"))
                    )
                  ),
                  tags$tr(
                    tags$td(
                      selectInput('Product_Line_IN','Enter Product Line',
                                  c("Plugs and Caps"="Plugs and Caps","Profiles"="Profiles",
                                    "Building Materials"="Building Materials","Basic Components"="Basic Components",
                                    "Springs"="Springs","Cables"="Cables","High-Tech Cables"="High-Tech Cables",
                                    "Pull Cables"="Pull Cables","Pull Cables China"="Pull Cables China",
                                    "Cables China"="Cables China","Profiles Trading"="Profiles Trading",
                                    "Springs Trading"="Springs Trading","Residual Springs"="Residual Springs",
                                    "Springs China"="Springs China","MIVI"="MIVI","TP 821"="TP 821",
                                    "TP 821-822"="TP 821-822"))),
                    tags$td(
                      selectInput('Product_Type_IN','Enter Product Type',
                                  c("Spare Parts"="Spare Parts","Plugs"="Plugs","Not Defined"="Not Defined",
                                    "Metal Profiles"="Metal Profiles","Handles"="Handles",
                                    "Clamping Levers"="Clamping Levers","Caps"="Caps","Feet"="Feet",
                                    "Knobs"="Knobs","Air Springs"="Air Springs","Gas Springs"="Gas Springs",
                                    "Cable Glands"="Cable Glands","Wheels"="Wheels",
                                    "Cable Protectors"="Cable Protectors","Cable Entry Systems"="Cable Entry Systems",
                                    "Cable Entry Frames"="Cable Entry Frames","Pull Cables"="Pull Cables",
                                    "Casters"="Casters","Levers"="Levers","Handwheels"="Handwheels",
                                    "Feedthroughs"="Feedthroughs",
                                    "Modular Structure Fittings"="Modular Structure Fittings",
                                    "Dampers"="Dampers","Rotary Dampers"="Rotary Dampers",
                                    "Speed Control Dampers"="Speed Control Dampers",
                                    "Anti-Vibration Mounts"="Anti-Vibration Mounts","Bumpers"="Bumpers",
                                    "Stops"="Stops",
                                    "Construction Anti-Vibration Pads"="Construction Anti-Vibration Pads",
                                    "Shock Dampers"="Shock Dampers","Thrust Pads"="Thrust Pads",
                                    "Basic Pads"="Basic Pads")))
                  )
                ),
                tags$hr()
              )
              )
      ),
      tabItem(tabName = "Visualisations",tags$style(type="text/css",
                                        ".shiny-output-error { visibility: hidden; }",
                                        ".shiny-output-error:before { visibility: hidden; }"),
              fluidPage("",
                         fluidRow(
                           tags$h2("Predictions are"),
                           tags$table(
                             tags$tr(
                               tags$th("Cost"),
                               tags$th("Lower Bound"),
                               tags$th("Prediction"),
                               tags$th("Upper Bound")
                             ),
                             tags$tr(
                               tags$td(tags$h4("Total Cost Of Distribution")),
                               tags$td(tags$h4("5")),
                               tags$td(tags$h4("7")),
                               #tags$td(tags$h4("9"))
                               tags$td(tags$h4(textOutput("TCOD")))
                             ),
                             tags$tr(
                               tags$td(tags$h4("Total Cost Of Customer and Order Management")),
                               tags$td(tags$h4("5")),
                               tags$td(tags$h4("7")),
                               tags$td(tags$h4("9"))
                               #tags$td(textOutput("TCOM"))
                             ),
                             tags$tr(
                               tags$td(tags$h4("Total Cost Of Supply Chain And Management")),
                               tags$td(tags$h4("5")),
                               tags$td(tags$h4("7")),
                               tags$td(tags$h4("9"))
                               #tags$td(textOutput("TCOSCAM"))
                             ),
                             tags$tr(
                               tags$td(tags$h4("Total Cost Of Operations")),
                               tags$td(tags$h4("5")),
                               tags$td(tags$h4("7")),
                               tags$td(tags$h4("9"))
                               #tags$td(textOutput("TCOO"))
                             ),
                             tags$tr(
                               tags$td(tags$h3("Total")),
                               tags$td(tags$h3("20")),
                               tags$td(tags$h3("28")),
                               tags$td(tags$h3("36"))
                               #tags$td(textOutput("TCOO"))
                             ),
                             tags$style(type="text/css","th{ padding:0 15px 0 15px; }"),
                             tags$style(type="text/css","td{ padding:0 15px 0 15px; }")
                           )
                           ),
                        fluidRow(
                          plotOutput("bar_plot",width = "1100px",height = "400px")
                        )
                        )
      )
      
    )       
    
    
  )
)

options(shiny.maxRequestSize=30*1024^2)
server <- function(input, output) {
  
  # data_l<-reactive({
  #   inFile <- input$TextFile
  #   if (is.null(inFile))
  #     return(NULL)
  #   data<-read.csv(inFile$datapath,header=T)
  #   data<-data[,-1]
  #   if(args==1){return(data)}
  #   return(data)
  # })
  
  HardWorker <- function(x)
  {
    inFile <- input$TextFile
    data<-read.csv(inFile$datapath,header=T)
    # Load variables from screen
    COGS <- input$COGS ; QTY_Units <- input$QTY_Units ; NDeliv <- input$NDeliv 
    N_Parts <- input$N_Parts ; ALM <- input$ALM ; MM <- input$MM
    Geographical_Region_IN <- input$Geographical_Region_IN ; Plant_IN <- input$Plant_IN
    Customer_Class_IN <- input$Customer_Class_IN ; Turnover_Range_IN <- input$Turnover_Range_IN
    Product_Line_IN <- input$Product_Line_IN ; Product_Type_IN <- input$Product_Type_IN
    
    # TCOD Regression
    
    # CRI Regression
    
    # COMC Regression
    
    # SCM Cost Regression
    
    if(x==1){return(N_Parts)}
    else if(x==2){return(2)}
    else if(x==3){return(3)}
    else if(x==4){return(4)}
    else if(x==5){return(1+2+3+4+5)}
    else {return(0)}
  }
  
  output$TCOD <- renderText({paste(HardWorker(1))})
  output$TOMC <- renderText({})
  output$TCRI <- renderText({})
  
  output$MLOP <- renderText({
    dat<-data_l()
    mlr<-lm(Cost_of_Goods_Sold_EURO~Gross_Margin+Geographical_Area
            +Customer_Class+Turnover_Range_EURO+Plant+Product_Line+Product_Type,dat=dat)
    summary(mlr)
    a<-predict(mlr,newdata=data.frame(Gross_Margin=input$Gross_Margin_IN,
                                      Geographical_Area=input$Geographical_Region_IN,
                                      Customer_Class=input$Customer_Class_IN,
                                      Turnover_Range_EURO=input$Turnover_Range_IN,
                                      Plant=input$Plant_IN,
                                      Product_Line=input$Product_Line_IN,
                                      Product_Type=input$Product_Type_IN))
    a<-toString(a)
    paste("Total cost would be: ",a)
    
    
  })
  
  output$bar_plot<- renderPlot({
    data=matrix(c(c(2,3,1,4),c(3,4,2,5),c(4,5,3,6)) , nrow=4)
    colnames(data)=c("Lower Bound","Prediction","Upper Bound")
    rownames(data)=c("Distribution Cost","Order Management Cost","Supply Chain","Operations Cost")
    
    # Get the stacked barplot
    barplot(data,col=c("#223052","#405281","#a8b7c0","#cadfea")#, border="white"
            , space=0.04, font.axis=2,
            xlab="group",horiz=F)#,legend=rownames(data))
    legend("topleft", 
           legend = rownames(data), 
           fill = c("#223052","#405281","#a8b7c0","#cadfea"), ncol = 2,cex = 1.2)
    
  })
  
}
shinyApp(ui, server)