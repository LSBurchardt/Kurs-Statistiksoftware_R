################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
#24.05/25.05
#21.06/22.06
#
################################################################


#2. Kurstag

# 00: Pakete laden ---------------------------------------------------------------
library(dplyr)
library(psych)



# 01: Daten einlesen --------------------------------------------------------------

# 02: Good Coding Practice

# 03: Datenmanagment

# 03a: Teilmengen bilden

# 03b: Gruppieren

# 03c: Datensätze kombinieren

# 04 Kreuztabellen ----------------------------------------------------------

# 05: Korrelation -----------------------------------------------------------

x <- c(-2, -1, -0.8, -0.3, 0, 0.5, 0.6, 0.7, 1, 1.2)
y <- c(1.9, 0.6, 0.5, 0.8, -0.4, -0.9, -0.7, -0.1, -1.7, -0.2)
xy<-data.frame(x,y)
cor1<-cor(xy)
print(cor1)

cor2<-corr.test(xy)
print(cor2)
print(cor2, short = FALSE)

# Korrelation zwischen den Variablen abi, alter und zuf.inh.1

auswahl<-data.frame(alter, abi, zuf.inh.1)
cor(auswahl)

# Warum ergeben sich nur NAs? Weil NAs in den Daten vorhanden sind
#Wie umgehen wir das? 'use' argument in cor-Funktion
#schaut euch die hilfe an und probiert die Varianten aus.
#Verwendet den Pipe Operator

cor3<-auswahl %>% 
  cor(use = "complete")

cor4<-auswahl %>% 
  cor(use= "pairwise")

cor5<-auswahl %>% 
  corr.test()

#Lasst euch die Ergebnisse ausgeben. Was für Aussagen kann man treffen?
