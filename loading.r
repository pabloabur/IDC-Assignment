library (jsonlite)

# Obtaining path to file from an input
file_name <- readline ("review, business, checkin, tip or user? ")
path <- paste ("yelp_academic_dataset_", file_name, ".json", sep = "")

# Geting variables of interest
# reads first line to get names
aux_attributes <- fromJSON (readLines (file (path), 1, encoding="UTF-8"))
print (names (aux_attributes))
ans <- readline ("Insert the attribute names you want, as above and separated by space:")
# Get data itself from strplit output, which returns list
attributes <- unlist (strsplit (ans, " ")) 

con_name <- paste ("file_", file_name, sep = "")
con_out <- file (con_name, open = "wb")

# Each line in document is a JSON object, so stream is used
stream_in (file (path), handler = function (df) {
    # Subset all rows, which return columns indexes 
    # %in% generates logical vector with T where names where found
    # TODO use dplyr
    chunk <- df[,which (names (df) %in% attributes)]
    # Writes to output
    stream_out (chunk, con_out, pagesize = 10000)
}, pagesize = 50000) # Avoid using too large pagesizes
close(con_out)

# Recover generated data and save it as a single object
print ("Saving .rds...")
gen_data <- stream_in (file (con_name))
saveRDS (gen_data, paste (file_name, ".rds", sep = ""))

# Remove variables and files used
unlink (con_name)
rm (list = ls ())
