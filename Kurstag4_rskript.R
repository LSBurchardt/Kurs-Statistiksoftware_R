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
library(shiny)

# 01: Daten einlesen --------------------------------------------------------------

#Lade den Datensatz "Erstis"
#Lade den Datensatz "sub.df.timeseries.data" (liegt in Stine)

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

#4

M <- cor(mtcars)
corrplot(M, method = "circles")

#5 

output <- vector[]     #leerer Vektor wird erstellt

for x in c(1:10)      # Sequenz wird definiert
  output[x] <- x + (x+1) # was soll getan werden?

#6
  
ggplot(erstis, (x= Alter, y= zuf.inh.1))+
  geom_point(color= "skyblue", shape = "square")
  geom_smooth(method = 'l m', se = FALSE) 
  
#7
  
erstis$alter[193] <- 78

#8 
mean.column <- mean(erstis[1:191,57], na.rm = TRUE) 

#9

mean <- mean(erstis$alter)
if (mean > 12) {print("c is greater than 12")}

#10
letters.mat <- matrix(NA, nrow = 5, ncol = 5)

for (m in 1:6) {
    for (n in 1:5){letters.mat[m,n] <- (letters[n])}
}
print(letters.mat)


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

# 04: Plotly -------------------------------------------------------

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


# 05: Shiny -----------------------------------------------------------

#https://shiny.rstudio.com/ 

# Öffne eine neue Datei im File Tab. Wähle dafür die Option "Shiny Web App..."
# Wie ist die App aufgebaut? Welche Teile sind zu erkennen und was macht die App?
# Probiert ein wenig herum, z.B: fügt einen weiteren Slider hinzu, erzeugt ein zweites Histogram mit
# den Daten aus dem zweiten Slider (der Datensatz "faithful" der verwendet wird, enthält eine zweite Variable)

# 06: R Markdown -------------------------------------------------------

# Oeffnet ein neues File und wählt die Option "R Markdown". Füllt die notwendigen Felder aus und erstellt das Dokument.


---
title: "R Kurs"
author: "Lara S. Burchardt"
date: "20 Juni 2019"
output: word_document
---

# Text wird einfach eingegeben. Ein Code Chunk wird mit ``` gestartet und beendet.
# Nach dem Start steht mindestens {r} hier können auch weitere Optionen eingefügt werden, der Chunk kann benannt werden
# und es kann angegeben werden, ob man den R Code im Dokument sehen soll (default bzw. include = TRUE) oder nicht (include = FALSE)
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
  
```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

  
# Soll das Output gezeigt werden, aber nicht der Code, müssen die Optionen include = TRUE (default, kann also weggelassen werden) und echo = FALSE gesetzt werden.
  ```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

# Erstellt ein R Markdown Dokument. Stellt euch hier ein Dokument zusammen, dass übersichtlich die Lerninhalte des Kurses darstellt.
# Erklärungen, Codeschnippsel und Beispielplots oder Tabellen z.B zum: 
# 1) laden und speichern von Daten, 
# 2) Datenformate, wie sie erstellt werden und wie das Output aussieht
# 3) Hilfe in R
# 4) ein Scatterplot in ggplot
# 5) ein Boxplot in ggplot
# 6) ein Histogram
# 7) weitere verwendete oder fuer euch wichtige Plots
# 8) Datenmanagment (filter, select, group_bym summarize_at, summarize_all, etc.)
# 9) Haufigkeitstabellen
# 10) lineare Regression 
# 11) Korrelation 
# 12) t test und ANOVA
# 13) for loops
# 14) if Abfragen
# 15) PCA und Faktoranalyse
# 16) Clusteranalyse
# 17) Hinweise zur Behebung von Fehlern
# 18) weitere Möglichkeiten in R (textmining, plotly, shiny)

# Beendet dieses Dokument als zweite Hausaufgabe. Das Dokument ist eure Hilfestellung für weitere Arbeiten in R
# und sollte deshalb so detailiert sein, wie ihr es gerne hättet und die Themen beinhalten, die für euch am wichtigsten sind.
# Abgabe: klären wir im Kurs.