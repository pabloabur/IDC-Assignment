library (jsonlite)

# Obtaining path to file from an input
file_name <- readline ("review, business, checkin, tip or user? ")
file_path <- paste ("yelp_academic_dataset_", file_name, ".json", sep = "")
path <- file.path (getwd (), "Dataset", file_path)

# Geting variables of interest
# reads first line to get types and names
aux_attributes <- fromJSON (readLines (file (path), 1, encoding="UTF-8"))
print (names (aux_attributes))
ans<-readline ("Insert the attribute names you want, as above and separated by space:")
attributes <- as.vector(strsplit(ans, " ")[[1]])

con_in <- file (path)
con_out <- file (paste ("file_", file_name, sep = ""), open = "wb")

# Each line in document is a JSON object, so stream is used
stream_in (con_in, handler = function (df) {
                chunk <- subset (df, select = which (names (df) %in% attributes))
                stream_out (chunk, con_out)
}, pagesize = 500000)
close(con_out)

