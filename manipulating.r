library(dplyr)

load("v0data.rda")

reviews_grouped<-reviews%>%
    group_by(business_id, date, stars)%>%
    summarise(Qtd=n())


