#Author @ Mohammed 06/05/2018
#Code used to Fetch/install/Load all libraries required

rm(list=ls())
print("============== Beginning to load libraries  ===================")

setwd("D:/MDS/4XDemo/4X")
#Function To check if 
checkInstallLoad <- function(libName) 
{
  if(!require(libName, character.only=TRUE)) 
  {
    install.packages(libName)
    require(libName, character.only=TRUE)
  }
}


checkInstallLoad("data.table")
checkInstallLoad("Matrix")
checkInstallLoad("Metrics")
checkInstallLoad("stringr")
checkInstallLoad("lubridate")
checkInstallLoad("ggplot2")
checkInstallLoad("pROC")
checkInstallLoad("caret")
checkInstallLoad("caretEnsemble")
checkInstallLoad("e1071")
checkInstallLoad("randomForest")
checkInstallLoad("xgboost")
checkInstallLoad("rpart")
checkInstallLoad("C50")
checkInstallLoad("adabag")
checkInstallLoad("arules")
checkInstallLoad("ROCR")
checkInstallLoad("nnet")
checkInstallLoad("car")
checkInstallLoad("Ckmeans.1d.dp")
checkInstallLoad("psych")

rm(checkInstallLoad)
print("============== Completed loading libraries  ===================")
