## Final Regression Outputs

### For eliminating outliers the below conditions were used
``` 
# Eliminating outliers
# Supply_Chain_Management_Costs<=500000
# Cost_of_Goods_Sold_EURO<=500000
# Total_Operations_Costs<=500000
# Size b4 32378
ndat<-dat[(dat$Supply_Chain_Management_Costs<=500000)&
            (dat$Cost_of_Goods_Sold_EURO<=500000)&
            (dat$Total_Operations_Costs<=500000),]
# Size after 32301
```

### To predict Total Cost Of Distribution 
```
X= "Plant","Cost_of_Goods_Sold_EURO","Product_Line","Product_Type","Customer_Class","Turnover_Range_EURO","Geographical_Area"

Y="Total_Cost_of_Distribution"

# Regression run with outliers R squared - 0.9125
# Regression run without outliers R squared - 0.6224
```

### To predict Customer and Order Management Costs
```
X="Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Product_Line","Product_Type","Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class","Turnover_Range_EURO","Geographical_Area"

Y="Total_Customer_Order_Management_Costs"

# Regression run without outliers R squared - 0.7892
```

### To predict Operations cost

```
X="Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Product_Line","Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes","Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class","Turnover_Range_EURO","Geographical_Area"

Y="Total_Operations_Costs"

# Regression run without outliers R squared - 0.7655

###### Supply Chain management costs
X="Plant","Quantity_units","Cost_of_Goods_Sold_EURO","Product_Line","Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes","Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class","Turnover_Range_EURO","Geographical_Area"

Y="Supply_Chain_Management_Costs"

# Regression run without outliers R squared - 0.5946
```