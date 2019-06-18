#################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
#24.05/25.05
#21.06/22.06
#
################################################################


#4. Kurstag

# 00: Pakete laden ---------------------------------------------------------------

library(tidyverse)  #includes for example ggplot2, dplyr
library(psych)
library(cluster) 
library(NbClust)
library(plotly)
library(nycflights13)

# 01: Daten einlesen --------------------------------------------------------------

#Lade den Datensatz "Erstis"

# 02: Fehler beheben---------------------------------------------------------------

# Führe den Code aus und verstehe und behebe (wenn möglich) die Fehler.

#1

data<-mtcars
plot(data$mpg, Data$qsec)

#2

data.2 <- iris
plot(Sepal.Length,Sepal.Width)

#3

mean(iris$Species)


mean()




# 03: Text Mining

library(tm)
library(pdftools)
library(wordcloud)

file.location <- "Wahlprogramme/fdp.pdf"

txt <- pdf_text(file.location)

#Corpus erstellen
txt_corpus <- Corpus(VectorSource(txt))

# Corpus aufreinigen

txt_corpus <- tm_map(txt_corpus, tolower)   #alles klein geschrieben
txt_corpus <- tm_map(txt_corpus, removePunctuation) #Interpunktion entfernt
txt_corpus <- tm_map(txt_corpus, stripWhitespace)   # Leerzeichen löschen

#Stop Wörter entfernen

txt_corpus <- tm_map(txt_corpus, removeWords, stopwords("de"))

# Inhalt des Corpus angucken

txt_corpus$content

# Dokument-TErm-Matrix erstellen

dtm <- DocumentTermMatrix(txt_corpus)
dtm <- as.matrix(dtm)

number.occurences <- colSums(dtm)
number.occurences <- sort(number.occurences, decreasing = TRUE)

#plot WordCloud

wordcloud(head(names(number.occurences),30), head(number.occurences, 30), scale = c(2,1))


# Erstelle anhand der erhaltenen Wordcloud einen Vektor mit weiteren Stopwörtern und entferne auch diese.
# Lass die Analyse erneut laufen und dir eine neue Wordcloud ausgeben. 

# 04: Plotly

# Daten laden: "Daten/timeseries_example.rds"

a <- list(title = "Date",
          showticklabels = TRUE)
g<- list(
  title = "Temperature [deg C]",
  showticklabels = TRUE)

p2<-plot_ly(sub.df.timeseries.data, name = "Mean Temperature", showlegend = FALSE) %>%
  
  add_trace(x= ~sub.df.timeseries.data$date_mean, y= ~sub.df.timeseries.data$Tem_mean,type= 'scatter',
            mode= 'markers', marker = list(symbol= "circle", size=4, color="grey"),
            #error_y= ~list(type = "data", array=df.sub$Tem_sd,color= "grey"),
            hoverinfo = 'text',
            text = ~paste('</br> Mean Temp',
                          '</br> Date', sub.df.timeseries.data$date_mean,
                          '</br> Mean: ',  round(sub.df.timeseries.data$Tem_mean, digits= 2) ,
                          '</br> Max: ', round(sub.df.timeseries.data$Tem_max, digits = 2),
                          '</br> Min: ', round(sub.df.timeseries.data$Tem_min, digits = 2))) %>%
  layout(xaxis = a, yaxis = g, autosize = FALSE)

# Baue einen interaktiven Plot für einen Datensatz und eine Variablenkombination deiner Wahl
