########
#Task 4
########

# Tasks to accomplish
# 
# Build a predictive model based on the previous data modeling steps - you may combine the models in any way you think is appropriate.
# Evaluate the model for efficiency and accuracy - use timing software to evaluate the computational complexity of your model. 
#   Evaluate the model accuracy using different metrics like perplexity, accuracy at the first word, second word, and third word.

p_load(caret, slam, Matrix, SparseM)

load("samples.RData")
inTrain = createDataPartition(sample.comb, p = 0.75, list = F)
train = sample.comb[inTrain]
test= sample.comb[-inTrain]

load("stopwords.RData")
source('G:/GENEVA/Allan/DS/Capstone/clean_corpus function.R', echo=FALSE)

mycorpus.train <- Corpus(VectorSource(train))
clean_corpus(mycorpus.train)
ctrl <- list(tokenize = words, bounds = list(global = c(1000,Inf)))
train.tdm = TermDocumentMatrix(mycorpus.train, control = ctrl)

classvec <- factor(c(rep('twitter',10000),rep('news',10000),rep('blogs',10000)))
library(e1071)
svm.model = svm(train.dtm, class.vector)
