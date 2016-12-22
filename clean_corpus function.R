clean_corpus <- function(c){ 
  mycorpus <- tm_map(c, removePunctuation)
  mycorpus <- tm_map(mycorpus, stripWhitespace)
  mycorpus <- tm_map(mycorpus, removeWords, stopwords("en"))
  mycorpus <- tm_map(mycorpus, removeNumbers)
  mycorpus <- tm_map(mycorpus, content_transformer(tolower))
  return(mycorpus)
}

#New: create and clean corpus

get.Corpus <- function(c){
  corpus <- VCorpus(VectorSource(c), readerControl = list(language="en"))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeWords, stopwords("en"))
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, content_transformer(tolower))
  return(corpus) 
}