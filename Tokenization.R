setwd("G:/GENEVA/Allan/DS/Capstone")

load("samples.RData")
load("corpus.RData")

#Part 2: Next steps to look at word combinations

#Tokenization:
Unigram <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
Bigram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
Trigram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
Quagram <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))


Uni_tdm <- TermDocumentMatrix(mycorpus.combo, control = list(tokenize = Unigram))
Bi_tdm <- TermDocumentMatrix(mycorpus.combo, control = list(tokenize = Bigram))
Tri_tdm <- TermDocumentMatrix(mycorpus.combo, control = list(tokenize = Trigram))
Qua_tdm <- TermDocumentMatrix(mycorpus.combo, control = list(tokenize = Quagram))

Uni_freq <- sort(rowSums(as.matrix(Uni_tdm)), decreasing = T)
Bi_freq<-sort(rowSums(as.matrix(Bi_tdm)), decreasing = T)
Tri_freq<-sort(rowSums(as.matrix(Tri_tdm)), decreasing = T)
Qua_freq<-sort(rowSums(as.matrix(Qua_tdm)), decreasing = T)

Uni_df <- data.frame(word = names(Unifreq), freq = Uni_freq)
#Uni_df <- Unidf[order(Uni_df[,2], decreasing = TRUE), ]
Bi_df <- data.frame(word =names(Bifreq), freq=Bi_freq)
Bi_df <- Bidf[order(Bi_df[,2], decreasing = TRUE), ]
Tri_df <- data.frame(word =names(Trifreq), freq=Tri_freq)
Tri_df <- Tridf[order(Tri_df[,2], decreasing = TRUE), ]
Qua_df <- data.frame(word =names(Quafreq), freq=Qua_freq)
Qua_df <- Quadf[order(Qua_df[,2], decreasing = TRUE), ]

#WordClouds
par(mfrow=c(2, 2))
wordcloud(Uni_df[,1], Uni_df[,2], min.freq = 10, max.words = 100, random.order = F, ordered.colors = F, colors = palette())
text(x=0.5, y=-0.25, "1-gram cloud")

wordcloud(Bi_df[,1], Bi_df[,2], min.freq = 10, max.words = 100,random.order = F, ordered.colors = F, colors = palette())
text(x=0.5, y=-.25, "2-gram cloud")

wordcloud(Tri_df[,1], Tri_df[,2], min.freq = 10, max.words = 100,random.order = F, ordered.colors = F, colors = palette())
text(x=0.5, y=-0.25, "3-gram cloud")

wordcloud(Qua_df[,1], Qua_df[,2], min.freq = 10, max.words = 100,random.order = F, ordered.colors = F, colors = palette())
text(x=0.5, y=-0.25, "4-gram cloud")

#HIstograms of NGrams
par(mfrow = c(3,1))
barplot(Uni_df[1:20,2], names.arg=Uni_df[1:20,1], col="red", main="2-Grams")
barplot(Bi_df[1:20,2], names.arg=Bi_df[1:20,1], col="red", main="2-Grams")
barplot(Tri_df[1:20,2], names.arg=Tri_df[1:20,1], col="red", main="2-Grams")

save(Uni_df, Bi_df, Tri_df, Qua_df, file = "Ngrams.RData")

## removeSparseTerms(amzn_c_tdm, sparse = .993)
#hc <- hclust(dist(amzn_c_tdm2, method = "euclidean"), method = "complete")

