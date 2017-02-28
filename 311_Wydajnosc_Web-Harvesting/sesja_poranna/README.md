# Kiedy brakuje wydajności... R i C++ = Rcpp

[Zygmunt  Zawadzki, zstat](zstat.pl)

## Opis warsztatu 

Celem warsztatu jest nauczenie użytkowników wykorzystania pakietu Rcpp pozwalającego wykorzystać kod C++ w R w celu przyspieszenia krytycznych fragmentów obliczeń. 

Uczestnik po skończonym warsztacie będzie potrafił:
- przedstawić różnice w modelu zarządzania pamięcią w R i C++ i omówić konsekwencje które się z tym wiążą.
- stworzyć prosty pakiet R wykorzystujący kod C++.
- wykorzystać pakiet profvis do wyszukania najbardziej gorącego fragmentu kodu, który potencjalnie mógłby zostać przepisany z wykorzystaniem Rcpp.


## Plan warsztatu 

Wprowadzenie do Rcpp:
Część I:
- kompilacja pierwszej funkcji wykorzystującej C++ w R.
- omówienie różnic pomiędzy językiem interpretowanym i kompilowanym na przykładzie R i Rcpp.
- Szczegółowe omówienie struktur R dostępnych w C++ (NumericVector i NumericMatrix)
- Przedstawienie STL - standardowej biblioteki szablonów jako dodatkowych struktur danych gotowych do wykorzystania.
- Praktyczne prezentacja modeli zarządzania pamięcią w C++ - stworzenie kilku mini-funkcji prezentujących możliwe konsekwencje błędnej interakcji R i C++.

Cześć II:
- profilowanie kodu z wykorzystaniem Rprof.
- wprowadzenie biblioteki RcppArmadillo do obliczeń macierzowych w C++.
- Stworzenie prostego samplera Gibbsa wykorzystującego RcppArmadillo i funkcje R dostępne po stronie C++. 

## Wymagane pakiety 



Rcpp, RcppArmadillo, profvis

## Wymagane od uczestników umiejętności i wiedza 

Podstawy programowania w R:
- operacje na macierzach.
- pętle for.

Znajomość C++ nie jest wymagana. Wszystkie potrzebne informacje dotyczące tego języka zostaną omówione w trakcie warsztatów.

## Wymagania wstępne do wykonania przed warsztatem 

W przypadku systemu Windows pobranie i instalacja:
- Rtools - najnowsza wersja (https://cran.r-project.org/bin/windows/Rtools/)

Linux:
- wszystko powinno być zainstalowane (potrzebny jest kompilator gcc z obsługą standardu C++11 - jednak wszystkie w miarę nowe wersje powinny go mieć).

Mac:
- zainstalowane XCode.

## Język warsztatu 

polski