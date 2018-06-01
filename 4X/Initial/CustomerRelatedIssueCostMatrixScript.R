rm(list=ls())

# Loading all packages ============================================================
source("D:/MDS/4XDemo/4X/Initial/Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)


RowNames<-unique(dat$Geographical_Area)
ColumnNames<-unique(dat$Product_Line)

tab<-matrix(nrow = 11,ncol = 17)

i=1
j=1
for (row in RowNames)
{
  for (column in ColumnNames)
  {
    tab[i,j] <- mean (dat$Customer_related_Issues_Costs[(dat$Geographical_Area==row)
                                                              &(dat$Product_Line==column)])
    j=j+1
  }
  i=i+1
  j=1
}
tab

IssueCostMatrix<-data.frame(row.names = RowNames,tab)
colnames(IssueCostMatrix)<-ColumnNames
IssueCostMatrix[is.na(IssueCostMatrix)] <- 0

write.csv(IssueCostMatrix,"CustomerRelatedIssueCostMatrix.csv")
