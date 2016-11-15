load ("f_rev.rda")
load ("reviews.rda")

pop <- max (businesses$review_count)
pop_id <- businesses[which (businesses$review_count %in% pop), 1]
pop_reviews <- reviews[which (reviews$business_id %in% pop_id), 3]
