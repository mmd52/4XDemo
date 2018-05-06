# Author @ Mohammed 06/05/2018
# This script is focused on Customer and Order Management costs and how to 
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
# labor minutes,machiney minutes doesnt make sense

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Total_Customer_Order_Management_Costs","Product_Line","Product_Type","N_Parts",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)
CMdat<-subset(dat, select=col)

View(head(CMdat))

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Total_Customer_Order_Management_Costs~.,data=CMdat)
summary(smlr_Model_1)

# Output
# Residual standard error: 1867 on 32302 degrees of freedom
# Multiple R-squared:  0.7662,	Adjusted R-squared:  0.7656 
# F-statistic:  1411 on 75 and 32302 DF,  p-value: < 2.2e-16

# Without COGS
tdat <- CMdat[,-3] 
smlr_Model_2 <- lm(Total_Customer_Order_Management_Costs~.,data=tdat)
summary(smlr_Model_2)
rm(tdat)

# Output
# Residual standard error: 3523 on 32303 degrees of freedom
# Multiple R-squared:  0.168,	Adjusted R-squared:  0.1661 
# F-statistic: 88.16 on 74 and 32303 DF,  p-value: < 2.2e-16

# Conclusion =================================================================================
# The best cost driver for Customer and Order management cost is Cost of Goods Sold
# The percentage option used here provided terrrible results also
# R sqaure for regression with
# y = Customer and Order management cost
# x = "Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
#     "Total_Customer_Order_Management_Costs","Product_Line","Product_Type","N_Parts",
#     "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
#     "Turnover_Range_EURO","Geographical_Area"
# is 0.7662 and most of this is thanks to COGS