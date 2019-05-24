################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
#24.05/25.05
#21.06/22.06
#
################################################################

#1. Kurstag
# 01: Daten einlesen --------------------------------------------------------------
#Daten einlesen und speicher: Ladet den Ordner "Daten.zip" von beltz.de/r-fuer-einsteiger herunter
#und lade den Datensatz "Erstis" auf verschiedenen Arten in den Workspace

#Variante 1: .RData laden mit load()

load('Daten/Erstis/erstis.RData')       # Dateiname bzw. Pfad in Anfuehrungszeichen

#Variante 2: read.csv()

data<-read.csv('../Erstis.csv', sep= ";")  # sep = Separator der Spalten, Dateinamen bzw. Pfad in Anfuehrungszeichen

#Variante 3: Daten aus dem File-Tab importieren
# gewuenschte Datei auswählen --> Import Dataset --> gewuenschte Einstellungen waehlen --> Import

#02: Daten speichern ---------------------------------------------------------------
#Speichert die eben geladenen Daten auf unterschiedliche Varianten
#Variante 1: als .csv speichern um in anderen Programmen zu nutzen

write.table(erstis, file= "Myfile.csv", sep = ";", dec= ".")  # Objekt das gespeichert werden soll, Dateiname zum speichern
                                                              # sep = Separator, dec = Dezimaltrennzeichen

#Variate 2: als .rds speichern

saveRDS(erstis, 'Myfile.rds')     # Objekt, Dateiname zum Speichern mit Dateiendung

#03: Zahlen- und Datenformate -----------------------------------------------------------

# Zahlenformate

a<- 10.4
class(a)

b<- 10L
class(b)

c<-"Hello World"
class(c)

d<-TRUE
class(d)

# Datenformate

a_vector<-c("x","z","x","y","x","x","y","y","x")

a_matrix<-matrix(1:15,5,3)

a_factor<-factor(a_vector)

not_a_factor<-unclass(a_factor)   #levels der Daten mit numerischer Info

char5<-c("a", "b", "c", "d", "e")
a_data_frame<-data.frame(a_matrix, char5)

colnames(a_data_frame)<-c("Spalte 1", "Spalte 2", "Spalte 3 ", "Spalte 4")

a_list<-list(a,b,c,d,char5,a_data_frame)
# 04: R als Taschenrechner-------------------------------------------------------------

# 05: Hilfe in R ---------------------------------------------------------------------

# 06: Pakete in R --------------------------------------------------------------------

# Pakete enthalten weitere Funktionen und Funktionisgruppen, zusaetzlich zu den Moeglichkeiten der Basisversion.
# Sie koennen ueber Tools --> Install Packages geladen werden, oder ueber den Befehl: install.packages()

#Installiert das Paket "ggplot2" und das Paket "dplyr" jeweils über einen der beiden Moeglichkeiten

install.packages("")

# Lege eine eigene "Paket Library" für diesen Kurs an und installiere die beiden Pakete in diesem Ordner

install.packages("",lib= "path of your project")

# Lade die Pakete fuer diese Session mit require oder library
  
library(zoo)                          # gibt eine Fehlermeldung wenn das Paket nicht installiert ist

require(ggplot2)                      # gibt eine Warnung wenn das Paket nicht installiert ist

# 07: Abbildungen mit ggplot und Basisfunktionen--------------------------------------------------------

library(ggplot2)

#Grundstruktur von ggplot am Beispiel eines Scatterplots 
a<-ggplot(data= erstis, aes(x= gebjahr, y = alter))+
  geom_point()+
  geom_line()

#Titel und Achsen hinzufügen/ändern

a<-a+
  labs(x= "Geburtsjahr", y= "Alter", title= "Zusammenhang von Geburtsjahr und Alter",
       subtitle = "Unerwartetet eindeutig", cex.lab= 1.4)+
  theme(axis.title = element_text(size = 14))

a

# Abbildungen mit Basisfunktionen

plot(x= erstis$gebjahr, y= erstis$alter)

hist(erstis$alter)

boxplot(alter~gruppe, data = erstis)
boxplot(erstis$alter~erstis$gruppe)

pie(table(erstis$geschl))


