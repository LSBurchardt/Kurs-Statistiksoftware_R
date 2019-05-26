################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
#24.05/25.05
#21.06/22.06
#
#2. Kurstag, behandelt wurden folgende Themen:
#   - Good Coding Practice 
#   - Datenmanagment
#   - Kreutabellen
#   - lineare Regression und Korrelation
#   - t-test und ANOVA
################################################################

# 00: Pakete laden ---------------------------------------------------------------

library(dplyr)
library(psych)
library(ggplot2)

# 01: Daten einlesen --------------------------------------------------------------

      #...

# 02: Good Coding Practice und Github ----

      #siehe Präsentation Folien 32-34

# Github
# um ein Paket von Github zu laden brauchen wir das Paket "devtools"

install.packages("devtools")

#damit können Pakete von Github geladen werden, hier ein Beispiel

devtools::install_github("kassambara/ggpubr")   #ggpubr: Publication ready plots

# 03: Datenmanagment---------------------------------------------------

# 03a: Teilmengen bilden

#Teilmenge der Studierenden aus Berlin, Funktion: filter()

berliner<-erstis %>% 
  filter(berlin == "ja")

#Teilmenge: Variablen "uni", Funktion: select()

var_uni<-erstis %>% 
  select(code,uni1,uni2,uni3,uni4,uni5,uni6,uni7)

# 03b: Gruppieren und sortieren, Funktionen group_by() und arrange()

erstis %>% 
  group_by(gruppe) %>% 
  summarise_at(vars(alter), list(~mean(.,na.rm=TRUE), ~min(.,na.rm= TRUE, ~max(.,na.rm = TRUE))))


#Sortiert den Datensatz nach Gruppe und Alter

nach_gruppe_alter<-erstis %>% 
  arrange(gruppe, alter)


# NAs filtern um Alter nach Geschlecht darzustellen

mean_nach_alter_geschlecht_2<-erstis %>% 
  filter(geschl == "weiblich" | geschl == "männlich") %>%  # | ist der ODER Operator
  filter(!is.na(geschl)) %>%    #!is.na bedeutet: ist kein "missing value"
    group_by(geschl) %>% 
    summarise_at(vars(alter), list(~mean(.,na.rm= TRUE)))


#andere Variante: erst neuen Datensatz erstellen, dann mean bilden
frauen<-erstis %>% 
  filter(geschl == "weiblich")

frauen.alter.mean<-frauen$alter %>% 
  mean(.,na.rm=TRUE)


# 03c: Datensätze kombinieren

bind_rows() #verbindet Beobachtungen

bind_cols() #verbindet Variablen


# 04 Kreuztabellen ----------------------------------------------------------

attach(erstis)    #über die attach Funktion fügt Datensatz zu Rs "search path" hinzu,
                  #Variablen können in Funktionen direkt angesprochen werden 

#absolute Häufigkeiten
table1<-table(berlin, geschl, useNA = "ifany")  #useN= "ifany" löscht Zeilen, in denen mind. 1 Variable NAs enthalten
addmargins(table(berlin, geschl))

#relative Häufigkeiten
table2<-prop.table(table(berlin, geschl, useNA = "ifany"))
addmargins(prob.table(table(geschl,berlin)))

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
fm<-lm(y~x)  #fm = fittet model, mit der Funktion lm (linear model) wird die lineare Regression berechnet
             # sie wird berechnet für die Formel y~x, in der y durch x erklärt werden soll 

plot(x,y,xlim = c(-3,3), ylim = c(-3,3), pch= 19)   #Daten werden erneut geplotet 
abline(fm,col = "red" )                             # und um die Trendlinie erweitert
fm2<-lm(alter~ abi)

#ggplot mit Trendlinie

ggplot(erstis, aes(x= alter, y= zuf.inh.1))+
  geom_point(color= "skyblue", shape = "square")+
  geom_smooth(method = 'lm', se = FALSE) 

#Korrelation mit cor() und corr.test()
xy<-data.frame(x,y)         # wir wollen wissen wie stark der Zusammenghang ist und rechnen eine Korrelation
cor1<-cor(xy)               # simpelste Version der Pearson-Korrelation (Produkt-Moment Korrekation) in R
print(cor1)                 # im Output werden nur die Regressionskoeffizienten dargestellt

cor2<-corr.test(xy)         # Version der Pearson-Korrelation aus dem "psych" Paket
print(cor2)                 # es können Stichprobengrößen und p Werte ausgegeben werden 
print(cor2, short = FALSE)


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

alter_frauen <-erstis %>% 
  filter(geschl == "weiblich") %>% 
  select(alter)

alter_maenner <-erstis %>% 
  filter(geschl == "männlich") %>% 
  select(alter)

res_t_test<-t.test(alter_frauen,alter_maenner)

#Unterscheiden sich die Gruppen hinsichtlich der Alterszusammensetzung?
res_aov<-aov (alter~gruppe, data = erstis)

summary(res_aov)



