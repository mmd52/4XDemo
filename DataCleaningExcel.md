## Data Cleaning for 4X Demo

*Note - Which file is which*
* Cost Analytics Original file
* Cost Analytics Base - File in which excel changes were performed
* 4Xdata_Base - csv file in which csv changes were performed and the input to R's data cleaning script
* 4Xdata - Final data file on which analysis is performed


### Steps
* Material Code and Customer Code is of no relevance so deleting the column's
* Originally we have 32,533 rows. How ever these are including the negative quantities and blanks, so after eliminating them we have 32,379 rows.
* Now I will take the excel file values and put it in a csv file, eliminating all the special symbols and characters
* * Step 1 - Make all curency values to number (Eliminating euro symbol and EUR symbol)
* * Step 2 - Make all '-' symbols blank in numeric columns
* * Step 3 - Replace fancy no parts to n parts
* * Step 4 - Save file Pending data cleaning in R
