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
library(cluster) 
library(NbClust)

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

# 03: if Abfragen -------------------------------------------------------

# if 
x <- 5 
if(x > 0){
 print("Positive number") 
      } 

# if-else

x <- -5

 if(x > 0) {
   print("Non-negative number")
   } else {
   print("Negative number")
   }

# eigene Beispiele

# Syntax für mehr als zwei Alternativen?

# 04: Faktoranalyse und PCA ----------------------------------------------

# verwendet den Datensatz mtcars

data <- mtcars %>% 
  scale(center = TRUE, scale = TRUE)

# PCA mit prcomp, schau dir die Dokumentation an

pca <- prcomp(data)

#Versuche die Ergebnisse nachzuvollziehen, welche Werte werden in "pca" abgespeichert?

# Plotte die ersten beiden PCA Achsen

# Wie viel Variation in den Daten wird durch die ersten beiden PCA Achsen erklärt?

# Was wird in einem Biplot dargestellt?

biplot(pca)

# Faktoranalyse mit fa

kmo.factor <- KMO (mtcars) # Kaiser-Meyer-Olkin Wert zeigt ob Daten geeignet sind für FA, MSA > 0.7 --> geeignet

n.factors <- fa.parallel (mtcars, fa = "fa") #Anzahl an zu extrahierenden Faktoren muss angegeben werden
                                              # diese Anzahl wird mit fa.parallel berechnet

fa <- psych::fa (mtcars, nfactors = n.factors$nfact, fm = "ml", rotate = "Promax")

# Was bedeutet fm = "ml" und was bedeutet rotate "Promax"?

# Versuche die Ergebnisse nachzuvollziehen.


# 05: Clusteranalyse -----------------------------------------------------

# Vorbereitung der Daten, wir verwenden den Datensatz USArrests

mydata_orig<-USArrests
mydata<- na.omit(mydata_orig)             # listwise deletion of missing data
mydata<- scale(mydata)                    # standardize variables: scaled and centered: centering done by
mydata<-as.matrix(mydata)

# Berechnung der Distanzmatrix 
d<-dist(mydata, method = "euclidean")     #distance matrix is calculated, with euclidean distance
                                          #other distance measures: "maximum","manhattan","canberra","binary","minkowski"

fit_wardd<-hclust(d, method= "ward.D")    #hierarchisches Clustern, Methode: ward.D
                                          #other methods: "ward.D","ward.D2","single","complete","average"(UPGMA),"mcquitty"(WPGMA)
                                          #"median"(WPGMC) or "centroid" (UPGMC)

# Probiert andere Methoden des Clusteralgorithmus und der Distanzmatrix aus.

# Plotte die unterschiedlichen Dendrogramme, gibt es Unterschiede?

plot(fit_wardd)                           #plots dendrogram, enter name of the algorithm you want to plot

  #...

##########################################################################
## Optional: Sagt Bescheid, wenn ihr hier angekommen seid.

groups<-cutree(fit_wardd, k=4)                  #cuts tree into k clusters
rect.hclust(fit_wardd, k=4)             #draw dendrogram with k clusters with red boarders

coph_dist_wardd<-cophenetic(fit_wardd)          #calculate cophentic distances 
coph_dist_average<-cophenetic(fit_average)
coph_dist_centroid<-cophenetic(fit_centroid)

plot(d, coph_dist_wardd)                        # shepard's diagram: original distance against cophenetic distances, enter name of algortihm

cor_wardd<-cor(d, coph_dist_wardd)            #correaltion coefficient for the cophenetic distance ~ original distance matrix, enter name of algorithm 
cor_average<-cor(d, coph_dist_average)
cor_centroid<-cor(d, coph_dist_centroid)

corr_coeff<-c(cor_average,cor_centroid,cor_wardd)


paste ("The highest correlation coefficient lies at:", round(max(corr_coeff), digits = 2), sep= " ")

# 03b hierarchical agglomerative clustering, 2D plot with grouping

groups<-as.matrix(groups)                       #change format of groups (results of cutree) to matrix
colnames(groups)<-"cluster"                     # add column name
clusterdata<-cbind(mydata_orig, groups)         # add column "cluster" to mydata_orig
clusterdata$groups<-as.factor(clusterdata$cluster) #change "numeric" clusters to factors, important for plotting

plot1<-clusterdata %>%                          # plots a scatterplot with the different clusters marked in different colors
  group_by(cluster) %>% 
  ggplot(aes(x= Murder, y=Assault, color = as.factor(cluster)))+   # x and y need to be specified according to your wishes
  # for feature extraction data: try x= feature_1, y= feature_2
  geom_point()+
  scale_colour_manual(values = c("red", "blue", "green", "black", "yellow"), name = "cluster")   #adjust colors at will
#add more colors for more than 5 cluster

plot1

# 04: Determine number of cluster with NbClust package

#NbClust calculates 30 indices of what the most suitable number of clusters is
numclust<-NbClust(data= mydata,  distance = "euclidean", min.nc = 3, max.nc = 10, method= "ward.D")  #min.nc: minimum number of clusters (can't  be <2) max. nc: maximum number of clusters to check for
# method: for hierarchical one of: "ward.D", "ward.D2", "single", "complete", "average"
# distance: e.g. "euclidean" or "manhattan"
numclust                    # results, among all indices, how many proposed what number as best number of clusters?
