# Q4

# V7 is the treatment category and currently, 
# the business only applies treatment A. 
# The business has decided to introduce new treatment categorical values to V7, 
# factors B, C, and D. 
# Design an experiment to assess the potential impact of the new factors on conversion rates 
# and include which statistical methods you would use.
# Please state any assumptions made. 
# (R is not required here, you can answer this question in comments)

# Answer

Statistical methods : regression

Assume1:
B has impact on conversion rate, so when preprocess data, we convert B to 1 and A, C, D to 0

Step1  random choose 10000 records from dataset to calculate conversion rate, so it will have a pair value ( number of B , conversion rate)
Step2  repeat step1 for 1000 times
Step3  use linear regression or other regression to check whether variable of number of B impact the conversion rate , using coefficient and p-value to check

Assume2:
B, C has impact on conversion rate, so when preprocess data, we convert B and C to 1 and A, D to 0

Step1  random choose 10000 records from dataset to calculate conversion rate, so it will have a pair value ( number of B , conversion rate)
Step2  repeat step1 for 1000 times
Step3  use linear regression or other regression to check whether variable of number of B and C impact the conversion rate , using coefficient and p-value to check


Other Assumption:
C has impact on conversion rate, so when preprocess data, we convert C  to 1 and A, B, D to 0
D has impact on conversion rate, so when preprocess data, we convert D  to 1 and A, B, C to 0
B,D has impact on conversion rate, so when preprocess data, we convert B,D  to 1 and A, C to 0
C,D has impact on conversion rate, so when preprocess data, we convert C,D  to 1 and A, B to 0
B,C,D has impact on conversion rate, so when preprocess data, we convertB C,D  to 1 and A to 0

Then do Step1 ,Step2, Step3






                      
 
 
 
