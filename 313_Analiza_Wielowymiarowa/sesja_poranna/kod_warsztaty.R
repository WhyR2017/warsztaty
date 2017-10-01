####Warsztaty - Wróżenie z punktów
####Konferencja WhyR Warszawa 27-29.09.2017 r
#Marcin K. Dyderski
#kontakt: Marcin.Dyderski@gmail.com

#install.packages(c('ggplot2','vegan','dplyr','gridExtra','ggrepel', 'fortunes'))


#1. czym jest ordynacja----
#weźmy dowolny zbiór danych

summary(mtcars)
#spróbujmy obejrzeć zależności między danymi:
par(mfrow=c(2,2))
plot(mtcars$mpg,mtcars$cyl)
plot(mtcars$disp,mtcars$hp)/
plot(mtcars$wt,mtcars$gear)
plot(mtcars$disp,mtcars$cyl)

#trochę bardziej wyrafinowany sposób
par(mfrow=c(1,1))
pairs(mtcars)

#trochę ładniej
library(ggplot2)
g<-ggplot(mtcars, aes(x=hp,y=mpg,col=disp, shape=factor(cyl),size=gear))+geom_point()
g+theme_bw()+theme(legend.position = 'bottom')

###a jak przy tym prezentują się metody ordynacyjne? sprawdźmy to!

library(vegan)


#funkcja rda odpowiada zarówno za PCA, jak i RDA
#wykonamy teraz najprostszą ordynację - PCA
pca1<-rda(mtcars)
plot(pca1)
summary(mtcars)
#dane są dziwnie rozrzucone - zastosujmy preprocessing za pomocą funkcji decostand:

pca2<-rda(decostand(mtcars, method='standardize'))
plot(pca2)

#W dalszej części będziemy mówić o cechach i obiektach - w pakiecie `vegan` są one nazywane odpowiednio 'species' i 'sites'. Wynika to z faktu, że pakiet ten został stworzony do analiz roślinności. Argumentem funkcji wykonujących ordynacje jest data.frame, w którym wiersze to obiekty, a cechy - kolumny.

#przyjrzymy się tylko cechom:

biplot(pca2, display='species')

####2. Metody----
##PCA----
#podstawowa funkcja
rda(mtcars)

#standaryzacja - za pomocą decostand:
pca2<-rda(decostand(mtcars, method='standardize'))
pca2

#rodzaje standaryzacji:
?decostand

summary(pca2)

#współrzędne cech i współrzędne puntów
#można je łatwiej wyekstrachować funkcją scores:

scores(pca2)
#poszczególne współrzędne - cech
scores(pca2, choices=c(3,4))$species
#lub obiektów
scores(pca2)$sites

#rysowanie
plot(pca2)

##CA----
#do CA służy funkcja cca()
ca1<-cca(decostand(mtcars, method='standardize'))
#cca nie obsługuje liczb ujemnych

ca1<-cca(decostand(mtcars, method='normalize'))
ca1
plot(ca1)

#przyjrzyjmy się bliżej:
par(mfrow =c(1,2))
plot(ca1, display='sites')
plot(ca1, display='species')

##DCA-----
#funkcja decorana()
dca1<-decorana(decostand(mtcars, method='normalize'))
dca1
plot(dca1)
#osobno obiekty i cechy
par(mfrow =c(1,2))
plot(dca1, display='sites')
plot(dca1, display='species')

##RDA----
#przyjrzyjmy się przykładowi z pakietu vegan

data(dune)
dune
pca.dune<-rda(dune)
pca.dune
plot(pca.dune)

#zmienne środowiskowe - dodatkowe predyktory
data(dune.env)
summary(dune.env)


#projekcja pasywna - nie zmieniająca układu punktów
pasywnie<-envfit(pca.dune, dune.env)
pasywnie
plot(pca.dune)
plot(pasywnie, add=T)


#projekcja aktywna - właściwe RDA 
rda1<-rda(dune~A1+Moisture, data=dune.env)
rda1

####Przypadek 1 - drzewa----
drzewa<-read.csv('trees.csv',sep=';')
summary(drzewa)

#wyrzucamy factory i pseudofactory:
drzewa.an<-drzewa[,-c(1,2,3,11,12)]

