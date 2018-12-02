
#loading the data
library(gdata)
library(dplyr)
# please change the file path
file_A="/Users/jerry/Documents/GitHub/DG_assignment/Offers_accepted.csv"
file_S="/Users/jerry/Documents/GitHub/DG_assignment/Offers_sent.csv"

Offers_A<-read.csv(file=file_A,header=TRUE, sep=",")
Offers_S<-read.csv(file=file_S,header=TRUE, sep=",")
# converting to tbl_df give a nice view
Offer_A_df<-tbl_df(Offers_A)
Offer_S_df<-tbl_df(Offers_S)

# Q1 Calculate the conversion rate for each brand and assess 
#    whether there is a statistically significant difference between them

# merge by ApplianceID
Send_table<- group_by(Offer_S_df,Brand,ApplianceID)
Accept_table<-group_by(Offer_A_df,ApplianceID)
Send_groupby<-summarize(Send_table,Num=n())
Accept_groupby<-summarize(Accept_table,Num=n())
Merge_table<-merge(Send_groupby,Accept_groupby,by ="ApplianceID",all=TRUE,suffixes =c("_Send","_Accept"))
Merge_table$Num_Accept[is.na(Merge_table$Num_Accept)]<-0

# Q1_answer
Brand_summary<-aggregate(Merge_table[,c(3:4)],by=list(Merge_table$Brand),sum)
Brand_summary$Conversion_ratio<-Brand_summary[,3]/Brand_summary[,2]
barplot(Brand_summary$Conversion_ratio, main="Conversion_ratio by Brands", 
        xlab="Brand",col="red",names.arg =Brand_summary$Group.1)

