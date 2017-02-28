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
