library(pacman)
p_load(tm, e1071, caret, LaF, dplyr, RWeka, stringr, shiny, slam, splitstackshape, wordcloud, RColorBrewer,SnowballC)
p_load(ANLP)

load("samples.RData")

ac = cleanTextData(combo)
UN = generateTDM(ac, 1, isTrace = F)
BI = generateTDM(ac, 2, isTrace = F)
TRI = generateTDM(ac, 3, isTrace = F)
QUA = generateTDM(ac, 4, isTrace = F)
PEN = generateTDM(ac, 5, isTrace = F)

modelslist = list(UN, BI, TRI, QUA,PEN)

testline = "he started telling me about his"
test2 = "new york city"
line = "happy birthday"
predict_Backoff(testline, modelslist)
predict_Backoff(test2, modelslist)
predict_Backoff(line, modelslist)

save(modelslist, file = "modelslist.RData")

backoff = function(input){
  load("modelslist.RData")
  predict_Backoff(input, modelslist)
}

