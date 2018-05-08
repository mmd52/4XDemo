## Progress so Far

### Day1
* Data cleaned in excel and CSV realised
* Data cleaned in R and mini Library load Scripts Developed
* Regressions for main Cost drivers Run
> *Quick Conclusion-* Total cost of Distribution and Customer and order management costs can easily be predicted using COGS. However the problem lies with Operations cost and customer related Issue costs. Operations cost can be predicted using supply chain management costs, however none of our cost drivers can be used to predict supply chain management costs.
* The percentage option was a clear flop show!
* What to do find a way to get better R square for -
* * Operations cost
* * Customer Related Issue Costs
* Once this is done or partly done NF creating a error margin for all the predictions
* Adding all these prediction values
* Providing total cost with the help of graph
* *SHINY*

### Day2
* Ok so now I am able to predict supply chain management costs and Total operations costs, mainly due to COGS, however I acheived this by elimating outliers on both sides
* R Square for supply chain management costs is roughly 0.6 and total operations cost is 0.7 , not the best but liveable
* I have a feeling i can boost their accuracies more by probably trying regression trees
* Regardless time to move on to Customer related issue costs
* I guess there is no hope for csi related issue costs - I give up here , will come back to this after some EDA
* Key takeaways from EDA
* * Mostly for strategic customers with regards to COGS we have massively 9 outliers, if we keep the cut off at 200,000
* * Mostly for e and d customers with regards to Customer related issue costs we have massively 2 outliers, if we keep the cut off at 500,000
* * Mostly for strategic customers with regards to Cost of distribution we have massively 9 outliers, if we keep the cut off at 100,000
* * Mostly for strategic customers with regards to Customer and Order management we have massively 8 outliers, if we keep the cut off at 100,000
* * Mostly for strategic and b customers with regards to Supply chain management we have massively 2 outliers, if we keep the cut off at 400,000
* * Mostly for strategic and b customers with regards to Operation cost we have massively 6 outliers, if we keep the cut off at 400,000
* * 
* * Cost of distribution, Order management and operations costs for springs is high ,However quantity for MIVI is the highest. And customer relted issue costs for plugs and caps are the highest
> *Quick Conclusion-* Total cost of Distribution and Customer and order management costs can easily be predicted using COGS. To predict Operations costs , we need to get rid of the outliers if we do that cogs is able to predict not only operations cost but also supply chain management costs. How to predict customer related issue costs is still a mystery
* Link to EDA output is [here](https://github.com/mmd52/4XDemo/TableauPlayArea/4X_EDA.pdf)
