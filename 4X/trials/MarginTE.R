# Author @ Mohammed 31/05/2018
# Upper and Lower bound definitions

rm(list=ls())

# Loading all packages ============================================================
source("Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)
dat<-dat[(dat$Supply_Chain_Management_Costs<=500000)&
            (dat$Cost_of_Goods_Sold_EURO<=500000)&
            (dat$Total_Operations_Costs<=500000)&
            (dat$Total_Cost_of_Distribution<=100000)&
            (dat$Total_Cost_of_Distribution>=10),]

col<-c("Plant","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
       "Product_Line","Product_Type","Customer_Class","Turnover_Range_EURO","Geographical_Area")

ndat=subset(dat, select=col)

set.seed(999)
#Splitting data into training and testing
train<-sample(1:nrow(ndat),round(nrow(ndat)*0.8,0),replace = F)
test<--train

training_data<-ndat[train,]
testing_data<-ndat[test,]



smlr_Model_TCD <- lm(Total_Cost_of_Distribution~
                       Cost_of_Goods_Sold_EURO
                     +Product_Type+Customer_Class,
                     data=training_data)
summary(smlr_Model_TCD)

col<-c("Cost_of_Goods_Sold_EURO",
       "Product_Type","Customer_Class")

predValues<-predict(smlr_Model_TCD,subset(testing_data, select=col))

View(head(cbind(testing_data,predValues),20))

Lower<-predict(smlr_Model_TCD,subset(testing_data, select=col))-sqrt(deviance(smlr_Model_TCD)/df.residual(smlr_Model_TCD))
Upper<-predict(smlr_Model_TCD,subset(testing_data, select=col))+sqrt(deviance(smlr_Model_TCD)/df.residual(smlr_Model_TCD))
tocheck<-cbind(testing_data,predValues,Lower,Upper)
write.csv(tocheck,"check.csv")
