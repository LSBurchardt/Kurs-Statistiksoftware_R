################################################################
#Statistiksoftware R
#Dozentin: Lara S. Burchardt, l.s.burchardt@gmx.de
#
#24.05/25.05
#21.06/22.06
#
#1. Kurstag, behandelt wurden folgende Themen:
#   - das Einlesen und exportieren von Daten 
#   - Zahlen- und Datenformate in R
#   - R als Taschenrechner
#   - Hilfe in R
#   - Pakte
#   - Abbildungen mit ggplot und Basisfunktionen
################################################################
# 00: Pakete laden ---------------------------------------------------------------

library(ggplot2)

# 01: Daten einlesen --------------------------------------------------------------
#Daten einlesen und speicher: Ladet den Ordner "Daten.zip" von 'beltz.de/r-fuer-einsteiger' herunter
#und lade den Datensatz "Erstis" auf verschiedenen Arten in den Workspace

#Variante 1: .RData laden mit load()

load('Daten/Erstis/erstis.RData')       # Dateiname bzw. Pfad in Anfuehrungszeichen
# Diese Pfadangabe sieht die folgende Pfad Struktur vor:
# im Ordner des R Projekts liegt der Ordner "Daten" mit dem Subordner "Erstis"
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
a_vector<-c("x","z","x","y","x","x","y","y","x")

# Matrix, Funktion: matrix()
a_matrix<-matrix(1:15,5,3)

# Faktoren, Funktion um einen Vektor umzucodieren: factor()
a_factor<-factor(a_vector)

# Dataframe, Funktion um bestehende Elemente zu Dataframe zu verbinden: data.frame
char5<-c("a", "b", "c", "d", "e")
a_data_frame<-data.frame(a_matrix, char5)
# Um Spaltennamen hinzuzufügen wird die Funktion colnames() verwendet
colnames(a_data_frame)<-c("Spalte 1", "Spalte 2", "Spalte 3 ", "Spalte 4")

# LIsten, Funktion: list()
a_list<-list(a,b,c,d,char5,a_data_frame)
# 04: R als Taschenrechner-------------------------------------------------------------

#mathematische Operatoren in R findet ihr in der Präsentation auf Folie 15

# 05: Hilfe in R ---------------------------------------------------------------------

help(mean)  #zeigt die Dokumentation zur Funktion "mean" an

?median     # zeigt die Dokumentation zu Funktion "median" an

#markiert eine FUnktion und drückt "F1" um euch die Dokumentation anzeigen zu lassen

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
a_scatterplot<-ggplot(data = erstis, aes(x= gebjahr, y= alter))+
  geom_point(color = "darkred", shape = "square")+
  
  #Achsen und Title mit der Ebene labs() hinzufügen
  
  labs(x= "Geburtsjahr", y= "Alter", title= "Zusammenhang von Geburtsjahr und Alter",
       subtitle = "Unerwartetet eindeutig", cex.lab= 1.4)+
  
  #die Schriftgröße der Achsenbeschriftung über die theme() Ebene verändern

  theme(axis.title = element_text(size = 14))

a_scatterplot   #zeigt den oben als Objekt gespeicherten Plot an

# Histogramm mit ggplot, in dem jeder Säule eine Farbe zugeordnet wird

colors<-c(rep("red", 2), rep("blue", 2), rep("green", 2), rep("darkred", 2))

a_histogram<-ggplot(data= erstis, aes(x= gebjahr))+
  geom_histogram(binwidth = 5, fill = colors)

a_histogram

a_2_histogram<-ggplot(data= erstis, aes(x= alter))+
  geom_histogram(binwidth= 10, fill = c("red", "blue", "green", "yellow"))+
  labs(title= "Häufigkeitsverteilung Alter", x = "Alter", y= "Anzahl")+
  theme_bw(base_size= 15)

a_2_histogram

#Boxplot mit ggplot

a_boxplot<-ggplot(data= erstis, aes(x= gruppe, y= alter))+
  geom_boxplot(outlier.shape=6)+          #outlier.shape -> Form der Outlier, Zahlen 1-20 codieren verschiedene Formen
  theme_bw()

a_boxplot


#Abbildungen mit Basisfunktionen

#Scatterplot
plot(x= erstis$gebjahr, y= erstis$alter)

#Boxplot
boxplot(alter~gruppe, data = erstis)
boxplot(erstis$alter~erstis$gruppe)

# Pie Chart
pie(table(erstis$wohnort.alt),
    labels= c("altes Bundesland", "neues Bundesland", "Berlin", "Ausland"),
    radius = 1, edges= 500)

# Histogram Basisfunktion, Zufriedenheit, mit Pipeoperator und Legende
erstis$zuf.inh.1 %>% 
  hist(main= "Zufriedenheit mit Studieninhalten",
       xlab = "Grad der Zufriedenheit",ylab= "Häufigkeit", 
       breaks= 3, col = c("blue", "darkblue", "navy"), 
       labels = c("unzufrieden", "mittel", "zufrieden"),
       ylim= c(0,100),
       cex.axis= 1.5, cex.main= 1.5, cex.lab= 1.5)
legend("topleft", legend = c("unzufrieden", "mittel", "zufrieden"),
       fill = c("blue", "darkblue", "navy"))