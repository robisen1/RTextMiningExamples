# change this file location to suit your machine
file_loc <- "\\largerset11.csv"
# change TRUE to FALSE if you have no column headings in the CSV
myfile <- read.csv(file_loc, header = TRUE, stringsAsFactors=FALSE)
require(tm)

mycorpus <- Corpus(DataframeSource(myfile[c("username","tweet")]))

mycorpus <- tm_map(mycorpus, removePunctuation)
mycorpus <- tm_map(mycorpus, content_transformer(tolower))
mycorpus <- tm_map(mycorpus, stripWhitespace)
mycorpus <- tm_map(mycorpus, removeWords, c(stopwords("english"), "news"))


tdm <- DocumentTermMatrix(mycorpus)
print(tdm)

m <- as.matrix(tdm)
v <- sort(colSums(m),decreasing=TRUE)

words <- names(v)
d <- data.frame(word=words, freq=v)
wordcloud(d$word,d$freq,min.freq=45)
