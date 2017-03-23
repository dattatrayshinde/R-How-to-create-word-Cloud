#-----------------------------------------------
#1. Load required libraries 
#-----------------------------------------------

checkInstallLoad <- function(libName) {
  if(!require(libName, character.only=TRUE)) {
    install.packages(libName)
    require(libName, character.only=TRUE)
  }
}
checkInstallLoad("tm")
checkInstallLoad("wordcloud")
#-----------------------------------------------
#2. Read the pdf file
#-----------------------------------------------
# filename = "book2016June9.pdf"
# test_data= readLines(filename)

uri <- sprintf("file://%s", paste(getwd(),"/DSFoundationBook.pdf",sep = ""), package = "tm")
pdf <- readPDF(control = list(text = "-layout"))(elem = list(uri = uri),
                                                   language = "en",
                                                   id = "id1")
#-----------------------------------------------
#3. Covvert data to corpus
#-----------------------------------------------
tst_corpus<-Corpus(VectorSource(pdf))
#-----------------------------------------------
#4. Data cleaning
#-----------------------------------------------
final_data<-tm_map(tst_corpus,stripWhitespace)
final_data<-tm_map(tst_corpus,tolower)
final_data<-tm_map(tst_corpus,removeNumbers)
final_data<-tm_map(tst_corpus,removeWords, stopwords("english"))
final_data<-tm_map(final_data,removeWords, c("and","the","our","that","is","am","are",
                                             "a","an","have","has","it","they","this",
                                             "that","had","shall","should"))
#-----------------------------------------------
#5. Create wordcloud
#-----------------------------------------------
options(warn=1) 
wordcloud (final_data, scale=c(4,.5), max.words=1000, random.order=FALSE, 
           rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))