#do analiz zostają:
#wdensity – gęstość drewna [t/m3]
#lai – indeks powierzchni liści [m2 liści/ m2 glebyy]
#canopy_height – wysokość [m]
#leaf_dmc – zawartość suchej masy w liściu [mg/g]
#leaf_mass – masa liści [mg]
#leaf_size – powierzchnia [cm2]
#seed_mass – masa nasion [mg]
#shade_tolerance
#drought_tolerance
#waterlogging_tollerance – wskaźniki od 0 do 5
#disturbance_index – od -2 do 0



#wybór metody
#pierwsza rzecz do sprawdzenia - długość gradientu. Wiemy jednak, że mamy różne jednostki i trzeba będzie dane wystandardyzować. Sprawdźmy różne metody i długości gradientów za pomocą DCA:

###decorana, decostand...

decorana(decostand(drzewa.an, method='range'))
decorana(decostand(drzewa.an, method='freq'))


#ok, to teraz sprawdźmy co będzie lepsze - CA czy PCA

rda(decostand(drzewa.an, method='standardize'))
rda(decostand(drzewa.an, method='normalize'))
cca(decostand(drzewa.an, method='range'))
cca(decostand(drzewa.an, method='normalize'))

#które więcej zmienności? jak to ocenić?
#można wyplotować

par(mfrow=c(2,2))
plot(rda(decostand(drzewa.an, method='standardize')))
plot(rda(decostand(drzewa.an, method='normalize')))
plot(cca(decostand(drzewa.an, method='range')))
plot(cca(decostand(drzewa.an, method='normalize')))

##przyjrzyjmy się dwóm najsensowniejszym:

par(mfrow=c(1,2))
plot(rda(decostand(drzewa.an, method='standardize')))
plot(cca(decostand(drzewa.an, method='range')))

#wykresy diagnostyczne dla komponentów - screeplot

par(mfrow=c(1,2))
screeplot(rda(decostand(drzewa.an, method='standardize')), bstick=T)
screeplot(cca(decostand(drzewa.an, method='range')),bstick=T)

#rule of thumb mówi że możemy brać komponenty dopóki wyjaśniają więcej niż broken stick

##wizualizacja
#najpierw podstawowe funkcje pakietu vegan
par(mfrow=c(1,1))
tree.pca<-rda(decostand(drzewa.an, method='standardize'))
plot(tree.pca)

#inny sposób - najpierw czysty plot, potem dodajemy elementy:
plot(tree.pca, type='none')
points(tree.pca, display='sites', pch=1)
text(tree.pca, display='species', col='darkgreen')

#ordihull - czyli grupy
plot(tree.pca, type='none')
ordihull(tree.pca, groups =drzewa$iglasty,col=c('red','green'))

#orditorp - inteligentne etykiety


plot(tree.pca, type='none')
ordihull(tree.pca, groups =drzewa$iglasty,col=c('red','green'))
orditorp(tree.pca,display='sites',label=as.character(drzewa$nazwa),priority=drzewa$wdensity,pch='+',air = .5)
#label - nazwy do wyświetlenia, #priority - wektor określający pierwszeństwo przy konflikcie etykiet, air - jak bardzo mogą na siebie zachodzić etykiety, domyślnie =1

##ggplot
#potrzeba nam data.frame ze współrzędnymi punktów - wyciągniemy je funkcją scores(). Tworzymy dwa data.frame'y - dla obiektów (sites) i cech (scores):
tree.gg.obiekty<-as.data.frame(scores(tree.pca,display = 'sites'))
tree.gg.cechy<-as.data.frame(scores(tree.pca, display='species'))
tree.gg.cechy$name<-rownames(tree.gg.cechy)

#do obiektów dostawmy kolumny z nazwami gatunków i informacjami zapisanymi jako factory:
tree.gg.obiekty<-cbind(tree.gg.obiekty, drzewa[,c(1,2,3,11,12)])


#ggplot tylko dla cech:
library(ggplot2)
ggplot(tree.gg.cechy, aes(x=PC1,y=PC2))+geom_point()+geom_text(aes(label=name),nudge_x = .15,nudge_y = .15)
#argument nudge_ mówi o odsunięciu etykiety od punktu


#dodajmy obiekty:
ggplot(tree.gg.cechy, aes(x=PC1,y=PC2))+geom_text(aes(label=name),nudge_x = .15,nudge_y = .15)+geom_point(data=tree.gg.obiekty,aes(col=iglasty))
#argumentem data dorzucamy punkty z drugiej data.frame

#ok, coś już widać, ale może jak dodamy nazwy drzew będziemy wiedzieć więcej?

