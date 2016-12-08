library (dplyr)
library (jsonlite)

# Code for preparing the data
reviews <- stream_in (file ("file_review"))
businesses <- stream_in (file ("file_business"))
load ("elites.rda")

# Preparing proper and meaningful names
names (businesses$attributes)[18] <- "Price.Range"
names (businesses)[2] <- "business_avg_star"
names (reviews)[2] <- "review_star"

# Procedure to get user's price range according to all of his reviews
businesses$business_price_range <- businesses$attributes$Price.Range
bsn <- select (businesses, business_id, business_price_range)
rvw <- select (reviews, user_id, business_id)
price_data <- full_join (rvw, bsn)
rm (rvw, bsn) # Save space
user_price_range <- price_data %>%
    group_by (user_id) %>%
    summarise (mean_user_price_range = mean (business_price_range), qtd_review = n ())
rm (price_data)

# Join other important columns from other datasets
price_star <- full_join (select (reviews, -date), user_price_range)
price_star <- full_join (price_star, select(businesses, business_id, business_price_range, business_avg_star))
# remove NAs
f_ps <- filter (price_star, !(is.na (mean_user_price_range)), !(is.na (business_price_range)))
rm (reviews, businesses)

# Getting only elites
f_ps <- inner_join (f_ps, elites)
rm(elites)

# vector to calculate correlation. Transmute calculate new columns removing all the rest
vectors <- transmute (f_ps, relative_price = mean_user_price_range - business_price_range,
                   relative_star = review_star - business_avg_star)
#cor (vectors)
