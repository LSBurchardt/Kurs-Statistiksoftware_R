################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
# Onlinesemester Sommer 2020 
# 08.05/09.05
# 12.06/13.06
#
# Der hier vorgestellte Code stellt Möglichkeiten dar, die Übungen aus der PowerPoint Präsentation umzusetzen. Das Skript 
# enthält nicht alle Teile der Präsentation, beide Dokumente sollen im Zusammenhang verwendet werden. Grundlegende Erklärungen 
# finden sich fast ausschließlich in der Präsentation. 
# Es geht hier vorallem um das Ausprobieren von verschiedenen Funktionen und dem Kennenlernen der Funktionalität von R.
#
#2. Kurstag, behandelt werden folgende Themen:
#   - Good Coding Practice 
#   - Datenmanagment
#   - Kreutabellen
#   - lineare Regression und Korrelation
#   - t-test und ANOVA
################################################################

# 00: Pakete laden ---------------------------------------------------------------

library(tidyverse)
library(psych)


# 01: Daten einlesen --------------------------------------------------------------

      #...

# 02: Good Coding Practice und Github ----

      #siehe Präsentation Folien 

# Github
# um ein Paket von Github zu laden brauchen wir das Paket "devtools"

install.packages("")

#damit können Pakete von Github geladen werden, hier ein Beispiel

devtools::install_github("kassambara/ggpubr")   #ggpubr: Publication ready plots

# 03: Datenmanagment---------------------------------------------------

# 03a: Teilmengen bilden

#Teilmenge der Studierenden aus Berlin, Funktion: filter()

berliner<-erstis %>% 
  

#Teilmenge: Variablen "uni", Funktion: select()

var_uni<-erstis %>% 
  

# 03b: Gruppieren und sortieren, Funktionen group_by() und arrange()

erstis %>% 
  group_by() %>% 
  summarise_at(vars(alter), list(~mean(.,na.rm=TRUE), ~min(.,na.rm= TRUE, ~max(.,na.rm = TRUE))))

#Verstehe die oben abgebildete Funktion, was passiert? Welches Argument macht was?

#Sortiert den Datensatz nach Gruppe und Alter (arrange)

nach_gruppe_alter<-erstis %>% 
  


# NAs filtern um Alter nach Geschlecht darzustellen

mean_nach_alter_geschlecht_2<-erstis %>% 
  filter(!is.na(geschl)) %>%    #!is.na bedeutet: ist kein "missing value"
    group_by(geschl) %>% 
    summarise_at(vars(alter), list(~mean(.,na.rm= TRUE)))

#Beschreibe in deinen eigenen Worten was hier passiert.


#andere Variante: erst neuen Datensatz erstellen, dann mean bilden
frauen<-erstis %>% 
  

frauen.alter.mean<-frauen$alter %>% 
  


# 03c: Datensätze kombinieren

bind_rows() #verbindet Beobachtungen

bind_cols() #verbindet Variablen


# 04 Kreuztabellen ----------------------------------------------------------

attach(erstis)    #die attach Funktion fügt Datensatz zu Rs "search path" hinzu,
                  #Variablen können in Funktionen direkt angesprochen werden 

#absolute Häufigkeiten
table1<-table( useNA = "ifany")  #useN= "ifany" löscht Zeilen, in denen mind. 1 Variable NAs enthalten
addmargins()

#relative Häufigkeiten
table2<-prop.table(table( useNA = "ifany"))
addmargins()

#Häufigkeitstabellen mit dem Pipe Operator
#Variante 1
tab_berlin_geschl<-table(berlin, geschl)
  
tab_berlin_geschl %>% 
prop.table() %>% 
  addmargins() %>% 
  print(digits= 3)    #Dezimalstellen im Output werden auf 3 digits begrenzt

#Variante2
table(berlin,geschl) %>% 
  prop.table() %>% 
  addmargins()
print(digits = 2)

# 05: lineare Regression und Korrelation -----------------------------------------------------------

#Wir erstellen zwei Vektoren als Datengrundlage
x <- c(-2, -1, -0.8, -0.3, 0, 0.5, 0.6, 0.7, 1, 1.2)
y <- c(1.9, 0.6, 0.5, 0.8, -0.4, -0.9, -0.7, -0.1, -1.7, -0.2)

# lineare Regression mit lm()
fm <- lm()  #fm = fittet model, mit der Funktion lm (linear model) wird die lineare Regression berechnet
             # sie wird berechnet für die Formel y~x, in der y durch x erklärt werden soll 

plot(x,y,xlim = c(-3,3), ylim = c(-3,3), pch= 19)   #Daten werden erneut geplotet 
abline(fm,col = "red" )                             # und um die Trendlinie erweitert

fm2 <- lm(alter~ abi)

#ggplot mit Trendlinie

ggplot(erstis, aes(x= alter, y= zuf.inh.1))+
  geom_point(color= "skyblue", shape = "square")+
  geom_smooth(method = 'lm', se = FALSE) 

#Korrelation mit cor() und corr.test()
xy<-data.frame(x,y)         # wir wollen wissen wie stark der Zusammenghang ist und rechnen eine Korrelation
cor1<-cor()               # simpelste Version der Pearson-Korrelation (Produkt-Moment Korrelation) in R
print(cor1)                 # im Output werden nur die Regressionskoeffizienten dargestellt

cor2<-corr.test()         # Version der Pearson-Korrelation aus dem "psych" Paket
print(cor2)                 # es können Stichprobengrößen und p Werte ausgegeben werden 
print(cor2, short = FALSE)


#führt eine Korrelationsanalyse durch, bildet dazu einen dataframe aus mindestens 3 Variablen
auswahl<-data.frame()
cor()

# Warum ergeben sich nur NAs? Weil NAs in den Daten vorhanden sind.
#Wie umgehen wir das? --> 'use' Argument in cor-Funktion
#schaut euch die Hilfe an und probiert die Varianten aus.
#Verwendet den Pipe Operator.

cor3<-auswahl %>% 
  cor()

cor4<-auswahl %>% 
  cor()

cor5<-auswahl %>% 
  corr.test()

#Lasst euch die Ergebnisse ausgeben. Was für Aussagen kann man treffen?

# 06: t-test und ANOVA--------------------------------------------------------

#Unterscheiden sich Frauen & Maenner hinsichtlich des Alters?
#t.test()

boxplot()

alter_frauen <-erstis %>% 
  filter() %>% 
  select()

alter_maenner <-erstis %>% 
  filter() %>% 
  select()

results_t_test<-t.test()

#Unterscheiden sich die Gruppen hinsichtlich der Alterszusammensetzung?
results_aov<-aov ()

summary(results_aov)