ggplot(tree.gg.cechy, aes(x=PC1,y=PC2))+geom_text(aes(label=name), col='black',fontface='bold')+geom_text(data=tree.gg.obiekty,aes(col=iglasty,label=nazwa),position=position_jitter(width=.1,height=.1))

#nawet nawet, ale mamy tu bałagan. dodajmy theme_bw i każmy mu narysować etykiety za pomocą geom_text_repel z pakietu ggrepel:
library(ggrepel)
ggplot(tree.gg.cechy, aes(x=PC1,y=PC2))+geom_text(aes(label=name), col='black',fontface='bold')+geom_text_repel(data=tree.gg.obiekty,aes(col=iglasty,label=nazwa))+theme_bw()

####Przypadek 2 - piwo----
#dane
piwa<-read.csv('beer.csv',sep=';')
summary(piwa)

#do analizz weźmiemy tylko cechy ilościowe:
piwa.an<-piwa[,-c(1,2,3,6)]
rownames(piwa.an)<-piwa$nazwa

#Analizowane przez nas będą:
#BLG, czyli zawartość ekstraktu w brzeczce przed fermentacją, wyrażona w stopniach Ballinga
#V, czyli objętościowa zawartość etanolu [%]
#overall - percentyl w którym znajduje się dane piwo w zbiorze wszystkich piw wg ocen użytkowników ratebeer.com 
#style- percentyl w którym znajduje się dane piwo w zbiorze wszystkich piw danego stylu wg ocen użytkowników 
#weighted - "czysta" ocena piwa w skali 0-5 wg ratebeer.com

#znów zakres danych zmusza nas do preprocessingu

#wybór metody:

decorana(decostand(piwa.an, method='range'))
decorana(decostand(piwa.an, method='normalize'))

#krótki gradient

#PCA czy CA?
rda(decostand(piwa.an, method='freq'))
rda(decostand(piwa.an, method='range'))
cca(decostand(piwa.an, method='range'))
cca(decostand(piwa.an, method='freq'))
#narysujmy
par(mfrow=c(2,2))
plot(rda(decostand(piwa.an, method='standardize')))
plot(rda(decostand(piwa.an, method='normalize')))
plot(cca(decostand(piwa.an, method='range')))
plot(cca(decostand(piwa.an, method='normalize')))
#screeploty
par(mfrow=c(2,2))
screeplot(rda(decostand(piwa.an, method='freq')),bstick=T)
screeplot(rda(decostand(piwa.an, method='range')),bstick=T)
screeplot(cca(decostand(piwa.an, method='range')),bstick=T)
screeplot(cca(decostand(piwa.an, method='freq')),bstick=T)

#Analiza screeplotów wskazuje nam, że sensowne wyniki dadzą nam analizy po preprocessingu `freq` Przyjrzyjmy się tym wykresom znów bliżej:

par(mfrow=c(1,2))
plot(rda(decostand(piwa.an, method='freq')))
plot(cca(decostand(piwa.an, method='freq')))

#Żeby sprawdzić czym się różnią od siebie analizy możemy wykonać wykres różnic w lokacji punktów za pomocą funkcji `procrusters()`:

par(mfrow=c(1,1))
plot(procrustes(rda(decostand(piwa.an, method='freq')),cca(decostand(piwa.an, method='freq'))))


#wizualizacja
piwo.ca<-cca(decostand(piwa.an, method='freq'))
plot(piwo.ca, disp='species')

#ggplot
#data.frame'y:
ggpiwo.obiekty<-as.data.frame(scores(piwo.ca,display='sites'))
ggpiwo.obiekty<-cbind(ggpiwo.obiekty, piwa)
ggpiwo.cechy<-as.data.frame(scores(piwo.ca,display='species'))
ggpiwo.cechy$name<-rownames(ggpiwo.cechy)

#wykres
ggplot(ggpiwo.obiekty, aes(x=CA1,y=CA2))+geom_point(aes(col=gat_jedn))+geom_text(data=ggpiwo.cechy, aes(label=name))

#przeskalujmy cechy

ggpiwo.cechy$CA1<-ggpiwo.cechy$CA1*4
ggpiwo.cechy$CA2<-ggpiwo.cechy$CA2*4
# i wykres, dla estetyki scale_color_brewer i theme_bw
ggplot(ggpiwo.obiekty, aes(x=CA1,y=CA2))+geom_point(aes(col=gat_jedn))+geom_text(data=ggpiwo.cechy, aes(label=name))+scale_color_brewer(palette='Set3')+theme_bw()

