responses <- read.csv('responses.csv', stringsAsFactors = FALSE)

opisuj <- function(wiersz, responses, plik){
  zgloszenie <- responses[wiersz, ]
  cat(paste0("# ", zgloszenie$Tytuł.warsztatu), file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat(paste0("[", zgloszenie$Imię, " ", zgloszenie$Nazwisko, ", ", 
             zgloszenie$Afiliacja.instytucja, "](", zgloszenie$Strona.internetowa, ")"), file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat("## Opis warsztatu \n\n", file = plik, append = TRUE)
  cat(zgloszenie$Opis.warsztatu, file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat("## Plan warsztatu \n\n", file = plik, append = TRUE)
  cat(zgloszenie$Plan.warsztatu, file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat("## Wymagane pakiety \n\n", file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat(zgloszenie$Wymagane.pakiety, file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat("## Wymagane od uczestników umiejętności i wiedza \n\n", file = plik, append = TRUE)
  cat(zgloszenie$Wymagane.od.uczestników.umiejętności.i.wiedza, file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat("## Wymagania wstępne do wykonania przed warsztatem \n\n", file = plik, append = TRUE)
  cat(zgloszenie$Wymagania.wstępne.do.wykonania.przed.warsztatem, file = plik, append = TRUE)
  cat("\n\n", file = plik, append = TRUE)
  cat("## Język warsztatu \n\n", file = plik, append = TRUE)
  cat(zgloszenie$Język.warsztatu, file = plik, append = TRUE)
}


dir.create('310_Sondaze/sesja_popoludniowa/')
file.create('310_Sondaze/sesja_popoludniowa/README.md')
opisuj(21, responses, 'Sondaze/sesja_popoludniowa/README.md')
dir.create('311_Wydajnosc_Web-Harvesting/sesja_popoludniowa/', recursive = T)
dir.create('311_Wydajnosc_Web-Harvesting/sesja_poranna/', , recursive = T)
file.create('311_Wydajnosc_Web-Harvesting/sesja_popoludniowa/README.md')
file.create('311_Wydajnosc_Web-Harvesting/sesja_poranna/README.md')
opisuj(6, responses, '311_Wydajnosc_Web-Harvesting/sesja_poranna/README.md')
opisuj(10, responses, '311_Wydajnosc_Web-Harvesting/sesja_popoludniowa/README.md')


dir.create('312_Enterprise/sesja_popoludniowa/', recursive = T)
dir.create('312_Enterprise/sesja_poranna/', recursive = T)
file.create('312_Enterprise/sesja_popoludniowa/README.md')
file.create('312_Enterprise/sesja_poranna/README.md')
opisuj(2, responses, '312_Enterprise/sesja_poranna/README.md')
opisuj(4, responses, '312_Enterprise/sesja_popoludniowa/README.md')


dir.create('313_Uczenie_Maszynowa_Narzedzia/sesja_popoludniowa/', recursive = T)
dir.create('313_Uczenie_Maszynowa_Narzedzia/sesja_poranna/', recursive = T)
file.create('313_Uczenie_Maszynowa_Narzedzia/sesja_popoludniowa/README.md')
file.create('313_Uczenie_Maszynowa_Narzedzia/sesja_poranna/README.md')
opisuj(13, responses, '313_Uczenie_Maszynowa_Narzedzia/sesja_poranna/README.md')
opisuj(9, responses, '313_Uczenie_Maszynowa_Narzedzia/sesja_popoludniowa/README.md')


dir.create('314_Uczenie_Maszynowa_Metody/sesja_popoludniowa/', recursive = T)
dir.create('314_Uczenie_Maszynowa_Metody/sesja_poranna/', recursive = T)
file.create('314_Uczenie_Maszynowa_Metody/sesja_popoludniowa/README.md')
file.create('314_Uczenie_Maszynowa_Metody/sesja_poranna/README.md')
opisuj(15, responses, '314_Uczenie_Maszynowa_Metody/sesja_poranna/README.md')
opisuj(11, responses, '314_Uczenie_Maszynowa_Metody/sesja_popoludniowa/README.md')
