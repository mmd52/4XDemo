# Author @ Mohammed 10/05/2018
# Final Regression Scripts

rm(list=ls())

# Loading all packages ============================================================
source("Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)


# Eliminating outliers
# Supply_Chain_Management_Costs<=500000
# Cost_of_Goods_Sold_EURO<=500000
# Total_Operations_Costs<=500000
# Size b4 32378
ndat<-dat[(dat$Supply_Chain_Management_Costs<=500000)&
            (dat$Cost_of_Goods_Sold_EURO<=500000)&
            (dat$Total_Operations_Costs<=500000),]
# Size after 32301

# Total Cost Of Distribution===================================================================

col<-c("Plant","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
       "Product_Line","Product_Type","Customer_Class","Turnover_Range_EURO","Geographical_Area")



smlr_Model_TCD <- lm(Total_Cost_of_Distribution~.,data=subset(ndat, select=col))
summary(smlr_Model_TCD)

# Regression run with outliers - 0.9125

# Customer and Order Management===================================================================

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Total_Customer_Order_Management_Costs","Product_Line","Product_Type",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")

smlr_Model_COM <- lm(Total_Customer_Order_Management_Costs~.,data=subset(ndat, select=col))
summary(smlr_Model_COM)

# Regression run without outliers - 0.7892

# Operations cost ===================================================================

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Total_Operations_Costs","Product_Line",
       "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")

smlr_Model_OC <- lm(Total_Operations_Costs~.,data=subset(ndat, select=col))
summary(smlr_Model_OC)

# Regression run without outliers - 0.7655

# Supply Chain management costs
col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Supply_Chain_Management_Costs","Product_Line",
       "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")

smlr_Model_SC <- lm(Supply_Chain_Management_Costs~.,data=subset(ndat, select=col))
summary(smlr_Model_SC)

# Regression run without outliers - 0.5946

