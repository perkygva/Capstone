load("samples.RData")

#Cleaning 
con <- url("http://www.bannedwordlist.com/lists/swearWords.txt")
swear_words <- readLines(con, warn = F)
close(con)
stopwords <- c(swear_words, "and", "for", "in", "is", "it", "not", "the", "to")
save(stopwords, file = "stopwords.RData")

mycorpus <- list(); tdm <- list(); m <- list() ; freq <- list()

for (i in 1:length(sample.list)) {
  # Create corpus dataset
  mycorpus[[i]] <- Corpus(VectorSource(sample.list[[i]]))
  # Cleaning/stemming the data
  mycorpus[[i]] <- tm_map(mycorpus[[i]], tolower)
  mycorpus[[i]] <- tm_map(mycorpus[[i]], removeNumbers)
  mycorpus[[i]] <- tm_map(mycorpus[[i]], removeWords, stopwords("english"))
  mycorpus[[i]] <- tm_map(mycorpus[[i]], removePunctuation)
  mycorpus[[i]] <- tm_map(mycorpus[[i]], stemDocument)
  mycorpus[[i]] <- tm_map(mycorpus[[i]], stripWhitespace)
  mycorpus[[i]] <- tm_map(mycorpus[[i]], PlainTextDocument)
  # calculate document term frequency for mycorpus
  tdm[[i]] <- TermDocumentMatrix(mycorpus[[i]], control = list(wordLengths = c(0, Inf)))
  m[[i]] <- as.matrix(tdm[[i]])
  freq[[i]] <- sort(rowSums(m[[i]]), decreasing = TRUE)
}
names(mycorpus) <- c("blogs", "tweets", "news")
names(tdm) <- c("blogs", "tweets", "news")
names(freq) <- c("blogs", "tweets", "news")

#WordClouds by Source
par(mfrow=c(1,3))
headings = c("Blogs", "Tweets", "News")

for (i in 1:length(m)){
  wordcloud(words = rownames(m[[i]]), freq = rowSums(m[[i]]), scale = c(3,1), max.words=150, 
            random.order = F, colors = palette())
  title(headings[[i]])
}

par(mfrow = c(3,1))
barplot(freq$blogs[1:30], names=names(freq$blogs[1:30]), col="red", main="Blogs", las = 2)
barplot(freq$tweets[1:30], names=names(freq$tweets[1:30]), col="red", main="Tweets", las = 2)
barplot(freq$news[1:30], names=names(freq$news[1:30]), col="red", main="News", las = 2)


# Combined sample Corpus - for Tokenization
source('G:/GENEVA/Allan/DS/Capstone/clean_corpus function.R', echo=FALSE)
mycorpus.combo <- Corpus(VectorSource(sample.comb), readerControl = list(language="en"))
clean_corpus(mycorpus.combo)

save(mycorpus, mycorpus.combo, file = "corpus.RData")
rm(sample.list, mycorpus, m, tdm, mycorpus.combo)


