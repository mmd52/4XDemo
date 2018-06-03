# Author @ Mohammed 10/05/2018
# <TO DEFINE>

rm(list=ls())

# Loading all packages ============================================================
source("D:/MDS/4XDemo/4X/Initial/Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)


col<-c("Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
       "Total_Customer_Order_Management_Costs","Product_Line",
       "Number_of_Deliveries")
#"N_Parts,"Average_Delivery_Batch_Size_units","Customer_Class","Turnover_Range_EURO",
#"Geographical_Area","Product_Type")
CMdat<-subset(dat, select=col)

features = names(CMdat)
for (f in features) {
  print(f)
  print(class(CMdat[[f]]))
  if (class(CMdat[[f]])=="factor") {
    #cat("VARIABLE : ",f,"\n")
    levels <- unique(CMdat[[f]])
    CMdat[[f]] <- as.numeric(as.integer(factor(CMdat[[f]], levels=levels)))
  }
}

View(head(CMdat))

set.seed(999)
#Splitting data into training and testing
train<-sample(1:nrow(CMdat),round(nrow(CMdat)*0.8,0),replace = F)

training_data<-CMdat[train,]
testing_data<-CMdat[-train,]
rm(train)

dtrain = xgb.DMatrix(as.matrix(training_data[,-4]), label=training_data[,4])
dtest = xgb.DMatrix(as.matrix(testing_data))

xgb_param_adult = list(
  nrounds = c(500),
  eta = 0.1, #a between(0.01-0.2)
  max_depth = 6, #values between(3-10)
  subsample = 0.7,#values between(0.5-1)
  colsample_bytree = 0.7,#values between(0.5-1)
  num_parallel_tree=1,
  objective='reg:linear',
  min_child_weight = 1
)

res = xgb.cv(xgb_param_adult,
             dtrain,
             nrounds=500,   # changed
             nfold=4,           # changed
             early_stopping_rounds=50,
             print_every_n = 10,
             verbose= 1)

xgb.fit = xgb.train(xgb_param_adult, dtrain, 500)


# Confusion Matrix
preds <- predict(xgb.fit, newdata=as.matrix(testing_data))

View(head(preds))

#training_data$Total_Customer_Order_Management_Costs<-log(training_data$Total_Customer_Order_Management_Costs)
smlr_Model_1 <- lm(Total_Customer_Order_Management_Costs~.,data=training_data)
summary(smlr_Model_1)



preds <- predict(smlr_Model_1, testing_data[,-4])
View(head(cbind(testing_data[,4],preds),50))
#==========================================================================================
rm(list=ls())

rm(list=ls())

# Loading all packages ============================================================
source("D:/MDS/4XDemo/4X/Initial/Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)

ndat<-dat[
  (dat$Cost_of_Goods_Sold_EURO<80000)&
            (dat$Total_Customer_Order_Management_Costs<50000)&
            (dat$Total_Customer_Order_Management_Costs>5)&
            (dat$Cost_of_Goods_Sold_EURO>20),]

plot(ndat$Total_Customer_Order_Management_Costs~ndat$Cost_of_Goods_Sold_EURO)

#"Plant","Product_Line","Customer_Class","Turnover_Range_EURO","Geographical_Area","Product_Type"
col<-c("Quantity_units","Cost_of_Goods_Sold_EURO",
       "Total_Customer_Order_Management_Costs",
       "Number_of_Deliveries","N_Parts","Average_Delivery_Batch_Size_units",
       "Product_Line","Customer_Class")
CMdat<-subset(ndat, select=col)

smlr_Model_1 <- lm(Total_Customer_Order_Management_Costs~.,data=CMdat)
summary(smlr_Model_1)


set.seed(999)
#Splitting data into training and testing
train<-sample(1:nrow(CMdat),round(nrow(CMdat)*0.8,0),replace = F)

training_data<-CMdat[train,]
testing_data<-CMdat[-train,]
rm(train)

smlr_Model_2 <- lm(Total_Customer_Order_Management_Costs~.,data=training_data)
summary(smlr_Model_2)


preds <- predict(smlr_Model_2, testing_data[,-3])
View(head(cbind(testing_data,preds),50))


#======================================================================================
svm_model<-svm(Total_Customer_Order_Management_Costs~.,data = training_data,kernel="linear",epsilon=0.1)
tunedModelY <- predict(svm_model, testing_data[,-3]) 
write.csv(tunedModelY,"sumbission.csv")
tuneResult <- tune(svm, Total_Customer_Order_Management_Costs~.,data = training_data,
                   kernel="linear",
                   ranges = list(epsilon = seq(0,1,0.1), cost = 2^(2:3),verbose=T)
)
print(tuneResult)

# ===========================================================================================
require(randomForest)



Boston.rf=randomForest(Total_Customer_Order_Management_Costs ~ . , data = CMdat , subset = train)
Boston.rf

plot(Boston.rf)


oob.err=double(13)
test.err=double(13)

#mtry is no of Variables randomly chosen at each split
for(mtry in 1:13) 
{
  rf=randomForest(Total_Customer_Order_Management_Costs ~ . , data = CMdat , subset = train,mtry=mtry,ntree=150) 
  oob.err[mtry] = rf$mse[150] #Error of all Trees fitted
  
  pred<-predict(rf,CMdat[-train,]) #Predictions on Test Set for each Tree
  test.err[mtry]= with(CMdat[-train,], mean( (CMdat[,3] - pred)^2)) #Mean Squared Test Error
  
  cat(mtry," ") #printing the output to the console
  
}

matplot(1:mtry , cbind(oob.err,test.err), pch=19 , col=c("red","blue"),type="b",ylab="Mean Squared Error",xlab="Number of Predictors Considered at each Split")
legend("topright",legend=c("Out of Bag Error","Test Error"),pch=19, col=c("red","blue"))
