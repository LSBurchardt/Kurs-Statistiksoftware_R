#################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
#24.05/25.05
#21.06/22.06
#
################################################################


#3. Kurstag

# 00: Pakete laden ---------------------------------------------------------------

library(tidyverse)  #includes for example ggplot2, dplyr
library(psych)

# 01: Daten einlesen --------------------------------------------------------------

# 02: for loops -------------------------------------------------------------------

#Ohne loop
df <- tibble(
  a = rnorm(10),        
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

median(df$a)

median(df$b)

median(df$c)

median(df$d)

# Mit Loop --anderes Beispiele--


 output <- vector ()     #leerer Vektor wird erstellt
 
 for (x in c(1:10))      # Sequenz wird definiert
  output[x] <- x + (x+1) # was soll getan werden?


 #Beispiel ohne abzuspeicherndes Output
 
for (year in c(2010,2011,2012,2013,2014,2015)){
  print(paste("The year is", year))
}

#Was macht die Funktion rnorm() ?


#ÜBUNGEN
 
# 1. Baut einen for-loop um den Median von a,b,c und d zu berechnen
# https://r4ds.had.co.nz/iteration.html

#1. Platz für Output schaffen


#2. Sequenz definieren


#3. Was soll entlang der Sequenz getan werden?  
 
#2. Berechnet den Mittelwert jeder Spalte in „mtcars“ mit einem loop
# mtcars ist ein in R integrierter Datensatz und kann direkt angesprochen werden
 view(mtcars)
 
#3. Bestimmt den Typ (class) jeder Spalte in „nycflights13::flights“ in einem loop.  
# Datensatz "flight" enthalten im Package "nycflights13"
 
install.packages("nycflights13")

#4. Berechnet die Anzahl an einzigartigen (unique) Werten jeder Spalte des Datensatz „iris“.
# Iris ist ebenfalls ein in R integrierter Datensatz. 

view(iris)

#5. Erzeugt 10 Zufallszahlen einer Normalverteilung um die Mittelwerte μ=−10, 0, 10, and 100. 
