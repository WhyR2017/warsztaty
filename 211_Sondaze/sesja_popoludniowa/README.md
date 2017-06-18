# Złożone schematy doboru próby - pakiet survey

[Tomasz Żółtak, Instytut Badań Edukacyjnych](https://github.com/tzoltak)

## Opis warsztatu

Duża część dostępnych powszechnie danych z badań sondażowych pochodzi z projektów, w których wykorzystywane są złożone schematy doboru prób badawczych. W szczególności dotyczy to międzynarodowych badań porównawczych w dziedzinie edukacji (np. TIMSS, PIRLS, PISA, PIAAC) czy nauk społecznych (np. ESS), ale też badań dotyczących zdrowotności i epidemiologii. Analiza tych danych przy pomocy klasycznie wykorzystywanych technik, zakładających, że próba została dobrana w sposób prosty, może prowadzić do błędnych wniosków, w szczególności w zakresie wielkości błędów standardowych (a w konsekwencji istotności statystycznych). Zasadniczym celem warsztatu jest zapoznanie uczestników z możliwościami pakietu „survey”, który umożliwia analizę tego rodzaju danych w R z wykorzystaniem technik adekwatnych do prób dobranych w sposób złożony: z wykorzystaniem stratyfikacji, doboru wielostopniowego, czy zespołowego.

## Plan warsztatu

  1. Złożone schematy doboru prób badawczych – jak i po co się to robi?
     - Typowe złożone schematy doboru próby: stratyfikacja, dobór zespołowy i wielostopniowy.
     - Przykłady projektów badawczych, w których wykorzystywane są złożone schematy doboru próby.
     - Estymacja wariancji estymatorów z wykorzystaniem linearyzacji Taylora i z wykorzystaniem technik replikacyjnych: podstawowe pojęcia i założenia oraz ich najważniejsze implikacje praktyczne.
  2. Pakiet „survey” - jego możliwości i ograniczenia.
     - Co możemy zrobić z pakietem „survey”.
     - Inne możliwości ale w specyficznych zastosowaniach: pakiety „intsvy” i „lavaan.survey”.
  3. Definiowanie typowych złożonych schematów doboru próby w pakiecie „survey”.
  4. Estymacja typowych statystyk opisowych.
     - Średnie, wariancje, kwantyle (i sumy populacyjne!).
  5. Przerwa.
  6. Wizualizacja danych przy pomocy pakietów „survey” i „ggplot2”.
     - Funkcje graficzne pakietu „survey”.
     - Wykorzystywanie wag w pakiecie „ggplot2”.
  7. Regresja liniowa i uogólniona regresja liniowa.
     - Jak korzystać z funkcji ‘svyglm()’?
     - A co z liczeniem korelacji?
     - W jakich sytuacjach warto uwzględniać złożony schemat doboru próby przy prowadzeniu analizy regresji?
  8. Poststratyfikacja i techniki pokrewne (jeśli ktoś jest zainteresowany, może rzucić okiem na [tą prezentację](https://github.com/tzoltak/warsztaty/tree/master/310_Sondaze/sesja_popoludniowa/poststratyfikacja_ESS.pdf)).
     - Co to znaczy, że próba jest reprezentatywna? (Bardzo możliwe, że nie to, czego się spodziewasz!)
     - Definiowanie wag poststratyfikacyjnych w pakiecie „survey”.
     - Kiedy warto używać poststratyfikacji, a kiedy lepiej tego nie robić?

W czasie warsztatu wykorzystywane będą dane z Europejskiego Sondażu Społecznego i badań PISA.

## Wymagane pakiety

survey, ggplot2

## Wymagane od uczestników umiejętności i wiedza

Podstawowe umiejętności w zakresie przetwarzania i analizy danych w R (operacje na ramkach danych, obliczanie statystyk opisowych, estymacja modeli regresji). Podstawowa wiedza na temat wnioskowania statystycznego (estymacja średniej populacyjnej na podstawie prostej próby losowej).

## Wymagania wstępne do wykonania przed warsztatem

Instalacja pakietów survey i ggplot2.

## Język 

Polski.

## Sylwetka prowadzącego

Z wykształcenia jestem socjologiem (Instytut Socjologii UW), w praktyce przede wszystkim statystykiem, psychometrykiem i osobą zajmującą się przekształcaniem danych. Pracuję w Instytucie Badań Edukacyjnych, a wcześniej również w Instytucie Filozofii i Socjologii PAN. Jestem aktywny naukowo na polu badań edukacyjnych i socjologii polityki (oraz incydentalnie różnych innych).Jako autor analiz i raportów współpracowałem z instytucjami takimi jak CKE, NCK, WUM, MSiT, Kancelaria Prezydenta RP, Rada Koordynacyjna ds. Certyfikacji Biegłości Językowej UW. W latach 2010-2015 byłem członkiem zespołu rozwijającego wskaźniki [Edukacyjnej Wartości Dodanej](http://ewd.edu.pl), odpowiadając m. in. za przygotowanie [procesu ich obliczania - z wykorzystaniem R](http://ewd.edu.pl/wp-content/uploads/2014/12/poster-id-201513-00544.pdf).

W środowisku R pracuję od 2007 r. Jestem autorem lub współautorem:

  - 7 pakietów związanych z procesem obliczania wskaźników EWD (dostępne na GitHubie);
  - pakietu do analizy własności psychometrycznych testu przy pomocy narzędzi z Klasycznej Teorii Testu (napisany i udokumentowany po polsku, daje ładne raporciki, korzystając z dobrodziejstw Rmarkodwn i knitra);
  - jednej z gier edukacyjnych zawartych w pakiecie [BetaBit](https://cran.r-project.org/web/packages/BetaBit/) (tej poświęconej regresji).

Jeśli chodzi o doświadczenie dydaktyczne, prowadziłem zajęcia ze statystyki na UW (socjologia w IS, kognitywistyka) oraz sporo warsztatów nt. wspomnienych powyżej wskaźników EWD.
