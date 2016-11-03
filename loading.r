library (jsonlite)

# Obtaining path to file from an input
file_name <- readline ("review, business, checkin, tip or user? ")
file_path <- paste ("yelp_academic_dataset_", file_name, ".json", sep = "")
# Next line for a more structured structure
# path <- file.path (getwd (), "Dataset", file_path)
path <- file_path

# Geting variables of interest
# reads first line to get names
aux_attributes <- fromJSON (readLines (file (path), 1, encoding="UTF-8"))
print (names (aux_attributes))
ans <- readline ("Insert the attribute names you want, as above and separated by space:")
# [[1]] used to get data itself from strplit output
attributes <- as.vector(strsplit(ans, " ")[[1]]) 

con_out <- file (paste ("file_", file_name, sep = ""), open = "wb")

# Each line in document is a JSON object, so stream is used
stream_in (file (path), handler = function (df) {
    # Subset all rows, which return columns indexes 
    # %in% generates logical vector with T where names where found
    chunk <- df[,which (names (df) %in% attributes)]
    # Writes to output
    stream_out (chunk, con_out)
}, pagesize = 50000) # Avoid using too large pagesizes
close(con_out)

