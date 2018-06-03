rm(list=ls())

# Loading all packages ============================================================
source("D:/MDS/4XDemo/4X/Initial/Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)

#### COGS bounds (20,1000000)
#### Customer Related Issue costs (0,200000) - this removes only one outlier customer
#### Cost of distribution (10,200000)
#### Cost of Customer and order management - (10,100000)
#### Operation Cost -(10,500000)
# 32378
ndat<-dat[
    (dat$Cost_of_Goods_Sold_EURO>20)&
    (dat$Cost_of_Goods_Sold_EURO<1000000)&
    (dat$Customer_related_Issues_Costs<200000)&
    (dat$Total_Cost_of_Distribution>10)&
    (dat$Total_Cost_of_Distribution<200000)&
    (dat$Total_Customer_Order_Management_Costs>10)&
    (dat$Total_Customer_Order_Management_Costs<100000)&
    (dat$Total_Operations_Costs>10)&
    (dat$Total_Operations_Costs<500000),]
# 14825
summary(ndat)
col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
       "Total_Customer_Order_Management_Costs","Customer_related_Issues_Costs",
       "Total_Operations_Costs","Product_Line","Product_Type","N_Parts",
       "Assembly_Labour_Minutes","Machinery_Minutes","Number_of_Deliveries",
       "Customer_Class","Turnover_Range_EURO","Geographical_Area")
finalData<-subset(ndat,select=col)

write.csv(finalData,"4X_model.csv")

plot(finalData$Cost_of_Goods_Sold_EURO,finalData$Total_Cost_of_Distribution)
plot(finalData$Cost_of_Goods_Sold_EURO,finalData$Total_Customer_Order_Management_Costs)
plot(finalData$Cost_of_Goods_Sold_EURO,finalData$Customer_related_Issues_Costs)
plot(finalData$Cost_of_Goods_Sold_EURO,finalData$Total_Operations_Costs)