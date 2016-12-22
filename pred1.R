install.packages("tau")

f <- function(queryHistoryTab, query, n = 2) {
  require(tau)
  trigrams <- sort(textcnt(rep(tolower(names(queryHistoryTab)), queryHistoryTab), method = "string", n = length(scan(text = query, what = "character", quiet = TRUE)) + 1))
  query <- tolower(query)
  idx <- which(substr(names(trigrams), 0, nchar(query)) == query)
  res <- head(names(sort(trigrams[idx], decreasing = TRUE)), n)
  res <- substr(res, nchar(query) + 2, nchar(res))
  return(res)
}


f(c("Can of beer" = 3, "can of Soda" = 2, "A can of water" = 1, "Buy me a can of soda, please" = 2), "Can of")
