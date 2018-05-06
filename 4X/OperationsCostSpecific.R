# Author @ Mohammed 06/05/2018
# This script is focused on Operation costs and how to 
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
       "Total_Operations_Costs","Product_Line",
       "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)
OCdat<-subset(dat, select=col)

View(head(OCdat))

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Total_Operations_Costs~.,data=OCdat)
summary(smlr_Model_1)

# Output
# Residual standard error: 21980 on 32300 degrees of freedom
# Multiple R-squared:  0.1839,	Adjusted R-squared:  0.1819 
# F-statistic:  94.5 on 77 and 32300 DF,  p-value: < 2.2e-16

# Ok so Exisiting Cost Drivers seem comletely unable to do anything here, lets see if by
# adding Supply chain management costs we can make it better

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Total_Operations_Costs","Product_Line",
       "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area","Supply_Chain_Management_Costs")
OCdat<-subset(dat, select=col)
smlr_Model_2 <- lm(Total_Operations_Costs~.,data=OCdat)
summary(smlr_Model_2)

# Output
# Residual standard error: 3367 on 32299 degrees of freedom
# Multiple R-squared:  0.9809,	Adjusted R-squared:  0.9808 
# F-statistic: 2.122e+04 on 78 and 32299 DF,  p-value: < 2.2e-16

################################ Part 2 #####################################################
# Ok So we have a good regression
# This means we will have to chain our regressions, so now lets us focus our efforts towards
# predicting supply chain management costs first

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Supply_Chain_Management_Costs","Product_Line",
       "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")
SCdat<-subset(dat, select=col)

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Supply_Chain_Management_Costs~.,data=SCdat)
summary(smlr_Model_1)


# Conclusion =================================================================================
# The best cost driver for Operations cost is Supply chain management with r square =0.9809
# Howerver predicting operation costs alone or supply chain management cost alone with all the 
# cost drivers yield terrible results (Will havre to figure out a working for this)