###########
# Task1
##########
# 1. Tokenization - identifying appropriate tokens such as words, punctuation, and numbers.
#     Writing a function that takes a file as input and returns a tokenized version of it.
# 2. Profanity filtering - removing profanity and other words you do not want to predict.

source("import_data.R")
library(pacman)
p_load(RWeka, wordcloud)

1gToken <- NGramTokenizer(corpus, Weka_control(min=1, max=1))
2gToken <- NGramTokenizer(corpus, Weka_control(min=2, max=2))
3gToken <- NGramTokenizer(corpus, Weka_control(min=3, max=3))

dtm<-TermDocumentMatrix(corpus)

# ########
# Task 2
# ########

# 1. Some words are more frequent than others - what are the distributions of word frequencies? 
# 2. What are the frequencies of 2-grams and 3-grams in the dataset? 
# 3. How many unique words do you need in a frequency sorted dictionary 
#    to cover 50% of all word instances in the language? 90%? 
# 4. How do you evaluate how many of the words come from foreign languages? 
# 5. Can you think of a way to increase the coverage -- 
#    identifying words that may not be in the corpora or 
#     using a smaller number of words in the dictionary to cover the same number of phrases?

p_load(tm)
