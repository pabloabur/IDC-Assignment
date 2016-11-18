library (dplyr) # Intended to be dplyr-like code

load ("test2.rda")
load ("reviews.rda")

# Filter matches with "vegan" in businesses
test2 <- mutate (test2, is_vegan = grepl ("vegan", categories, ignore.case=T))
vegan_businesses <- filter (test2, is_vegan)

# Filter occurances of vegan businesses in review dataset
vegan_reviews <- filter (reviews, business_id %in% vegan_businesses$business_id)
maybe_vegan_user <- unique (vegan_reviews$user_id)

# Filter not actually vegans by examining their other reviews
#filter_vegans <- filter (reviews, user_id %in% maybe_vegan_user)
#filter_vegans <- mutate (filter_vegans, is_vegan_business = business_id %in% vegan_businesses$business_id)
all_other_reviews <- reviews %>%
    filter (user_id %in% maybe_vegan_user) %>%
    mutate (is_vegan_business = business_id %in% vegan_businesses$business_id)
#veg<-filter(filter_vegans, is_vegan_business==T)
#notveg<-filter(filter_vegans,is_vegan_business==F)
#fveg<-summarise(group_by(veg,user_id), qtd_vegan_review=n())
#fnotveg<-summarise(group_by(notveg,user_id), qtd_not_vegan_review=n())
vegan_subset <- all_other_reviews %>%
    filter (is_vegan_business == T) %>%
    group_by (user_id) %>%
    summarise (qt_vegan_review = n ())
not_vegan_subset <- all_other_reviews %>%
    filter (is_vegan_business == F) %>%
    group_by (user_id) %>%
    summarise (qt_not_vegan_review = n ())
vegan_data <- full_join(not_vegan_subset, vegan_subset)
vegan_data$qt_not_vegan_review[is.na (vegan_data$qt_not_vegan_review)] <- 0
#Number of vegans
#length(which(is.na(vegan_data$qt_not_vegan_review)))
# TODO identical?

