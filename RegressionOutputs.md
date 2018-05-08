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
#### A new Approach
```
# Conclusion ==================================================================================
smlr_Model_5 <- lm(Supply_Chain_Management_Costs~.,data=OCdat)
summary(smlr_Model_5)
# Output
# Residual standard error: 990 on 16078 degrees of freedom
# Multiple R-squared:  0.5955,	Adjusted R-squared:  0.5937 
# F-statistic: 328.8 on 72 and 16078 DF,  p-value: < 2.2e-16

# Nope just a small improvement but I have a feeling we can use ~0.6 so as to speak

# In short success mantra for supply chain management is ensuring
# A) Cost_of_Goods_Sold_EURO<=500000
# B) Supply_Chain_Management_Costs<=500000

# Regression attempt 1 ========================================================================
smlr_Model_1 <- lm(Total_Operations_Costs~.,data=OCdat)
summary(smlr_Model_1)

# Output
# Residual standard error: 1970 on 32223 degrees of freedom
# Multiple R-squared:  0.7655,	Adjusted R-squared:  0.7649 
# F-statistic:  1366 on 77 and 32223 DF,  p-value: < 2.2e-16

# AN R square we can live with , excellent news !
# So 2 more geniuses conqured,
# This means if i go back and retry the regressions for other costs, eliminating the outliers
# might be able to further boost their accuracies
# reason for success 
# (OCdat$Cost_of_Goods_Sold_EURO<=500000)&(OCdat$Total_Operations_Costs<=500000)

```


### Customer Related Issue Costs
```
# Conclusion =================================================================================
# There exists no cost driver to predict customer related issue costs
```