load("G:/GENEVA/Allan/DS/Capstone/corpus.RData")
load("G:/GENEVA/Allan/DS/Capstone/NGrams.RData")
library(pacman)
p_load(tm, qdap, ANLP, e1071, caret, LaF, dplyr, RWeka, stringr, stringi,
       shiny, slam, splitstackshape, wordcloud, RColorBrewer,SnowballC)

load("Ngrams.RData")

simple_prediction <- function(input = "I know you") {
  wordcount = word_count(input)
  
  if (wordcount > 2) {
    phrase <- word(input,c(-3, -2, -1))
  }
  
  if (wordcount == 2) {
    phrase <- word(input,-2, -1)
  }
  
  if (wordcount == 1) {
    phrase <- word(input)
  }
  
  Query <- Qua.df$Grams_1 == phrase[1] & 
    Qua.df$Grams_2 == phrase[2] &
    Qua.df$Grams_3 == phrase[3]
  result4 <- as.data.frame(Qua.df[Query])
  result4$Probability <- result4$Count/sum(result4$Count)
  
  Query <- Tri.df$Grams_1 == phrase[2] &
    Tri.df$Grams_2 == phrase[3]
  result3 <- as.data.frame(Tri.df[Query])
  result3$Probability <- result3$Count/sum(result3$Count)
  
  Query <- Bi.df$Grams_1 == phrase[3]
  result2 <- as.data.frame(Bi.df[Query])
  result2$Probability <- result2$Count/sum(result2$Count)
  
  if (nrow(result4) != 0 ) {
    return(result4)
  } else if (nrow(result3) != 0 ) {
     return(result3)
  }else if (nrow(result2) != 0 ) {
      return(result2)
  }else{
    return(as.data.frame("Not found..."))
  }
}