#poszukajmy centroidów styli:
library(dplyr)

ggpiwo.obiekty.centro<-ggpiwo.obiekty%>%group_by(gat_jedn)%>%summarise(CA1=mean(CA1),CA2=mean(CA2))
#tworzymy nowy data.frame który dodamy do wykresu
ggplot(ggpiwo.obiekty, aes(x=CA1,y=CA2))+geom_point(aes(col=gat_jedn))+geom_point(data=ggpiwo.obiekty.centro,aes(x=CA1,y=CA2,col=gat_jedn),size=4,shape=15)+geom_text(data=ggpiwo.cechy, aes(label=name))+scale_color_brewer(palette='Set3')+theme_bw()


####Przypadek 3 - miasta ----
#dane
miasta<-read.csv('miasta.csv',sep=';')
summary(miasta)

#mamy różne dane w jednym - strukturę form użytkowania terenu i zmienne objaśniające
#rozdzielmy to:

miasta.clc<-miasta[,c(11:29)]
miasta.expl<-miasta[,c(3:10,30)]
rownames(miasta.clc)<-miasta$nazwa
rownames(miasta.expl)<-miasta$nazwa

#miasta.clc - 19 kategorii
#agric_seminat – tereny rolnicze, łąki, mokradła
#wbudowie – place budów
#urban80_100 – zwarta zabudowa miejska [80-100% powierzchni zabudowanej]
#wydobycie_skladowanie – wysypiska, wyrobiska, kopalnie, składowiska
#struktury_izolowane - inne obiekty
#sport_wypoczynek – tereny rekreacyjne

#zmienne objaśniające:
#pop – ludność
#perc_men – udział mężczyzn w populacji
#urodzenia_rocznie
#Old.age.dependency.ratio – stosunek liczby osób >65 lat do osób w wieku produkcyjnym
#N, E – współrzędne geograficzne
#elev – wysokość n.p.m.
#estab – rok założenia miasta
#pow_calk – powierzchnia całkowita [m2]


#czy trzeba DCA - sprawdzamy długość gradientu:

decorana(decostand(miasta.clc, method='range'))

# na początek tylko miasta.clc:
#co lepsze - CA czyy PCA?
rda(decostand(miasta.clc, method = "range"))
cca(decostand(miasta.clc, method = "range"))
par(mfrow=c(1,2))
plot(rda(decostand(miasta.clc, method = "range")))
plot(cca(decostand(miasta.clc, method = "range")))
#wykresy diagnostyczne:
par(mfrow=c(1,3))
screeplot(rda(decostand(miasta.clc, method ="range")),bstick=T)
screeplot(cca(decostand(miasta.clc, method ="range")),bstick=T)
plot(procrustes(rda(decostand(miasta.clc, method ="range")),cca(decostand(miasta.clc, method ="range"))))

#na podstawie zmienności wybraliśmy PCA. Obejrzymy:
par(mfrow=c(1,2))
plot(rda(decostand(miasta.clc, method = "range")),display='species')
plot(rda(decostand(miasta.clc, method ="range")),display='sites')

#projekcja pasywna - envfit()
pca.miasta<-rda(decostand(miasta.clc, method =
                            "range"))
miasta.fit<-envfit(pca.miasta, miasta.expl)
miasta.fit
#i wykres
plot(pca.miasta)
#plot.envfit() nie wywołuje nowego okna lecz dodaje
plot(miasta.fit)

#czy warto zrobić analizę ograniczoną - RDA?
#sprawdźmy!
#Pierwszy problem - określenie która analiza jest lepsza - możemy rozwiązać poprzez porównanie AIC modelu zerowego (de facto PCA) do poszczególnych RDA. Aby określić AIC obiektu typu `rda` lub `cca` nie możemy wykorzystać bazowej funkcji `AIC()`, użyjemy po prostu funkcji `step()`.

rda0<-rda(decostand(miasta.clc,method='range')~1)
rda0
#czyli jest to po prostu nasze PCA
step(rda0)

#Jak dobrać predyktory do modelu RDA/CCA?
#wersja brute force - forward selection używając step() - niezalecana, wymagająca ostrożności i krytycyzmu

