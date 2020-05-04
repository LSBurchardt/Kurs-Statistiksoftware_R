################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
# Onlinesemester Sommer 2020 
#08.05/09.05
#12.06/13.06
#
# Der hier vorgestellte Code stellt Möglichkeiten dar, die Übungen aus der PowerPoint Präsentation umzusetzen. Das Skript 
# enthält nicht alle Teile der Präsentation, beide Dokumente sollen im Zusammenhang verwendet werden. Grundlegende Erklärungen 
# finden sich fast ausschließlich in der Präsentation. 
# Es geht hier vorallem um das Ausprobieren von verschiedenen Funktionen und dem Kennenlernen der Funktionalität von R.
#
#
#1. Kurstag, behandelt werden folgende Themen:
#   - das Einlesen und exportieren von Daten 
#   - Zahlen- und Datenformate in R
#   - R als Taschenrechner
#   - Hilfe in R
#   - Pakte
#   - Abbildungen mit ggplot und Basisfunktionen
#
################################################################
# 00: Pakete laden ---------------------------------------------------------------

library(ggplot2)

# 01: Daten einlesen --------------------------------------------------------------
#Daten einlesen und speichern: Ladet den Ordner "Daten.zip" von 'beltz.de/r-fuer-einsteiger' herunter
#und ladet den Datensatz "Erstis" auf verschiedenen Arten in den Workspace
# Erstellt dafür in eurem Projektordner einen Ordner "Daten".


#Variante 1: .RData laden mit load()

load('')       # Dateiname bzw. Pfad in Anfuehrungszeichen
# Diese Pfadangabe sieht die folgende Pfad Struktur vor:
# im Ordner des R Projekts liegt der Ordner "Daten" mit dem Subordner "Erstis"
#Variante 2: read.csv()

data<-read.csv('', sep= "")  # sep = Separator der Spalten, Dateinamen bzw. Pfad in Anfuehrungszeichen

#Variante 3: Daten aus dem File-Tab importieren
# gewuenschte Datei auswählen --> Import Dataset --> gewuenschte Einstellungen waehlen --> Import

#02: Daten speichern ---------------------------------------------------------------
#Speichert die eben geladenen Daten auf unterschiedliche Varianten
#Variante 1: als .csv speichern um in anderen Programmen zu nutzen

write.table(data, file= "", sep = , dec= )  # Objekt das gespeichert werden soll, Dateiname zum speichern
# sep = Separator, dec = Dezimaltrennzeichen

#Variate 2: als .rds speichern

saveRDS(erstis, 'Myfile.rds')     # Objekt, Dateiname zum Speichern mit Dateiendung

#03: Zahlen- und Datenformate -----------------------------------------------------------

# Zahlenformate

#numeric
a<- 10.4
class(a)
#Integer
b<- 10L
class(b)
#character
c<-"Hello World"
class(c)
#logical
d<-TRUE
class(d)

# Datenformate

# Vector, Funktion: c() 
a_vector<-

# Matrix, Funktion: matrix()
a_matrix<-

# Faktoren, Funktion um einen Vektor umzucodieren: factor()
a_factor<-

# Dataframe, Funktion um bestehende Elemente zu Dataframe zu verbinden: data.frame
char5<-c("a", "b", "c", "d", "e")
a_data_frame<-data.frame(a_matrix, char5)
# Um Spaltennamen hinzuzufügen wird die Funktion colnames() verwendet

colnames(a_data_frame)<-c()

# Listen, Funktion: list()
a_list<-
  
# 04: R als Taschenrechner-------------------------------------------------------------

#mathematische Operatoren in R findet ihr in der Präsentation 

# 05: Hilfe in R ---------------------------------------------------------------------

help(mean)  #zeigt die Dokumentation zur Funktion "mean" an

?median     # zeigt die Dokumentation zu Funktion "median" an

#markiert eine Funktion und drückt "F1" um euch die Dokumentation anzeigen zu lassen

# 06: Pakete in R --------------------------------------------------------------------

# Pakete enthalten weitere Funktionen und Funktionisgruppen, zusaetzlich zu den Moeglichkeiten der Basisversion.
# Sie koennen ueber Tools --> Install Packages geladen werden, oder ueber den Befehl: install.packages()

#Installiert das Paket "ggplot2" und das Paket "dplyr" jeweils über einen der beiden Moeglichkeiten

install.packages("ggplot2")


# Für jede Session müssen die benötigten Pakete geladen werden, Funktion: library("Paketname")

library(ggplot2)

# 07: Abbildungen mit ggplot und Basisfunktionen--------------------------------------------------------

# In ggplot werden DATEN (data) mit AESTHETICS (aes) genauer bestimmt und über MARKER (z.B geom_point) dargestellt


#Grundstruktur von ggplot am Beispiel eines Scatterplots 

a_scatterplot <- ggplot(data = , aes(x= , y= ))+
  geom_point()+
  
  #Achsen und Title mit der Ebene labs() hinzufügen
  
  labs(x= , y= , title= )+
  
  #die Schriftgröße der Achsenbeschriftung über die theme() Ebene verändern

  theme(axis.title = element_text(size = 14))

a_scatterplot   #zeigt den oben als Objekt gespeicherten Plot an

# Histogramm mit ggplot, in dem jeder Säule eine Farbe zugeordnet wird

# Erstelle ein Histogram mit ggplot, nutze zum Beispiel das ggplot Cheatsheet

a_histogram<-ggplot(data= , aes(x = ))+
  

a_histogram


#Boxplot mit ggplot

a_boxplot<-ggplot(data= , aes(x= , y= ))+
  

a_boxplot


#Abbildungen mit Basisfunktionen

#Scatterplot
plot(x= , y= )

#Boxplot
boxplot( data = )


# Pie Chart
pie(table())
    

# Histogram Basisfunktion, Zufriedenheit, mit Pipeoperator und Legende
