# Author @ Mohammed 06/05/2018
# This script is focused on Customer specific Issue related costs and how to 
# get it using the existing Cost Drivers

rm(list=ls())
# Loading all packages ============================================================
source("Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
View(head(dat))

# Now the only variables I need here are =======================================================
# But from a management point of view which make more sense?

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Customer_related_Issues_Costs","Product_Line",
       "Product_Type","N_Parts",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)
CSIdat<-subset(dat, select=col)

View(head(CSIdat))

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Customer_related_Issues_Costs~.,data=CSIdat)
summary(smlr_Model_1)

# Conclusion =================================================================================
# There exists no cost driver to predict customer related issue costs