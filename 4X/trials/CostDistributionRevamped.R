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


col<-c("Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution","Product_Line","Geographical_Area",
       "Quantity_units","Plant","Turnover_Range_EURO")
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)

ndat<-dat[(dat$Cost_of_Goods_Sold_EURO<200000)&
            (dat$Cost_of_Goods_Sold_EURO>0)&
            (dat$Total_Cost_of_Distribution<150000)&
            (dat$Total_Cost_of_Distribution>0),]


CDdat<-subset(dat, select=col)
rm(dat,ndat)

set.seed(999)
#Splitting data into training and testing
train<-sample(1:nrow(CDdat),round(nrow(CDdat)*0.8,0),replace = F)

training_data<-CDdat[train,]
testing_data<-CDdat[-train,]
rm(train)

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Total_Cost_of_Distribution~.,data=training_data)
summary(smlr_Model_1)

ncol<-c("Cost_of_Goods_Sold_EURO","Product_Line","Geographical_Area","Quantity_units","Plant",
        "Turnover_Range_EURO")
predValues<-predict(smlr_Model_1,subset(testing_data,select=ncol))

a<-cbind(predValues,testing_data)
summary(a)
