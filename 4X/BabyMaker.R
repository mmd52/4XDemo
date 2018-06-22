#source("Libraries.R")
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]

dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)

ndat<-dat[(dat$Cost_of_Goods_Sold_EURO<200000)&
            (dat$Cost_of_Goods_Sold_EURO>20)&
            (dat$Total_Cost_of_Distribution<150000)&
            (dat$Total_Cost_of_Distribution>10)&
            (dat$Total_Customer_Order_Management_Costs<150000)&
            (dat$Total_Customer_Order_Management_Costs>10)&
            (dat$Total_Operations_Costs<500000)&
            (dat$Total_Operations_Costs>10)             
         ,]

col<-c("Cost_of_Goods_Sold_EURO",
       "Quantity_units","Number_of_Deliveries","N_Parts",
       "Assembly_Labour_Minutes","Machinery_Minutes","Geographical_Area","Plant",
       "Customer_Class","Turnover_Range_EURO","Product_Line","Product_Type",
       "Total_Cost_of_Distribution",
       "Total_Customer_Order_Management_Costs",
       "Customer_related_Issues_Costs",
       "Total_Operations_Costs")

ndat<-subset(ndat, select=col)

write.csv(ndat,"4X_ShinyBoy.csv",row.names=FALSE)


dat<-read.csv('4X_ShinyBoy.csv',header=TRUE)
View(head(dat))
