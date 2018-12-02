#loading the data

library(gdata)
library(dplyr)
library(ggplot2)


# please change the file path
file_A="/Users/jerry/Documents/GitHub/DG_assignment/Offers_accepted.csv"
file_S="/Users/jerry/Documents/GitHub/DG_assignment/Offers_sent.csv"

Offers_A<-read.csv(file=file_A,header=TRUE, sep=",")
Offers_S<-read.csv(file=file_S,header=TRUE, sep=",")
# converting to tbl_df give a nice view
Offer_A_df<-tbl_df(Offers_A)
Offer_S_df<-tbl_df(Offers_S)

#Q3 Using any technique, build a simple predictive model to predict whether an offer will be accepted using columns V1-V8. 
#Briefly explain your choice of model, and decide which variables are most important in the model. 
#Furthermore, examine the model and report on an accuracy metric(s) of your choice. Please do not spend too much time optimising model parameters

# training and testing dataset with label
Offer_A_df<-Offer_A_df %>% mutate(CS_ID=paste(Offer_A_df$CustomerID,"_",Offer_A_df$ApplianceID))
Offer_A_df<-Offer_A_df %>% mutate(Label=1)

Offer_S_df<-Offer_S_df %>% mutate(CS_ID=paste(Offer_S_df$CustomerID,"_",Offer_S_df$ApplianceID))
Merge_table<-merge(Offer_S_df,Offer_A_df[,c("CS_ID","Label")],by ="CS_ID",all=TRUE)
Merge_table$Label[is.na(Merge_table$Label)]<-0
dataset=Merge_table[,c("V1","V2","V3","V4","V5","V6","V7","V8","Label")]
# convert categorical data to numerical data
must_convert<-sapply(dataset,is.factor)  #  if a variable needs to be displayed as numeric
Convert_df<-sapply(dataset[,must_convert],unclass)    # data.frame of all categorical variables now displayed as numeric
Final_data<-cbind(dataset[,!must_convert],Convert_df)        # complete data.frame with all variables put together
Final_data<-Final_data[,c("V1","V2","V3","V4","V5","V6","V7","V8","Label")]
# data visualization

par(mfrow=c(2,4))
# check outliers
# for(i in 1:2) {
#   for(j in 1:4){
#     boxplot(Final_data[,i*j], main=names(Final_data)[i*j])
#   }
# }
# Can filter the outlier or noise
k=0;
for(i in 1:2) {
  for(j in 1:4){
    k<-k+1
    hist(Final_data[,k], main=names(Final_data)[k])
  }
}

# choose model as we consider the feature are categorical, 
# so we decide to choose Logistics regression model
# V7 is unuseful 
model_data<-Final_data[,c("V1","V2","V3","V4","V5","V6","V8","Label")]
train<-sample_frac(model_data, 0.7)
sid<-as.numeric(rownames(train)) # because rownames() returns character
test<-model_data[-sid,]

glm.fit <- glm(Label ~ ., 
              data = train,
              family = binomial)
summary(glm.fit)

glm.probs <- predict(glm.fit, 
                     test, 
                     type = "response")
# because the accept ratio=290/15513=0.01869 so we set glm.probs > 0.02
glm.pred <- ifelse(glm.probs > 0.02, 1, 0)

#confusionMatrix
table(glm.pred,test$Label)
accuracy<-mean(glm.pred == test$Label)
cat("The accuracy is ",accuracy)

# V1 has lowest p-value , most important variable


