# loads texts mining, some algorithms and wordcloud
library(tm)
library(SnowballC)
library(wordcloud)

# Load review with texts
load ("texts.rda")

# Getting only values that we're interested in
chunk_text <- head(texts, n=100000)

# free up RAM
#rm (businesses, texts, chunk)

# Series of operations on the text data to preprocess text
print ("Preparing text")
review_corpus <- Corpus(VectorSource(chunk_text))
#review_corpus <- Corpus(chunk_text)
review_corpus <- tm_map(review_corpus, removePunctuation)
review_corpus <- tm_map(review_corpus, removeNumbers)
review_corpus <- tm_map(review_corpus, tolower)
review_corpus <- tm_map(review_corpus, removeWords, stopwords('english'))
#review_corpus <- tm_map(review_corpus, removeWords, c("whatever","you","want"))
review_corpus <- tm_map(review_corpus, stemDocument)
review_corpus <- tm_map(review_corpus, stripWhitespace)
review_corpus <- tm_map(review_corpus, PlainTextDocument)

# Plotting
wordcloud(review_corpus, max.words = 100, random.order = FALSE)
