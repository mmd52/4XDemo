# Regression Outputs

### Total Cost of distribution
```
Conclusion =================================================================================
# The best cost driver for cost of distribution is Cost of Goods Sold
# The percentage option used here provided terrrible results
# R sqaure for regression with
# y = Cost of Distribution
# x = "Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
#     "Product_Line","Product_Type","N_Parts",
#     "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
#     "Turnover_Range_EURO","Geographical_Area"
# is 0.9126 and most of this is thanks to COGS
```


### Customer and Order Management Costs
```
# Conclusion =================================================================================
# The best cost driver for Customer and Order management cost is Cost of Goods Sold
# The percentage option used here provided terrrible results also
# R sqaure for regression with
# y = Customer and Order management cost
# x = "Plant","Quantity_units","Cost_of_Goods_Sold_EURO",
#     "Total_Customer_Order_Management_Costs","Product_Line","Product_Type","N_Parts",
#     "Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class",
#     "Turnover_Range_EURO","Geographical_Area"
# is 0.7662 and most of this is thanks to COGS
```


### Operation costs
```
# Conclusion =================================================================================
# The best cost driver for Operations cost is Supply chain management with r square =0.9809
# Howerver predicting operation costs alone or supply chain management cost alone with all the 
# cost drivers yield terrible results (Will havre to figure out a working for this)
```

### Customer Related Issue Costs
```
# Conclusion =================================================================================
# There exists no cost driver to predict customer related issue costs
```