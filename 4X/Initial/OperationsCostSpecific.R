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


##############################################################################################
# Ok Fresh new approach, let me try concentrating on SUPPLY CHAIN MANAGEMENT COSTS
# to this I will select those rows wehere supply chain management cost is not 0

col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Supply_Chain_Management_Costs","Product_Line",
       "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
       "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
       "Turnover_Range_EURO","Geographical_Area")
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)
OCdat<-subset(dat, select=col)

# size of data before this 32378
OCdat<-OCdat[OCdat$Supply_Chain_Management_Costs>=5,]
# size of data after this 16225

# Some stats on this
summary(OCdat$Supply_Chain_Management_Costs)

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Supply_Chain_Management_Costs~.,data=OCdat)
summary(smlr_Model_1)

# Output
# Residual standard error: 30700 on 16152 degrees of freedom
# Multiple R-squared:  0.01735,	Adjusted R-squared:  0.01297 
# F-statistic: 3.962 on 72 and 16152 DF,  p-value: < 2.2e-16

# Ok I Know from the coeffs plant,QTY Units is not a good idea
# COGS seems important, Product line and product type , Geog area

smlr_Model_2 <- lm(Supply_Chain_Management_Costs~Geographical_Area+Product_Type+
                     Product_Line+Cost_of_Goods_Sold_EURO,data=OCdat)
summary(smlr_Model_2)

# Output
# Residual standard error: 30700 on 16171 degrees of freedom
# Multiple R-squared:  0.01616,	Adjusted R-squared:  0.01294 
# F-statistic: 5.012 on 53 and 16171 DF,  p-value: < 2.2e-16


smlr_Model_3 <- lm(Supply_Chain_Management_Costs~Cost_of_Goods_Sold_EURO,data=OCdat)
summary(smlr_Model_3)
# output
# Residual standard error: 30710 on 16223 degrees of freedom
# Multiple R-squared:  0.01271,	Adjusted R-squared:  0.01265 
# F-statistic: 208.8 on 1 and 16223 DF,  p-value: < 2.2e-16

# Although the p value for coeff is significant the r sqare is just horrible
plot(OCdat$Supply_Chain_Management_Costs~OCdat$Cost_of_Goods_Sold_EURO)

# If we see the plot I have a feeling it could be because of the extreme outliers both have
# I will try removing them and retry once again

# size of data before this 16225
OCdat<-OCdat[OCdat$Supply_Chain_Management_Costs<=500000,]
# size of data after this 16223

# size of data before this 16223
OCdat<-OCdat[OCdat$Cost_of_Goods_Sold_EURO<=500000,]
# size of data after this 16151

plot(OCdat$Supply_Chain_Management_Costs~OCdat$Cost_of_Goods_Sold_EURO)


smlr_Model_4 <- lm(Supply_Chain_Management_Costs~Cost_of_Goods_Sold_EURO,data=OCdat)
summary(smlr_Model_4)
# output
# Residual standard error: 1034 on 16149 degrees of freedom
# Multiple R-squared:  0.5569,	Adjusted R-squared:  0.5569 
# F-statistic: 2.03e+04 on 1 and 16149 DF,  p-value: < 2.2e-16
#################################################################################
# Finally a kind of significant R square lets work hard on trying to improve this
#################################################################################

smlr_Model_5 <- lm(Supply_Chain_Management_Costs~.,data=OCdat)
summary(smlr_Model_5)
# Output
# Residual standard error: 990 on 16078 degrees of freedom
# Multiple R-squared:  0.5955,	Adjusted R-squared:  0.5937 
# F-statistic: 328.8 on 72 and 16078 DF,  p-value: < 2.2e-16

# Nope just a small improvement but I have a feeling we can use ~0.6 so as to speak

# In short success mantra for supply chain management is ensuring
# A) Cost_of_Goods_Sold_EURO<=500000
# B) Supply_Chain_Management_Costs<=500000

# lets see if this same mantra applies to Operations cost
####################################################################################
# Focusing on operations cost
####################################################################################
# Clear mind - clear approach - clean approach - clean console
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

# ok let see what operations cost does against cogs

plot(OCdat$Total_Operations_Costs~OCdat$Cost_of_Goods_Sold_EURO)
# I think it has the same story, lets focus on removing the outliers and then trying

# Data size before 32378
OCdat<-OCdat[(OCdat$Cost_of_Goods_Sold_EURO<=500000)&(OCdat$Total_Operations_Costs<=500000),]
# Data size after 32301

plot(OCdat$Total_Operations_Costs~OCdat$Cost_of_Goods_Sold_EURO)

# There is trend here , but i would say more of a logarithmic ?
# Regardless lets try it out the old linear way first of r2

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Total_Operations_Costs~.,data=OCdat)
summary(smlr_Model_1)

# Output
# Residual standard error: 1970 on 32223 degrees of freedom
# Multiple R-squared:  0.7655,	Adjusted R-squared:  0.7649 
# F-statistic:  1366 on 77 and 32223 DF,  p-value: < 2.2e-16

# AN R square we can live with , excellent news !
# So 2 more geniuses conqured,
# This means if i go back and retry the regressions for other costs, eliminating the outliers
# might be able to further boost their accuracies
# reason for success 
# (OCdat$Cost_of_Goods_Sold_EURO<=500000)&(OCdat$Total_Operations_Costs<=500000)