# loads texts mining, some algorithms and wordcloud
library(tm)
library(SnowballC)
library(wordcloud)

# Load review with texts
load ("texts.rda")
load("BR0data.rda")

# Getting only values that we're interested in
brbbqid<-businesses[which(businesses$is_bbq & businesses$is_brazillian == T),1]
chunk<-texts[which(texts$business_id %in% brbbqid),]
chunk_text <- chunk$text

# free up RAM
rm (businesses, texts, chunk)

# Series of operations on the text data to simplify text
print ("Preparing text")
review_corpus <- Corpus(VectorSource(chunk_text))
review_corpus <- tm_map(review_corpus, PlainTextDocument)
review_corpus <- tm_map(review_corpus, removePunctuation)
review_corpus <- tm_map(review_corpus, removeWords, stopwords('english'))
review_corpus <- tm_map(review_corpus, stemDocument)

# Plotting
wordcloud(review_corpus, max.words = 100, random.order = FALSE)
