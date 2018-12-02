
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

# Q2 Graphically present how the total acceptance of offers develops over time,
# i.e. how many offers have been accepted after a specified time from being sent (daily or weekly graph).

# add a new column CustomerID+ApplianceID
Offer_A_df<-Offer_A_df %>% mutate(CS_ID=paste(Offer_A_df$CustomerID,"_",Offer_A_df$ApplianceID))
Offer_S_df<-Offer_S_df %>% mutate(CS_ID=paste(Offer_S_df$CustomerID,"_",Offer_S_df$ApplianceID))
# mapping and calculate the developping time(weeks)
Merge_table<-left_join(Offer_A_df,Offer_S_df,by ="CS_ID")
Merge_table<-Merge_table %>% 
            mutate(Weeks=round(difftime(
                                  strptime(Merge_table$OfferAcceptanceDate,format="%d/%m/%Y"),
                                  strptime(Merge_table$OfferContactDate,format="%d/%m/%Y"),
                                  units="weeks" ),digits = 0))

ggplot(data=Merge_table)+aes(x=as.numeric(Merge_table$Weeks))+ geom_histogram(binwidth=1,color="black", fill="Green")+labs(title="Develop Time",x="Weeks", y="Count")
