# XGBoost rządzi

[Vladimir Alekseichenko, architekt w General Electric](http://dataworkshop.eu)

## Opis warsztatu

>W teorii nie ma różnicy pomiędzy teorią i praktyką. W praktyce - jest. &copy; *Einstein*

[XGBoost](https://arxiv.org/pdf/1603.02754.pdf) to jest jedna najlepszych implementacji "[Gradient Boosting](https://en.wikipedia.org/wiki/Gradient_boosting)" z punktu widzenia praktycznego.

## Dlaczego warto?
1. Wynik (czyli zwykle jeden z najlepszych)
2. Czas na naukę i predykcję (potrafi używać wszystkie dostępne rdzenie)
3. Odporność na przeuczenia się (poprzez różne parametry regularyzacji)
4. Stabilność (można spokojnie używać na produkcje)

![Czas](img/x-plot-time.png "Czas")
![Dokładność](img/x-plot-auc.png "Dokładność")

Źródło - [benchmark-ml](https://github.com/szilard/benchm-ml)


## Plan warsztatu
1. Zrozumienie biznes problemu
2. Zrozumienie danych
3. Budowa bardzo prostego modelu (base-line)
4. Przypomnienie co to jest drzewa decezyjne
5. Uruchomienie prostego modelu xgboost
6. Generowanie cech ([feature engineering](https://en.wikipedia.org/wiki/Feature_engineering))
7. Budowanie bardziej zaawansowanego modelu
8. Optymalizacja hyperparametrów
9. Inne (zaawansowane) triki (opcjonalnie)


## Wymagane od uczestników umiejętności i wiedza
Warsztat może być ciekawy dla osób które dopiero zaczynają, jak i dla średnio-zaawansowanych (z mojej wiedzy mało osób kojarzy i tym bardziej używa XGBoost w praktyce, chociaż to zmienia się bardzo szybko w czasie).

Natomiast warto rozumieć podstawy:
- uczenie maszynowe (machine learning)
- cechy (features)
- model, np. liniowy
- przeuczenie się ([overfitting](https://en.wikipedia.org/wiki/Overfitting))
- walidacja ([model evaluation](https://sebastianraschka.com/blog/2016/model-evaluation-selection-part1.html))

Fajnie będzie jeżeli sprawdzisz (przypomnisz) jak działają drzewa decezyjne (decision trees).

## Wymagane pakiety
* [xgboost](http://xgboost.readthedocs.io/en/latest/build.html)
* [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
* [e1071](https://cran.r-project.org/web/packages/e1071/e1071.pdf)
* [caret](http://topepo.github.io/caret/index.html)
* [rBayesianOptimization](https://github.com/yanyachen/rBayesianOptimization)

## Problem do rozwiązywania
Przewidywania [kosztu szkody](https://www.kaggle.com/c/allstate-claims-severity) na podstawie danych historycznych.
![Allstate](img/allstate_banner-660x120.png "Allstate")

## Wymagania wstępne do wykonania przed warsztatem
1. Mieć laptop z potrzebnymi pakietami (przede wszystkim xgboost)
2. Pobrać [dane](https://www.kaggle.com/c/allstate-claims-severity/data) z Kaggle
3. Pomyśleć nad problemem przed warsztatem (może nawet spróbować go rozwiązać w najlepszy możliwy sposób - użyć dowolny model, który się zna)


## Język warsztatu
Polski  (*ale mogę przejść na angielski, rosyjski, python, java, C#, javascript, php...*)

## Prowadzący
<img src="img/me.jpg" width="150" style="display: inline; margin: 10px;" />

[Vladimir](http://vova.me) lubi podróże (odwiedził około 30 krajów)... również w świecie IT. Zaczął programować ponad 10 lat temu i pracował w różnych dziedzinach informatyki (z różnymi technologiami). Przez ostatnie 4 lata zajmuję się tematami związanymi z danymi, takie jak machine learning czy data science. Był zaangażowany w budowę infrastruktury dla wyszukiwarek (TB danych). Przygotował ETL (oparty na stacku Hadoop/Kafka/Storm), robił prognozy sprzedaży i wiele innych. Jest trenerem w warsztatach [DataWorkshop](http://dataworkshop.eu), gdzie wyjaśnia, jak korzystać z uczenia maszynowego w życiu realnym bez komplikacji teoretycznych i zawiłych wzorów. Ma podcast o sztucznej inteligencji dla biznesu - [BiznesMyśli](http://biznesmysli.pl). Uczestniczy w konkursach Kaggle'a. Kocha dane i wyzwania.

Vladimir w sieciach społecznościowych: [Facebook](https://www.facebook.com/vova.me), [Github](https://github.com/slon1024), [Twitter](http://twitter.com/slon1024), [LinkedIn](https://pl.linkedin.com/in/vladimiralekseichenko).
