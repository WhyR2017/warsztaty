#|-> sprawdzanie, czy potrzebne pakiety są zainstalowane (w najnowszych wersjach)
pakietyWersje = matrix(c(
  "survey",  "3.32-1",
  "ggplot2", "2.2.1",
  "effects", "4.0-0"),
  nrow = 2)
for (i in 1:ncol(pakietyWersje)) {
  wersja = tryCatch(packageVersion(pakietyWersje[1, i]),
                    error = function(x){return(0)})
  if (wersja < pakietyWersje[2, i]) {
    install.packages(pakietyWersje[1, i], repos = "https://cloud.r-project.org")
  }
}
#|<-
#|-> zobaczmy, czy można bez problemu przeprowadzić jakieś analizy
library(survey)
data(api)
dclus = svydesign(id = ~dnum + snum, weights = ~pw, data = apiclus2)
svymean(~api00, dclus, deff = TRUE)
#          mean      SE   DEff
# api00 670.812  30.712 6.5075

m = svyglm(api00 ~ ell + meals + mobility, design = dclus)
summary(m)
# Call:
# svyglm(formula = api00 ~ ell + meals + mobility, design = dclus)
# 
# Survey design:
# svydesign(id = ~dnum + snum, weights = ~pw, data = apiclus2)
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 811.4907    30.8795  26.279   <2e-16 ***
# ell          -2.0592     1.4075  -1.463    0.152    
# meals        -1.7772     1.1053  -1.608    0.117    
# mobility      0.3253     0.5305   0.613    0.544    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 8363.101)
# 
# Number of Fisher Scoring iterations: 2
library(effects)
# (eff = Effect("meals", m))
#  meals effect
# meals
#        0       20       50       80      100 
# 764.1958 728.6522 675.3367 622.0213 586.4777 
plot(eff)

library(ggplot2)
ggplot(apiclus2, aes(x = meals, y = api00, size = pw)) + geom_point()
ggplot(apiclus2, aes(x = meals, y = api00, z = pw)) + stat_summary_2d()
#|<-