#transformujmy zestaw predyktorów:
miasta.expl<-decostand(miasta.expl, method = "range")
#składnia RDA - data.frame~czynniki, data=data.frame z czynnikami
#tutaj wrzucamy data.drame z cechami i obiektami po transformacji
#kropka w formule (po tyldzie [~]) oznacza wszystkie kolumny z tabeli
rda.all<-rda(decostand(miasta.clc, method = "range") ~., data = miasta.expl)
rda.all
#zobaczmy jak wygląda
plot(rda.all)
rda.stepmodel<-step(rda.all)
rda.stepmodel
plot(rda.stepmodel)

#czym to się różni od pasywnie dodanych wektorów za pomocą envfit()?


par(mfrow=c(1,3))
plot(rda.stepmodel, main='RDA używając step()')
plot(pca.miasta, main='PCA + pasywne envfit()')
plot(miasta.fit)
plot(procrustes(pca.miasta, rda.stepmodel),main='Różnice')

#czy są różnice? jakie mogą być konsekwencje? czy skorelowane ze sobą predyktory nie powodują inflacji wariancji? 
#sprawdźmy to za pomocą VIF - funkcja vif.cca()

vif.cca(rda.all)
vif.cca(rda.stepmodel)
#rule of thumb: VIF>10 -> problem


#Patrząc na PCA z pasywnymi wektorami przyjmijmy hipotezę o wpływie niektórych czynników na strukturę form użytkowania terenu. Takimi czynnikami może być rok założenia miasta `estab`, wysokość n.p.m. `elev` czy liczba mieszkańców `pop`, N i E.

rda1<-rda(decostand(miasta.clc, method = "range") ~ pop + N + E + elev + estab, data = miasta.expl)
step(rda1)

#Widzimy, że AIC= 3.32. Funkcja step podpowiada nam, że usunięcie zmiennej `pop` zmniejszy AIC do 2.31. Zróbmy więc taki model:

rda2<-rda(decostand(miasta.clc, method = "range") ~ + N + E + elev + estab, data = miasta.expl)
step(rda2)
plot(rda2)
#co jesli usuniemy współrzędne?
rda3<-rda(decostand(miasta.clc, method = "range") ~ elev + estab, data = miasta.expl)
step(rda3)

#zostajemy przy PCA z projekcja pasywną


##wizualizacja
ggmiasto.obiekty<-as.data.frame(scores(pca.miasta,display='sites'))
ggmiasto.obiekty<-cbind(ggmiasto.obiekty, miasta.expl)
ggmiasto.obiekty$nazwa<-miasta$nazwa
ggmiasto.cechy<-as.data.frame(scores(pca.miasta,display='species'))
ggmiasto.cechy$name<-rownames(ggmiasto.cechy)
#teraz ggplot
ggplot(ggmiasto.obiekty, aes(x=PC1, y=PC2))+geom_text(aes(label=nazwa))+geom_text(data=ggmiasto.cechy, aes(label=name),col='red',fontface='bold')

#brakuje nam projekcji pasywnej - jak dodać strzałki?
#wynik funkcji envfit to nie data.frame tylko obiekt osobnej klasy envfit. Trzeba więc trochę pokombinować żeby wydobyć strzałki:

ggmiastafit<-data.frame(nazwa=rownames(miasta.fit$vectors$arrows),PC1=miasta.fit$vectors$arrows[,1],PC2=miasta.fit$vectors$arrows[,2])
#na tym można by skończyć, ale niektórzy fetyszyzują p-values i r2:
ggmiastafit$r2<-miasta.fit$vectors$r
ggmiastafit$pval<-miasta.fit$vectors$pval

#i wykresik:
ggplot(ggmiasto.obiekty, aes(x=PC1, y=PC2))+geom_text(aes(label=nazwa))+geom_text(data=ggmiasto.cechy, aes(label=name),col='red',fontface='bold')+geom_segment(data=ggmiastafit, aes(x=0,xend=PC1,y=0,yend=PC2),arrow = arrow(length = unit(0.2,"cm")))+geom_text(data=ggmiastafit,aes(label=nazwa),col='blue')

#niby ok, ale brzydki. trzeba skorzystać z geom_text_repel oraz theme_bw

ggplot(ggmiasto.obiekty, aes(x=PC1, y=PC2))+geom_text_repel(aes(label=nazwa))+geom_text_repel(data=ggmiasto.cechy, aes(label=name),col='red',fontface='bold')+geom_segment(data=ggmiastafit, aes(x=0,xend=PC1,y=0,yend=PC2),arrow = arrow(length = unit(0.2,"cm")))+geom_text_repel(data=ggmiastafit,aes(label=nazwa),col='blue')+theme_bw()

####na zakończenie;)
fortunes::fortune(105)

