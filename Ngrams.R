#Tokenization N-grams
##Load packages and data
library(pacman)
p_load(tm, e1071, caret, LaF, dplyr, RWeka, stringr, shiny, slam, splitstackshape, wordcloud, RColorBrewer,SnowballC)
load("samples.RData")
load("stopwords.RData")
load("corpus.RData")

#Tokenization:
Unigram <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
Bigram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
Trigram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
Quagram <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
Pengram <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))

all.corpus = c(mycorpus$blogs, mycorpus$tweets, mycorpus$news)
rm(mycorpus)

Uni.df <- TermDocumentMatrix(all.corpus, control = list(tokenize = Unigram))%>%
  rollup(2,na.rm=TRUE, FUN= sum)%>%
  as.matrix%>%
  as.data.frame%>%
  mutate(words = rownames(.)) %>%
  setnames(c("count", "Grams"))%>%
  arrange(desc(count))%>%
  cSplit("Grams", sep = " ")

Bi.df <- TermDocumentMatrix(all.corpus, control = list(tokenize = Bigram))%>%
  rollup(2,na.rm=TRUE, FUN= sum)%>%
  as.matrix%>%
  as.data.frame%>%
  mutate(words = rownames(.)) %>%
  setnames(c("count", "Grams"))%>%
  arrange(desc(count))%>%
  cSplit("Grams", sep = " ")

Tri.df <- TermDocumentMatrix(all.corpus, control = list(tokenize = Trigram))%>%
  rollup(2,na.rm=TRUE, FUN= sum)%>%
  as.matrix%>%
  as.data.frame%>%
  mutate(words = rownames(.)) %>%
  setnames(c("count", "Grams"))%>%
  arrange(desc(count))%>%
  cSplit("Grams", sep = " ")

Qua.df <- TermDocumentMatrix(all.corpus, control = list(tokenize = Quagram))%>%
  rollup(2,na.rm=TRUE, FUN= sum)%>%
  as.matrix%>%
  as.data.frame%>%
  mutate(words = rownames(.)) %>%
  setnames(c("count", "Grams"))%>%
  arrange(desc(count))%>%
  cSplit("Grams", sep = " ")

Pen.df <- TermDocumentMatrix(all.corpus, control = list(tokenize = Pengram))%>%
  rollup(2,na.rm=TRUE, FUN= sum)%>%
  as.matrix%>%
  as.data.frame%>%
  mutate(words = rownames(.)) %>%
  setnames(c("count", "Grams"))%>%
  arrange(desc(count))%>%
  cSplit("Grams", sep = " ")


#WordClouds
par(mfrow=c(2, 2))
wordcloud(Uni.df[,1], Uni.df[,2], min.freq = 10, max.words = 150, random.order = F, ordered.colors = F, colors = palette())
title("1-gram cloud")

wordcloud(Bi.df[,1], Bi.df[,2], min.freq = 10, max.words = 100,random.order = F, ordered.colors = F, colors = palette())
title("2-gram cloud")

wordcloud(Tri.df[,1], Tri.df[,2], min.freq = 10, max.words = 100,random.order = F, ordered.colors = F, colors = palette())
title("3-gram cloud")

#HIstograms of NGrams
par(mfrow = c(2,2))
barplot(Uni.df[1:20,2], names.arg=Uni.df[1:20,1], col="red", main="1-Grams", las =2)
barplot(Bi.df[1:20,2], names.arg=Bi.df[1:20,1], col="red", main="2-Grams", las =2)
barplot(Tri.df[1:20,2], names.arg=Tri.df[1:20,1], col="red", main="3-Grams", las = 2)
barplot(Qua.df[1:20,2], names.arg=Qua.df[1:20,1], col="red", main="4-Grams", las = 2)

save(Uni.df, Bi.df, Tri.df, Qua.df, Pen.df, file= "Ngrams.RData")

modelslist = list(Uni.df, Bi.df, Tri.df, Qua.df, Pen.df)

