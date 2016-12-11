# Apply criteria to be classified as vegan
#vegans <- filter (vegan_data, qt_vegan_review > 1, qt_vegan_review > qt_not_vegan_review)
vegans <- filter (vegan_data, qt_vegan_review > qt_not_vegan_review)

# Plots
# TODO use ggplot
#dotchart (table (vegan_businesses$city), main = "Numero de estabelecimentos veganos nas cidades")
#dev.new()
dotchart (table (vegans$city), main = "Numero de veganos nas cidades")

# For each city
cities <- c ("Las Vegas", "Phoenix", "Tempe", "Montréal", "Pittsburgh")
bsn <- filter (vegan_businesses, city %in% cities)
bsn1 <- filter (bsn, city %in% "Las Vegas")
bsn2 <- filter (bsn, city %in% "Phoenix")
bsn3 <- filter (bsn, city %in% "Tempe")
bsn4 <- filter (bsn, city %in% "Montréal")
bsn5 <- filter (bsn, city %in% "Pittsburgh")
dev.new()
hist(bsn1$stars, main = "Frequências de estrelas de estabelecimentos em Las Vegas")
dev.new()
hist(bsn2$stars, main = "Frequências de estrelas de estabelecimentos em Phoenix")
dev.new()
hist(bsn3$stars, main = "Frequências de estrelas de estabelecimentos em Tempe")
dev.new()
hist(bsn4$stars, main = "Frequências de estrelas de estabelecimentos em Montréal")
dev.new()
hist(bsn5$stars, main = "Frequências de estrelas de estabelecimentos em Pittsburgh")

# To print number of vegans in cities, e.g. in Montréal
print (sum (vegans$city == "Montréal"))
