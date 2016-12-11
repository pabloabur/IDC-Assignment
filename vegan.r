library (dplyr) # Intended to be dplyr-like code

# A Mode function will be needed TODO make your own
Mode <- function(x) {
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
}

businesses <- readRDS ("business.rds")
reviews <- readRDS ("review.rds")

# Filter matches with "vegan" in businesses
businesses <- mutate (businesses, is_vegan = grepl ("vegan", categories, ignore.case=T))
vegan_businesses <- businesses %>%
    filter (is_vegan) %>%
    select (-is_vegan)

# Get reviews of vegan businesses and then identify possible vegans
vegan_reviews <- filter (reviews, business_id %in% vegan_businesses$business_id)
# TODO maybe_vegan_user <- distinct (vegan_reviews, user_id)
maybe_vegan_user <- unique (vegan_reviews$user_id)

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

# To find out user city, start by getting city of review
# There is 'user_id' in vegan_reviews and 'city' in businesses
review_city <- inner_join (vegan_reviews, businesses)
user_city <- review_city %>%
    select (user_id, city) %>%
    group_by (user_id) %>%
    summarise (cities = list (city)) %>%
    mutate (city = sapply (cities, Mode)) %>%
    select (-cities)
# Join with vegan_data dataset
vegan_data <- inner_join (vegan_data, user_city)

# Remove unnecessary objects
rm (businesses, reviews, maybe_vegan_user, vegan_reviews, not_vegan_subset,
    vegan_subset, all_other_reviews, review_city, user_city, Mode)
