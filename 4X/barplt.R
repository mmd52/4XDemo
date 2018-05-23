# Author @ Mohammed 10/05/2018
# Stacked Bar Chart

rm(list=ls())

# Loading all packages ============================================================
source("Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata.csv',header=TRUE)
dat<-dat[,-1]
dat$Average_Delivery_Batch_Size_units<-as.numeric(dat$Average_Delivery_Batch_Size_units)
dat$Number_of_Deliveries<-as.numeric(dat$Number_of_Deliveries)


# Eliminating outliers
# Supply_Chain_Management_Costs<=500000
# Cost_of_Goods_Sold_EURO<=500000
# Total_Operations_Costs<=500000
# Size b4 32378
dat<-dat[(dat$Supply_Chain_Management_Costs<=500000)&
            (dat$Cost_of_Goods_Sold_EURO<=500000)&
            (dat$Total_Operations_Costs<=500000),]

#================================================================
# Stacked Bar Plot with Colors and Legend
counts <- table(dat$Customer_Class, dat$Geographical_Area)
barplot(counts, main="Car Distribution by1 Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts))

#Create data
set.seed(112)
data=matrix(c(10,30,20) , nrow=3)
colnames(data)=c("Cost")
rownames(data)=c("TCD","COM","OC")

# Get the stacked barplot
barplot(data, border="white", space=0.04, font.axis=2,
        xlab="group",legend=rownames(data),horiz=T)

# Grouped barplot
barplot(data, col=colors()[c(23,89,12)] , border="white", font.axis=2, legend=rownames(data),
        horiz=TRUE, font.lab=2)

qplot(x = Cost, y = c(10,20,30), data = data, geom = "bar", fill = variable)
