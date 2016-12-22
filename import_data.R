
setwd("G:/Geneva/Allan/DS/Capstone")

if(!require("pacman", character.only = TRUE)){
  install.packages("pacman")}
p_load(stringi, Ruchardet, tm, qdap, RWeka, wordcloud, RColorBrewer,SnowballC, slam)
p_load(LaF)


fileurl <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

if(!file.exists("Coursera-SwiftKey.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", dest = "Coursera-SwiftKey.zip")
  unzip("Coursera-SwiftKey.zip", list = FALSE)
  }

list.files("final"); list.files("final/en_US")

blog <- "final/en_US/en_US.blogs.txt"
twitter <- "final/en_US/en_US.twitter.txt"
news <- "final/en_US/en_US.news.txt"

#Import data using UTF-8 encoding to account for all languages/characters
rblog <- readLines(blog, encoding = "UTF-8", warn = F)
rtwitter <- readLines(twitter, encoding = "UTF-8",warn = F)
rnews <- readLines(news, encoding = "UTF-8", warn = F)

stats <- data.frame(
  File = c("Blog", "Twitter", "News"),
  Size = sapply(list(rblog, rtwitter, rnews), function(x) (format(object.size(x), units = "Mb"))),
  Lines = sapply(list(rblog, rtwitter, rnews), function(x) (length(x))),
  Nchar = sapply(list(rblog, rtwitter, rnews), function(x) (sum(nchar(x)))),
  Nwords = sapply(list(rblog, rtwitter, rnews), function(x) sum(stri_count_words(x))),
  mean_words = sapply(list(rblog, rtwitter, rnews), function(x) mean(stri_count_words(x)))
)

#Remove Non-English characters as causing issues in corpus further down
rblog <- iconv(rblog, "latin1", "ASCII", sub="")
rtwitter <- iconv(rtwitter, "latin1", "ASCII", sub="")
rnews <- iconv(rnews, "latin1", "ASCII", sub="")

#Sampling 
set.seed(001)
sblog <- sample(rblog, 10000, replace = F)
stwitter <- sample(rtwitter, 10000, replace = F)
snews <- sample(rnews, 10000, replace = F)

sample.list <- list(blogs = sblog, tweets = stwitter, news = snews)
sample.comb <- sample(c(sblog, stwitter, snews), 10000, replace = F)
combo <- c(sblog, stwitter, snews)

rm(rblog, rtwitter, rnews)
save(sblog, stwitter, snews, sample.list, sample.comb, combo, file = "samples.RData")

