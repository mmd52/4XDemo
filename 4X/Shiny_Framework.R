# @ Author MMD
# Date 05/10/2018
# Shiny Framework

## app.R ##
library(shinydashboard)
#library(plotly)

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
                      numericInput('COGS','Cost of goods sold',value=10000)
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
                                  c("Strategic"="Strategic","Nationals"="Nationals","Others"="Others"))
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
              fluidPage("Thinking... give me atleast 30 seconds .....",
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
                               tags$td(tags$h4(textOutput("TCODl"))),
                               tags$td(tags$h4(textOutput("TCOD"))),
                               tags$td(tags$h4(textOutput("TCODu")))
                             ),
                             tags$tr(
                               tags$td(tags$h4("Total Customer and Order Management Cost")),
                               tags$td(tags$h4(textOutput("TCOMl"))),
                               tags$td(tags$h4(textOutput("TCOM"))),
                               tags$td(tags$h4(textOutput("TCOMu")))
                             ),
                             tags$tr(
                               tags$td(tags$h4("Total Operations Cost")),
                               tags$td(tags$h4(textOutput("TOCl"))),
                               tags$td(tags$h4(textOutput("TOC"))),
                               tags$td(tags$h4(textOutput("TOCu")))
                             ),
                             tags$tr(
                               tags$td(tags$h4("Customer Realted Issue Cost")),
                               tags$td(tags$h4(textOutput("TCIl"))),
                               tags$td(tags$h4(textOutput("TCI"))),
                               tags$td(tags$h4(textOutput("TCIu")))
                             ),
                             tags$tr(
                               tags$td(tags$h3("Total")),
                               tags$td(tags$h3(textOutput("TOTALl"))),
                               tags$td(tags$h3(textOutput("TOTAL"))),
                               tags$td(tags$h3(textOutput("TOTALu")))
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
    dat<-read.csv(inFile$datapath,header=T)
    # Load variables from screen
    Cost_of_Goods_Sold_EURO <- input$COGS
    Quantity_units <- input$QTY_Units
    Number_of_Deliveries <- input$NDeliv
    Geographical_Area <- input$Geographical_Region_IN 
    Turnover_Range_EURO <- input$Turnover_Range_IN
    Product_Line <- input$Product_Line_IN 
    # Prepare Prediction Data Frame
    df = data.frame(Cost_of_Goods_Sold_EURO,Quantity_units,Number_of_Deliveries,
                    Geographical_Area,Turnover_Range_EURO,Product_Line)
    # TCOD Regression
    COD_Model <- lm(Total_Cost_of_Distribution~
                      Cost_of_Goods_Sold_EURO+Quantity_units+Number_of_Deliveries+
                      Geographical_Area+Turnover_Range_EURO+Product_Line,data=dat)
    COD_Prediction <- round(predict(COD_Model,df),2)
    COD_Prediction_L <- round(COD_Prediction-(COD_Prediction*0.05),2)
    COD_Prediction_U <- round(COD_Prediction+(COD_Prediction*0.05),2)
    # COM Regression
    COM_Model <- lm(Total_Customer_Order_Management_Costs~
                      Cost_of_Goods_Sold_EURO+Quantity_units+Number_of_Deliveries+
                      Geographical_Area+Turnover_Range_EURO+Product_Line,data=dat)
    COM_Prediction <- round(predict(COM_Model,df),2)
    COM_Prediction_L <- round(COM_Prediction-(COM_Prediction*0.05),2)
    COM_Prediction_U <- round(COM_Prediction+(COM_Prediction*0.05),2)
    # OC Regression
    OC_Model <- lm(Total_Operations_Costs~
                     Cost_of_Goods_Sold_EURO+Quantity_units+Number_of_Deliveries+
                     Geographical_Area+Turnover_Range_EURO+Product_Line,data=dat)
    OC_Prediction <- round(predict(OC_Model,df),2)
    OC_Prediction_L <- round(OC_Prediction-(OC_Prediction*0.05),2)
    OC_Prediction_U <- round(OC_Prediction+(OC_Prediction*0.05),2)
    # CRI Matrix
    RowNames<-unique(dat$Geographical_Area)
    ColumnNames<-unique(dat$Product_Line)
    tab<-matrix(nrow = 11,ncol = 17)
    i=1;j=1
    for (row in RowNames)
    {
      for (column in ColumnNames)
      {
        tab[i,j] <- mean (dat$Customer_related_Issues_Costs[(dat$Geographical_Area==row)
                                                            &(dat$Product_Line==column)])
        j=j+1
      }
      i=i+1
      j=1
    }
    IssueCostMatrix<-data.frame(row.names = RowNames,tab)
    colnames(IssueCostMatrix)<-ColumnNames
    IssueCostMatrix[is.na(IssueCostMatrix)] <- 0
    rm(i,j,tab,RowNames,ColumnNames)
    CRI_Prediction <- round(IssueCostMatrix[Geographical_Area,Product_Line],2)
    CRI_Prediction_L <- round(CRI_Prediction-(CRI_Prediction*0.05),2)
    CRI_Prediction_U <- round(CRI_Prediction+(CRI_Prediction*0.05),2)
    
    if(x==1){return(COD_Prediction)}
    else if(x==18){return(COD_Prediction_L)}
    else if(x==19){return(COD_Prediction_U)}
    else if(x==2){return(COM_Prediction)}
    else if(x==28){return(COM_Prediction_L)}
    else if(x==29){return(COM_Prediction_U)}
    else if(x==3){return(OC_Prediction)}
    else if(x==38){return(OC_Prediction_L)}
    else if(x==39){return(OC_Prediction_U)}
    else if(x==4){return(CRI_Prediction)}
    else if(x==48){return(CRI_Prediction_L)}
    else if(x==49){return(CRI_Prediction_U)}
    else if(x==5){return(COD_Prediction+COM_Prediction+OC_Prediction+CRI_Prediction)}
    else if(x==58){return(round((COD_Prediction+COM_Prediction+OC_Prediction+CRI_Prediction)-
                                  ((COD_Prediction+COM_Prediction+OC_Prediction+CRI_Prediction)*0.05),2))}
    else if(x==59){return(round((COD_Prediction+COM_Prediction+OC_Prediction+CRI_Prediction)+
                                  ((COD_Prediction+COM_Prediction+OC_Prediction+CRI_Prediction)*0.05),2))}
    else {return(0)}
  }
  
  output$TCOD <- renderText({paste(HardWorker(1))})
  output$TCODl <- renderText({paste(HardWorker(18))})
  output$TCODu <- renderText({paste(HardWorker(19))})  
  output$TCOM <- renderText({paste(HardWorker(2))})
  output$TCOMl <- renderText({paste(HardWorker(28))})
  output$TCOMu <- renderText({paste(HardWorker(29))})
  output$TOC <- renderText({paste(HardWorker(3))})
  output$TOCl <- renderText({paste(HardWorker(38))})
  output$TOCu <- renderText({paste(HardWorker(39))})
  output$TCI <- renderText({paste(HardWorker(4))})
  output$TCIl <- renderText({paste(HardWorker(48))})
  output$TCIu <- renderText({paste(HardWorker(49))})
  output$TOTAL <- renderText({paste(HardWorker(5))})  
  output$TOTALl <- renderText({paste(HardWorker(58))})
  output$TOTALu <- renderText({paste(HardWorker(59))})
  # output$MLOP <- renderText({
  #   dat<-data_l()
  #   mlr<-lm(Cost_of_Goods_Sold_EURO~Gross_Margin+Geographical_Area
  #           +Customer_Class+Turnover_Range_EURO+Plant+Product_Line+Product_Type,dat=dat)
  #   summary(mlr)
  #   a<-predict(mlr,newdata=data.frame(Gross_Margin=input$Gross_Margin_IN,
  #                                     Geographical_Area=input$Geographical_Region_IN,
  #                                     Customer_Class=input$Customer_Class_IN,
  #                                     Turnover_Range_EURO=input$Turnover_Range_IN,
  #                                     Plant=input$Plant_IN,
  #                                     Product_Line=input$Product_Line_IN,
  #                                     Product_Type=input$Product_Type_IN))
  #   a<-toString(a)
  #   paste("Total cost would be: ",a)
  #   
    
  # })
  
  output$bar_plot<- renderPlot({
    data=matrix(c(c(HardWorker(18),HardWorker(28),HardWorker(38),HardWorker(48)),
                  c(HardWorker(1),HardWorker(2),HardWorker(3),HardWorker(4)),
                  c(HardWorker(19),HardWorker(29),HardWorker(39),HardWorker(49))) , nrow=4)
    colnames(data)=c("Lower Bound","Prediction","Upper Bound")
    rownames(data)=c("Total Cost Of Distribution","Total Customer and Order Management Cost",
                     "Total Operations Cost","Customer Related Issue Cost")
    
    # Get the stacked barplot
    barplot(data,col=c("#223052","#405281","#a8b7c0","#cadfea")#, border="white"
            , space=0.04, font.axis=2,
            xlab="group",horiz=F)#,legend=rownames(data))
    legend("left", 
           legend = rownames(data), 
           fill = c("#223052","#405281","#a8b7c0","#cadfea"), ncol = 2,cex = 0.7)
    
  })
  
}
shinyApp(ui, server)