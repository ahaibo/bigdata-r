sms_raw <- read.csv("sms_spam.csv", stringsAsFactors=FALSE)
str(sms_raw)
sms_raw$type <- factor(sms_raw$type)
str(sms_raw$type)
table(sms_raw$type)

library(tm)
sms_corpus <- Corpus(VectorSource(sms_raw$text))
print(sms_corpus)
inspect(sms_corpus[1:3])

corpus_clean <- tm_map(sms_corpus, removeNumbers)
corpus_clean <- tm_map(corpus_clean, removePunctuation)
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, stripWhitespace)
corpus_clean <- tm_map(corpus_clean, tolower)
corpus_clean <- tm_map(corpus_clean, content_transformer(tolower))
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords())
corpus_clean <- tm_map(corpus_clean, stripWhitespace)
corpus_clean <- tm_map(corpus_clean, PlainTextDocument)

inspect(corpus_clean[1:3])
#给定tm语料库,创建一个稀疏矩阵要用到下述命令：
sms_dtm <- DocumentTermMatrix(corpus_clean)
#75%训练数据集和25%测试数据集
sms_raw_train <- sms_raw[1:4169,]
sms_raw_test <- sms_raw[4170:5559,]
#文档单词矩阵也分开：
sms_dtm_train <- sms_dtm[1:4169,]
sms_dtm_test <- sms_dtm[4170:5559,]
#语料库也分开：
sms_corpus_train <- corpus_clean[1:4169]
sms_corpus_test <- corpus_clean[4170:5559]

prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))

library(wordcloud)
wordcloud(sms_corpus_train, min.freq=40, random.order=FALSE)

spam <- subset(sms_raw_train, type="spam")
ham <- subset(sms_raw_train, type=t"ham")
wordcloud(spam$text, max.words=40, scale=c(3,0.5))
wordcloud(ham$text, max.words=40, scale=c(3,0.5))

inspect(spam[1:3,"text"])
findFreqTerms(sms_dtm_train, 5)
sms_dict <- findFreqTerms(sms_dtm_train, 5)

sms_train <- DocumentTermMatrix(sms_corpus_train, list(dictionary=sms_dict))
sms_test <- DocumentTermMatrix(sms_corpus_test, list(dictionary=sms_dict))

convert_counts <- function(x){
  x <- ifelse(x>0, 1, 0)
  x <- factor(x, levels=c(0,1), labels=c("NO","YES"))
  return(x)
}
sms_train <- apply(sms_train, MARGIN=2, convert_counts)
sms_test <- apply(sms_test, MARGIN=2, convert_counts)

library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_raw_train$type)
sms_test_pred <- predict(sms_classifier, sms_test)
library(gmodels)
CrossTable(sms_test_pred, sms_raw_test$type, prop.chisq = FALSE, prop.t = FALSE, dnn=c('predicted','actual'))

sms_classifier <- naiveBayes(sms_train, sms_raw_train$type, laplace=1)
sms_test_pred2 <- predict(sms_classifier, sms_test)
CrossTable(sms_test_pred2, sms_raw_test$type, prop.chisq = FALSE, prop.t = FALSE, dnn=c('predicted','actual'))
