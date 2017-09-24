# Kombajn do uczenia maszynowego - MLR w praktyce

[Paweł Zawistowski, Politechnika Warszawska, Instytut Informatyki EiTI / AdForm](https://pzawistowski.github.io/about)

## Opis warsztatu 

Kiedy coraz powszechniejsze staje się stosowanie mniej lub bardziej skomplikowanych modeli statystycznych, a liczba pakietów R'a z nowymi metodami i algorytmami ciągle wzrasta - dobrze mieć w zanadrzu narzędzie, które spina wszystkie etapy tworzenia modelu w jedną całość. Pakiet MLR jest takim właśnie "kombajnem", który może w znacznym stopniu ułatwić nam pracę. 

W ramach warsztatu zobaczymy jakie możliwości daje MLR przy tworzeniu różnego rodzaju modeli - przejdziemy przy tym kompletną ścieżkę, od wstępnego przygotowania danych, przez wybór odpowiedniej metody, strojenie parametrów, aż po diagnostykę i wizualizacje wyników. 

## Plan warsztatu 

1. Omówienie możliwości pakietu MLR, przygotowanie środowiska.
2. Przygotowanie danych do rozwiązywania naszego zadania (klasyfikacja, regresja, ...).
3. Wybór modelu, strojenie parametrów.
4. Diagnostyka i wizualizacja wyników.
5. Rozszerzanie MLR o własny algorytm.
6. Inne ciekawe elementy pakietu, podsumowanie.

## Wymagane pakiety 

W ramach warsztatu korzystać będziemy głównie z `mlr`, `tidyverse` oraz notatników w R markdown.
Opcjonalnie przydać mogą się narzędzia takie jak `ggplot2`, `GGally` i `parallelMap`.

Udostępniony jest [obraz dockera](https://hub.docker.com/r/pzawistowski/mlr-workshop/) ze wszystkim co potrzebne + RStudio.

## Wymagane od uczestników umiejętności i wiedza 

- Ogólna znajomość zagadnień związanych z tworzeniem modeli statystycznych, umiejętność korzystania z R'a w stylu "tidyverse". 
- Podstawowa umiejętność korzystania z dockera.

## Wymagania wstępne do wykonania przed warsztatem 

Instalacja pakietów R lub ściągnięcie dockera i uruchomienie udostępnionego obrazu.

## Język warsztatu 

Polski.

## Sylwetka prowadzącego

Z wykształcenia jestem informatykiem specjalizującym się w metodach sztucznej inteligencji.  Moje doświadczenia zawodowe leżą zarówno na polu naukowo-badawczym jak również w projektach komercyjnych - obecnie pracuję jako adiunkt w Instytucie Informatyki (wydział EiTI, PW) oraz w firmie Adform. 

"Na poważnie" analizowaniem i modelowaniem danych zajmuję się od 2008r, a językiem R od 2010r. Od tego czasu uczestniczyłem w różnorakich projektach, począwszy od pojedynczych analiz niewielkich zbiorów danych, przez opracowywanie metod regresji i klasyfikacji w ramach projektów badawczych, aż po tworzenie wielkoskalowych systemów produkcyjnych stosujących modele predykcyjne setki tysięcy razy na sekundę.