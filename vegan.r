library (dplyr) # Intended to be dplyr-like code

load ("businesses.rda")
load ("reviews.rda")

# Filter matches with "vegan" in businesses
businesses <- mutate (businesses, is_vegan = grepl ("vegan", categories, ignore.case=T))
vegan_businesses <- filter (businesses, is_vegan)

# Get reviews of vegan businesses and then identify possible vegans
vegan_reviews <- filter (reviews, business_id %in% vegan_businesses$business_id)
maybe_vegan_user <- unique (vegan_reviews$user_id)
# maoi<-inner_join(vegan_reviews,select(businesses,business_id,city))

# Next steps are used to identify vegans

# Filter not actually vegans by examining their other reviews
# First generate table with all reviews form possible vegans
all_other_reviews <- reviews %>%
    filter (user_id %in% maybe_vegan_user) %>%
    mutate (is_vegan_business = business_id %in% vegan_businesses$business_id)
# Then separate for vegan and not vegan business
vegan_subset <- all_other_reviews %>%
    filter (is_vegan_business == T) %>%
    group_by (user_id) %>%
    summarise (qt_vegan_review = n ())
not_vegan_subset <- all_other_reviews %>%
    filter (is_vegan_business == F) %>%
    group_by (user_id) %>%
    summarise (qt_not_vegan_review = n ())
# Now joining is used so there is a proportion in the same data
vegan_data <- full_join(not_vegan_subset, vegan_subset)
# Eliminating NAs
vegan_data$qt_not_vegan_review[is.na (vegan_data$qt_not_vegan_review)] <- 0

# Apply criteria to be classified as vegan
vegans<-filter(vegan_data,qt_vegan_review>1)

vegan_states<-inner_join(reviews,select(vegans,user_id))

dotchart(table(businesses$city))
cities<-data.frame(city=c("Las Vegas","Phoenix","Charlotte","Scottsdale","Montréal"))
bsn_ct<-inner_join(businesses,cities)
vegan_states<-inner_join(vegan_states,bsn_ct)
tabela1<-data.frame(Cidade=c("Las Vegas","Phoenix","Charlotte","Scottsdale","Montréal"))
sum(user_city$city == "Phoenix")
tabela1$Qtd_Veganos<-c("963","1060","140","272","218")

