######################################################
#
#  Text mining w R
#   
#  Konferencja WhyR? 2017, 27 września 2017
#
#  Norbert Ryciak
#  Sages, Wydział Matematyki i Nauk Informacyjnych PW       
#
#  Źródła:
#  - winietka pakietu TM
#  - https://www.r-bloggers.com/text-mining-in-r-automatic-categorization-of-wikipedia-articles/
#
#####################################################

# Instalujemy i w czytujemy potrzebne pakiety:

install.packages("tm")
install.packages("topicmodels")
install.packages("LDAvis")
install.packages("XML")
install.packages("SnowballC")
install.packages("stringr")

library(tm)
library(topicmodels)
library(LDAvis)
library(stringr)






### 1. Wczytywanie danych - tworzenie korpusu

data("crude")
crude

###################################################

txt <- system.file("texts", "txt", package = "tm")
txt
(ovid <- VCorpus(DirSource(txt, encoding = "UTF-8"),
                 readerControl = list(language = "lat")))


### VectorSource

###################################################
docs <- c("This is a text.", "This another one.")
VCorpus(VectorSource(docs))



###################################################

reut<- system.file("texts", "crude", package = "tm")
reuters <- VCorpus(DirSource(reut),
                   readerControl = list(reader = readReut21578XMLasPlain))

###################################################

### Podgądanie zawartości

ovid

inspect(ovid)

inspect(ovid[1:2])

inspect(ovid[[1]])

ovid[[1]]$content



###################################################

### Metadane


meta(ovid[[2]])

meta(ovid[[2]], "id")

identical(ovid[[2]], ovid[["ovid_2.txt"]])



###  Zarządzanie metadanymi

### 

idx <- meta(reuters, "id") == '237' 

reuters[idx]

###

DublinCore(crude[[1]], "Creator") <- "Ano Nymous"
meta(crude[[1]])



#############################################

############################################


### 2. Przetwarzanie tekstu w korpusie

# Zapisujemy tekst, zeby później porównać tekst oryginalny z przetworzonym

r1 = reuters[[1]]$content
r1


# Usuwanie nadmiarowych białych znaków

reuters <- tm_map(reuters, stripWhitespace)

# Usuwanie znaków interpunkcyjnych

reuters <- tm_map(reuters, removePunctuation)

?removePunctuation
#reuters <- tm_map(reuters, removePunctuation, preserve_intra_word_dashes=True)


# Zamiana na małe litery

reuters <- tm_map(reuters, content_transformer(tolower))

# funkcje, których nie trzeba obejmowac w wrapper content_transform:
getTransformations()

reuters[[1]]$content

reuters <- tm_map(reuters, content_transformer(gsub), pattern = "\\d+", replacement = "_digit_")

inspect(reuters[[1]])

# Stopwords - słowa uznane za niesistotne z punktu widzenia naszego problemu

stopwords("english")

reuters <- tm_map(reuters, removeWords, stopwords("english"))

# Stemming - usuwanie końcówek (w polskim - lematyzacja)

reuters <- tm_map(reuters, stemDocument)

# Końcowe porównanie:

r1
inspect(reuters[[1]])


### 3. Reprezentacja tekstu


###  Macierz liczności słów

dtm <- DocumentTermMatrix(reuters)

dtm   # - macierz rzadka

inspect(dtm[5:10, 740:743])

dtm$dimnames

as.matrix(dtm[,c("alloc","add")])

?DocumentTermMatrix


inspect(DocumentTermMatrix(reuters,control = list(global=c(5,10)))[1:10,1:10])

inspect(DocumentTermMatrix(reuters,control = list(wordLengths=c(4, 20)))[1:20,1:10])


DocumentTermMatrix(reuters, control=list(wordLengths=c(4, 20),
                                         bounds = list(global = c(3,27))))

# podglad mozliwych "kontrolek" dla dtm:
?termFreq

MC_tokenizer(crude[[1]])[1:30]
scan_tokenizer(crude[[1]])[1:30]


DocumentTermMatrix(reuters, control=list(tokenize=MC_tokenizer,
                                         wordLengths=c(4, 20),
                                         bounds = list(global = c(3,27)),
                                         removePunctuation = list(preserve_intra_word_dashes = TRUE),
                                         stopwords = c("reuter", "that"),
                                         stemming = TRUE))



# n-gramy: https://gist.github.com/benmarwick/5370329

# Częstosci słów:

freq <- colSums(as.matrix(dtm))
freq

# wypisanie częstych słów

findFreqTerms(dtm, 5)

# usuwanie sóww rzadkich z macierzy

inspect(removeSparseTerms(dtm, 0.9))

# szukanie powiązań

