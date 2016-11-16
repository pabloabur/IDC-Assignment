load (dplyr)
# Intended to be dplyr-like code

load ("test2.rda")
load ("reviews.rda")

vegan_businesses <- filter (test2, grepl ("vegan", categories, ignore.case=T))
vegan_businesses_ids <- vegan_businesses$business_id
# TODO
#matches <- unique (grep(paste(toMatch,collapse="|"), 
#                        myfile$Letter, value=TRUE))
businesses_matches<-paste(vegan_businesses_ids,collapse="|")
vegan_users<-unique(filter (reviews, grepl (businesses_matches, business_id)))
