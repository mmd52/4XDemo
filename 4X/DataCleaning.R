# Author @ Mohammed 06/05/2018
# Data Cleaning 

# Loading all packages ============================================================
source("Libraries.R")

# Loading Data ============================================================
dat<-read.csv('4Xdata_Base.csv',header=TRUE)
View(head(dat))

sum(dat$Quantity..units.)
sum(dat$Turnover)

summary(dat)

# Converting our NA's to 0 =====================================
dat[is.na(dat)] <- 0

# Making our categorical variables =====================================
dat$Plant<-as.factor(dat$Plant)
dat$Product.Line<-as.factor(dat$Product.Line)
dat$Product.Type<-as.factor(dat$Product.Type)
dat$Turnover.Range<-as.factor(dat$Turnover.Range)
dat$Geographical.Area<-as.factor(dat$Geographical.Area)
summary(dat)


# Renaming few columns =====================================
names(dat)<-c("Plant","Quantity_units","Turnover_EURO","Cost_of_Goods_Sold_EURO",
              "Total_Cost_of_Distribution","Sales_Transportation","Packing",
              "Distribution_Activities","Trading_Transportation","Custom_Duties_Trading",
              "Warehouse_Rent","Outbound_Logistics_Local_Branches",
              "Total_Customer_Order_Management_Costs","Sales_Comissions","Sales_Development",
              "Offer_Development","Order_Management","Customer_Service",
              "Manage_Account_Receivables","Customer_Order_Management_Local_Branches",
              "Customer_related_Issues_Costs","Rebate","Bad_Debt","Cost_of_Poor_Quality",
              "Total_Operations_Costs","Manufacturing_Costs","Internal_Logistics_Costs",
              "Supply_Chain_Management_Costs","Transportations","Manage_Orders_to_Suppliers",
              "Inbound_Logistics","Inspect_goods","Manage_Foreign_Relationships","Product_Line",
              "Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes",
              "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
              "Turnover_Range_EURO","Geographical_Area")


summary(dat)

# There is some problem with assembly labour minutes and machinery minutes =======================
dat$Assembly_Labour_Minutes<-as.numeric(dat$Assembly_Labour_Minutes)
dat$Machinery_Minutes<-as.numeric(dat$Machinery_Minutes)
dat[is.na(dat)] <- 0
summary(dat)


# Data cleaning complete ======================================================================
View(head(dat))
summary(dat)

# Saving the final file ======================================================================
write.csv(dat,"4Xdata.csv")