findAssocs(dtm, "opec", 0.8)



### Transformacje macierzy częstości

inspect(dtm[,30:40])

inspect(weightBin(dtm)[,30:40])

?WeightFunction()

# przykład własnej transformacji - binaryzacja z zadanym progiem:

weightCutBin <- WeightFunction(function(m, cutoff) m > cutoff,
                               "binary with cutoff", "bincut")

inspect(weightCutBin(dtm[,30:40],2))


### Detekcja slów kluczowych - obliczanie "ważnosci" słów

# Fundamentalna transformacja w przetwarzaniu tekstu: TfIdf

?weightTfIdf

inspect(weightTfIdf(dtm)[,30:40])


####################################################################


###  Case Study: Grupowanie tekstów

# Dane: 11 artykułów Wikipedii
# Cel: pogrupować dane tematycznie

####################################################################

# Ściągnięcie danych

wiki <- "http://en.wikipedia.org/wiki/"
titles <- c("Integral", "Riemann_integral", "Riemann-Stieltjes_integral", "Derivative",
            "Limit_of_a_sequence", "Edvard_Munch", "Vincent_van_Gogh", "Jan_Matejko",
            "Lev_Tolstoj", "Franz_Kafka", "J._R._R._Tolkien")
articles <- character(length(titles))

for (i in 1:length(titles)) {
  articles[i] <- paste(readLines(paste0(wiki, titles[i])),collapse  = " ")
}

articles[1]

# Uwaga: gdybyśmy chcieli dostać czysty tekst, to użylibyśmy do tego gotowych narzędzi do czytania HTMLi!
# Ale celowo pobieramy surowy tekst po to, aby samodzielnie go przetworzyć.

# Obróbka danych:

articles <- Corpus(VectorSource(articles))
articles <- tm_map(articles, function(x) str_replace_all(x, "<script>.+?</script>", " "))
articles <- tm_map(articles, function(x) str_replace_all(x, "<.+?>", " "))
articles <- tm_map(articles, content_transformer(tolower))
articles <- tm_map(articles, stripWhitespace)
articles <- tm_map(articles, removeWords, stopwords("english"))
articles <- tm_map(articles, removePunctuation)

inspect(articles[1])

# Uwaga: Ten tekst nie jest obrobiony w sposób doskonały - na pewno można by to zrobić lepiej. Ale my tego nie potrzebujemy.

dtm <- DocumentTermMatrix(articles)
dtm # zwrocmy uwage na liczbe slow -14 tys

dtm <- DocumentTermMatrix(articles,control=list(bounds=list(global=c(2,Inf))))
dtm # zwrocmy uwage jak dużo słów odpadło

### O czym są dokumenty?:

# Najczęstsze słowa:

findMostFreqTerms(dtm,n = 10)

# "Najważniejsze" słowa:

tfidf <- weightTfIdf(dtm)
tfidf
findMostFreqTerms(tfidf,15)


docsdissim <- dist(tfidf) 
# Uwaga: tutaj używamy odległości euklidesowej, natomiast w praktyce raczej stosuje się metrykę cosinusową
docsdissim
h <- hclust(docsdissim) 

plot(h, labels = titles)
# pogrupowanie nie jest idealne, ale bardzo sensowne (z metryką cosinusową prawdopodobnie byłoby idealnie)


###############################################




### Model LDA - Ukryta Alokacja Dirichleta


data("AssociatedPress", package = "topicmodels")
AssociatedPress
AssociatedPress <- removeSparseTerms(AssociatedPress,0.95)
AssociatedPress

?LDA

# usuwamy wiersze (dokumenty), w których nie zostało żadne słowo
AssociatedPress
AssociatedPress <- AssociatedPress[-which(apply(AssociatedPress,1,sum)==0),]
AssociatedPress

lda <- LDA(AssociatedPress, k = 10, method = "Gibbs", control = list(alpha = 0.1))

lda

post <- posterior(lda, AssociatedPress[21:30,])

# rozkładay słów w tematach - jeden wiersz to jeden temat
post[[1]][1:10,1:10]

# rozklady tematow w dokumentach:
post[[2]][1:10,]

# NJCZESTSZE SLOWA W TEMATACH:
terms(lda,10)

### Wizualizacja modelu LDA

library(LDAvis)

json <- createJSON(
  phi = posterior(lda)[[1]], 
  theta = posterior(lda)[[2]], 
  doc.length = apply(AssociatedPress,1,sum), 
  vocab = unique(as.vector(terms(lda,Inf))), 
  term.frequency = apply(AssociatedPress[,unique(as.vector(terms(lda,Inf)))],2,sum)
)
serVis(json, out.dir = 'vis', 
       open.browser = TRUE)