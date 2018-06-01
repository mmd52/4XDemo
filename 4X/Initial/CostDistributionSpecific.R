# Author @ Mohammed 06/05/2018
# This script is focused on Cost of Distribution and how to get it using the existing Cost Drivers

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

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
       "Product_Line","Product_Type","N_Parts",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)

CDdat<-subset(dat, select=col)

View(head(CDdat))


# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Total_Cost_of_Distribution~.,data=CDdat)
summary(smlr_Model_1)

# Output
# Residual standard error: 1375 on 32302 degrees of freedom
# Multiple R-squared:  0.9126,	Adjusted R-squared:  0.9124 
# F-statistic:  4498 on 75 and 32302 DF,  p-value: < 2.2e-16

# Lets try running it without cost of goods sold euro
tdat <- CDdat[,-3] 
smlr_Model_2 <- lm(Total_Cost_of_Distribution~.,data=tdat)
summary(smlr_Model_2)
rm(tdat)

# Output
# Residual standard error: 4198 on 32303 degrees of freedom
# Multiple R-squared:  0.1848,	Adjusted R-squared:  0.183 
# F-statistic: 98.99 on 74 and 32303 DF,  p-value: < 2.2e-16

# As expected R squared dropped by milenials

# Lets try running it with only cost of goods sold euro
smlr_Model_3 <- lm(Total_Cost_of_Distribution~Cost_of_Goods_Sold_EURO,data=CDdat)
summary(smlr_Model_3)

# Output
# Residual standard error: 1464 on 32376 degrees of freedom
# Multiple R-squared:  0.9006,	Adjusted R-squared:  0.9006 
# F-statistic: 2.933e+05 on 1 and 32376 DF,  p-value: < 2.2e-16
#################################################################################
# On Its own Cost of goods sold was able to provide amazing results for Total Cost of Distribution
#################################################################################

# Regression attempt 2 ========================================================================
# Now trying the percentage based approach
CDdat$Perc_Total_Cost_of_Distribution <- (CDdat$Total_Cost_of_Distribution/
                                            CDdat$Cost_of_Goods_Sold_EURO)*100
Pdat<-CDdat[(!is.na(CDdat$Perc_Total_Cost_of_Distribution))&
              (!is.infinite(CDdat$Perc_Total_Cost_of_Distribution)),]

# Great Lets start an overall Regression
tdat <- Pdat[,-c(3,4)] 
pmlr_Model_1 <- lm(Perc_Total_Cost_of_Distribution~.,data=tdat)
summary(pmlr_Model_1)
rm(tdat)

# Output 
# Residual standard error: 24180 on 32176 degrees of freedom
# Multiple R-squared:  0.02729,	Adjusted R-squared:  0.02505 
# F-statistic:  12.2 on 74 and 32176 DF,  p-value: < 2.2e-16

# Without Cogs its a lost cause

# Regression with COGS
tdat <- Pdat[,-c(4)] 
pmlr_Model_2 <- lm(Perc_Total_Cost_of_Distribution~.,data=tdat)
summary(pmlr_Model_2)
rm(tdat)

# Output
# Residual standard error: 24180 on 32175 degrees of freedom
# Multiple R-squared:  0.0273,	Adjusted R-squared:  0.02503 
# F-statistic: 12.04 on 75 and 32175 DF,  p-value: < 2.2e-16

# Looks like the Percentage option is Horrible

# Conclusion =================================================================================
# The best cost driver for cost of distribution is Cost of Goods Sold
# The percentage option used here provided terrrible results
# R sqaure for regression with
# y = Cost of Distribution
# x = "Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
#     "Product_Line","Product_Type","N_Parts",
#     "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
#     "Turnover_Range_EURO","Geographical_Area"
# is 0.9126 and most of this is thanks to COGS