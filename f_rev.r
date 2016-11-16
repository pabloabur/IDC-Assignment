#load ("f_rev.rda")
#load ("reviews.rda")
#
## Creating columns from date
#aux<-strsplit(reviews$date,"-")
#reviews$year<-lapply(aux,'[[',1)
#reviews$month<-lapply(aux,'[[',2)
#
## Getting info from the more popular business 
#pop <- max (businesses$review_count)
#pop_id <- businesses[which (businesses$review_count %in% pop), 1]
## Only reviews from pop_id
#business1<-reviews[which(reviews$business_id %in% pop_id),]
#
## Getting total review qtd
#reviews$month<-as.integer(reviews$month)
#reviews$year<-as.integer(reviews$year)
#str_qtr2<-reviews %>%
#    group_by (year,month) %>%
#    summarise(qtd = n())
#cresc_total <- vector ()
#for (i in 2:length(str_qtr2$qtd)){
#    cresc_total[i-1]<- (str_qtr2$qtd[i]/str_qtr2$qtd[i-1])
#}
#
# Getting business1 review qtd
#business1$month<-as.integer(business1$month)
#business1$year<-as.integer(business1$year)
#str_qtr<-business1 %>%
#    group_by (year,month) %>%
#    summarise(qtd = n())
#cresc_bus <- vector ()
#for (i in 2:length(str_qtr$qtd)){
#    cresc_bus[i-1]<- str_qtr$qtd[i]/str_qtr$qtd[i-1]
#}
