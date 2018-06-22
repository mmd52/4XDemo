dat<-read.csv('4X_ShinyBoy.csv',header=TRUE)

COD_Model <- lm(Total_Cost_of_Distribution~
                  Cost_of_Goods_Sold_EURO+Quantity_units+Number_of_Deliveries+
                  Geographical_Area+Turnover_Range_EURO+Product_Line,data=dat)

summary(COD_Model)

Cost_of_Goods_Sold_EURO=c(10000)
Quantity_units=c(2)
Number_of_Deliveries=c(4)
Geographical_Area=c("ITA")
Turnover_Range_EURO=c("Strategic")
Product_Line=c("Springs")
df = data.frame(Cost_of_Goods_Sold_EURO,Quantity_units,Number_of_Deliveries,
                  Geographical_Area,Turnover_Range_EURO,Product_Line)

predict(COD_Model,df)
######################################################################################

COM_Model <- lm(Total_Customer_Order_Management_Costs~
                  Cost_of_Goods_Sold_EURO+Quantity_units+Number_of_Deliveries+
                  Geographical_Area+Turnover_Range_EURO+Product_Line,data=dat)
summary(COM_Model)

predict(COM_Model,df)
######################################################################################

OC_Model <- lm(Total_Operations_Costs~
                  Cost_of_Goods_Sold_EURO+Quantity_units+Number_of_Deliveries+
                  Geographical_Area+Turnover_Range_EURO+Product_Line,data=dat)
summary(OC_Model)

predict(OC_Model,df)
######################################################################################

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
#tab

IssueCostMatrix<-data.frame(row.names = RowNames,tab)
colnames(IssueCostMatrix)<-ColumnNames
IssueCostMatrix[is.na(IssueCostMatrix)] <- 0
IssueCostMatrix[Geographical_Area,Product_Line]
