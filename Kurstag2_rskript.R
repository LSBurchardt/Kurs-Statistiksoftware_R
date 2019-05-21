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
library(ggplot2)



# 01: Daten einlesen --------------------------------------------------------------


# 02: Good Coding Practice


# 03: Datenmanagment

# 03a: Teilmengen bilden

#Teilmenge der Studierenden aus Berlin

berliner<-erstis %>% 
  filter(berlin == "ja")

#Teilmenge: Variablen "uni"

var_uni<-erstis %>% 
  select(code,uni1,uni2,uni3,uni4,uni5,uni6,uni7)

# 03b: Gruppieren und sortieren

#Wofür kann die Funktion group_by() gebraucht werden?

#Sortiert den Datensatz nach Gruppe und Alter

nach_gruppe_alter<-erstis %>% 
  arrange(gruppe, alter)

# 03c: Datensätze kombinieren

# 04 Kreuztabellen ----------------------------------------------------------

# 05: lineare Regression und Korrelation -----------------------------------------------------------

#Wir erstellen zwei Vektoren als Datengrundlage
x <- c(-2, -1, -0.8, -0.3, 0, 0.5, 0.6, 0.7, 1, 1.2)
y <- c(1.9, 0.6, 0.5, 0.8, -0.4, -0.9, -0.7, -0.1, -1.7, -0.2)

plot(x,y)
fm<-lm(y~x)  #fm = fittet model, mit der Funktion lm (linear model) wird die lineare Regression berechnet
             # sie wird berechnet für die Formel y~x, in der y durch x erklärt werden soll 

plot(x,y,xlim = c(-3,3), ylim = c(-3,3), pch= 19)   #Daten werden erneut geplotet 
abline(fm,col = "red" )                             # und um die Trendlinie erweitert

xy<-data.frame(x,y)         # wir wollen wissen wie stark der Zusammenghang ist und rechnen eine Korrelation
cor1<-cor(xy)               # simpelste Version der Pearson-Korrelation (Produkt-Moment Korrekation) in R
print(cor1)                 # im Output werden nur die Regressionskoeffizienten dargestellt

cor2<-corr.test(xy)         # Version der Pearson-Korrelation aus dem "psych" Paket
print(cor2)                 # es können Stichprobengrößen und p Werte ausgegeben werden 
print(cor2, short = FALSE)

# Korrelation zwischen den Variablen abi, alter und zuf.inh.1
# plottet die Variablen, alter gegen zuf.inh.1 und abi gegen zuf.inh.1
plot()

ggplot()
#führt eine Korrelationsanalyse durch
auswahl<-data.frame(alter, abi, zuf.inh.1)
cor(auswahl)

# Warum ergeben sich nur NAs? Weil NAs in den Daten vorhanden sind.
#Wie umgehen wir das? --> 'use' Argument in cor-Funktion
#schaut euch die Hilfe an und probiert die Varianten aus.
#Verwendet den Pipe Operator.

cor3<-auswahl %>% 
  cor(use = "complete")

cor4<-auswahl %>% 
  cor(use= "pairwise")

cor5<-auswahl %>% 
  corr.test()

#Lasst euch die Ergebnisse ausgeben. Was für Aussagen kann man treffen?

# 06: t-test und ANOVA--------------------------------------------------------

#Unterscheiden sich Frauen & Maenner hinsichtlich des Alters?
#t.test()

boxplot(erstis$alter~erstis$geschl)
res_t_test<-t.test(alter_frauen,alter_maenner)

#Unterscheiden sich die Gruppen hinsichtlich der Alterszusammensetzung?

res_aov <- aov (gruppe~alter, data = erstis)




