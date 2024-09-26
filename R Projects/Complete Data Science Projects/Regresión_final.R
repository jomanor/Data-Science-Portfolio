library(ggplot2)
library(skimr)
library(corrplot)
library(GGally)
library(tidyverse)
library(caret)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

#Trabajo EDA (california)

setwd("C:/Users/Usuario/Desktop/Universidad/Máster en Ciencia de Datos/Introducción a la ciencia de datos/Datasets Regresion/california")

#-------------------------------------------------------------------------------

#Importamos el dataset
calif <- read.csv("california.dat", comment.char="@", header = FALSE)

#Asignamos manualmente los nombres a las distintas variables
names(calif) <- c("Longitude", "Latitude", "HousingMedianAge",
                  "TotalRooms", "TotalBedrooms", "Population", "Households",
                  "MedianIncome", "MedianHouseValue") 
#Vemos las primeras filas del dataset para ver si se ha importado correctamente
head(calif)

#Observamos los atributos y el número de instancias y de características del dataset
str(calif)
dim(calif)

#Comprobamos los tipos de datos atómicos
clase_variables <- sapply(calif, class)
clase_variables

#Generamos un resumen estadístico de las distintas variables
#Aprovechando esto, utilizamos la función skim del paquete skimr
#para ver si hay missing values y obtener más información
summary(calif)
skim(calif)

#-------------------------------------------------------------------------------

#Outliers

calif %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(y = valor)) +
  geom_boxplot(fill = "deepskyblue", color = "black", alpha = 0.5) +  # Utilizar paleta de colores Brewer
  labs(
    x = "",
    y = ""
  ) +
  facet_wrap(~ variable, scales = "free")

#-------------------------------------------------------------------------------

#Plots univariables

calif %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(x = valor)) +
  geom_histogram(bins = 30, fill = "deepskyblue", color = "black") +
  labs(
    x = "",
    y = ""
    ) +
  facet_wrap(~ variable, scales = "free")

#-------------------------------------------------------------------------------

#Plots bivariables

ggpairs(calif,
        lower = list(continuous = wrap("points", size = 0.07, alpha = 0.2, color = "deepskyblue")),
        diag = list(continuous = wrap("densityDiag", fill = "purple", alpha = 0.5)),
        upper = list(continuous = "blank")) +
    theme(axis.text.x = element_blank(),   
          axis.text.y = element_blank(),   
          panel.grid = element_blank()) +
  ggtitle("")

#-------------------------------------------------------------------------------

#Plots para verificar hipótesis

calif %>% ggplot(aes(x = MedianIncome, y = MedianHouseValue)) +
  geom_point(alpha = 0.2, color = "deepskyblue") +
  labs(
    x = "Mediana de Ingresos (10k$)",
    y = "Valor mediano de la vivienda ($)"
  ) 

calif %>% 
  ggplot(aes(x = Longitude, y = Latitude, color = MedianHouseValue)) +
  geom_point(alpha = 0.6, size = 2.5) +
  scale_color_gradient(low = "deepskyblue", high = "purple") +
  labs(
    x = "Longitud (º)",
    y = "Latitud (º)",
    color = "Valor mediano de la vivienda ($)"
  ) 

calif %>% ggplot(aes(x = TotalRooms, y = TotalBedrooms)) +
  geom_point(alpha = 0.5, color = "deepskyblue") +
  labs(
    x = "Nº de habitaciones",
    y = "Nº de dormitorios"
  ) 

calif %>% ggplot(aes(x = Households, y = Population)) +
  geom_point(alpha = 0.5, color = "deepskyblue") +
  labs(
    x = "Nº de hogares",
    y = "Nº de habitantes"
  ) 

calif %>% ggplot(aes(x = MedianIncome)) +
  geom_density(fill = "deepskyblue", alpha = 0.5) +
  labs(
    x = "Ingreso mediano (10k$)",
    y = "Frecuencia"
  ) 

#-------------------------------------------------------------------------------

#Correlación

y <- calif %>% 
  cor() 

corrplot(y,, type ="lower", method = "ellipse")

#Reducción de la dimensionalidad

calif_reduced <- calif %>%
  mutate(DistanciaCentro = (Latitude - mean(Latitude))^2 + (Longitude - mean(Longitude))^2,
         RoomsPorPopulation = TotalRooms / Population,
         BedroomsPorPopulation = TotalBedrooms / Population,
         HouseholdPorPopulation = Households / Population) %>%
  dplyr::select(-Latitude, -Longitude, -TotalRooms, -TotalBedrooms, -Households, -Population)

#-------------------------------------------------------------------------------

#Normalidad  

calif_reduced %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(sample = valor)) +
  stat_qq() +
  stat_qq_line()+
  labs(
    x = "",
    y = ""
  ) +
  facet_wrap(~ variable, scales = "free")

shapiro_test_sample <- function(x) {
  x <- sample(x, 5000)
  shapiro.test(x)$p.value
}

shapiro_results <- calif_reduced %>% 
  summarise_all(shapiro_test_sample)

print(shapiro_results)

#-------------------------------------------------------------------------------

#Transformaciones 

param <- preProcess(calif_reduced, method = c("center", "scale", "YeoJohnson"))
param

calif_yeo_transformed <- predict(param, newdata = calif_reduced)

calif_yeo_transformed %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(x = valor)) +
  geom_histogram(bins = 30, fill = "deepskyblue", color = "black") +
  labs(
    title = "Histogramas de las nuevas variables",
    subtitle = "Transformación: Yeo-Johnson"
  ) +
  facet_wrap(~ variable, scales = "free")

calif_log <- calif_reduced %>%
  mutate_all(log) %>%
  mutate_all(scale)

calif_log %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(x = valor)) +
  geom_histogram(bins = 30, fill = "deepskyblue", color = "black") +
  labs(
    title = "Histogramas de las nuevas variables",
    subtitle = "Transformación: Logarítmica"
  ) +
  facet_wrap(~ variable, scales = "free")
#-------------------------------------------------------------------------------

#Normalidad de las transformaciones (qqplot y shapiro)

calif_yeo_transformed %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(sample = valor)) +
  stat_qq() +
  stat_qq_line()+
  labs(
    title = "QQ-Plots para las nuevas variables", 
  ) +
  facet_wrap(~ variable, scales = "free")

calif_log %>% gather(key = "variable", value = "valor") %>%
  ggplot(aes(sample = valor)) +
  stat_qq() +
  stat_qq_line()+
  labs(
    title = "QQ-Plots para las nuevas variables", 
  ) +
  facet_wrap(~ variable, scales = "free")


# Verificar la normalidad de las nuevas variables transformadas

shapiro_yeo <- calif_yeo_transformed %>% 
  summarise_all(shapiro_test_sample)

shapiro_log <- calif_log %>% 
  summarise_all(shapiro_test_sample)

print(rbind(shapiro_yeo, shapiro_log))

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

#Regresión


#-------------------------------------------------------------------------------
#R-1: Selección de las 5 variables más importantes, Para seleccionar las cinco 
#variables más importantes, podríamos basarnos en un análisis de correlación con
#la variable dependiente (MedianHouseValue) y elegir aquellas variables que muestren 
#una mayor correlación.Se utiliza el conjunto de datos completo.

# Calcular la correlación con MedianHouseValue
correlaciones <- cor(calif)
correlaciones_importantes <- sort(abs(correlaciones["MedianHouseValue", ]), decreasing = TRUE)
correlaciones_importantes

# Seleccionar las 5 variables más importantes basadas en la correlación, dejamos fuera
#la propia variable independiente que será la primera 
top5_variables <- names(correlaciones_importantes)[2:6]
top5_variables

#Aplicamos regresión lineal simple a cada una de las variables seleccionadas,
#medimos las calidad del ajuste con el coeficiente R^2 y el RMSE
modelos <- sapply(top5_variables, function(var) {
  fit <- lm(paste("MedianHouseValue ~", var), data = calif)
  R2 <- summary(fit)$r.squared
  RMSE <- sqrt(sum(fit$residuals^2))/length(fit$residuals)
  c(var = var, R2 = R2, RMSE = RMSE)
})

modelos_df <- data.frame(t(modelos), row.names = NULL, stringsAsFactors = FALSE)

#Realizamos de nuevo los ajuste para graficarlos
fitR1 <- lm(MedianHouseValue ~ MedianIncome, data = calif)
fitR2 <- lm(MedianHouseValue ~ Latitude, data = calif)
fitR3 <- lm(MedianHouseValue ~ TotalRooms, data = calif)
fitR4 <- lm(MedianHouseValue ~ HousingMedianAge, data = calif)
fitR5 <- lm(MedianHouseValue ~ Households, data = calif)

#Dataframe largo para graficar facetando por variable
calif_long <- calif %>%
  gather(key = "variable", value = "valor", MedianIncome, Latitude, TotalRooms, HousingMedianAge, Households)

# Creamos un dataframe con los coeficientes de los modelos
coef_df <- data.frame(
  variable = c("MedianIncome", "Latitude", "TotalRooms", "HousingMedianAge", "Households"),
  ordenada = c(coef(fitR1)[1], coef(fitR2)[1], coef(fitR3)[1], coef(fitR4)[1], coef(fitR5)[1]),
  pendiente = c(coef(fitR1)[2], coef(fitR2)[2], coef(fitR3)[2], coef(fitR4)[2], coef(fitR5)[2])
)

# Unir el dataframe largo con los coeficientes
calif_long <- merge(calif_long, coef_df, by = "variable")

# Graficar usando ggplot2 y facet_wrap
ggplot(calif_long, aes(x = valor, y = MedianHouseValue)) +
  geom_point(alpha = 0.5) +
  geom_abline(aes(intercept = ordenada, slope = pendiente, color = variable), show.legend = FALSE) +
  facet_wrap(~variable, scales = "free_x") +
  labs(x = "",
       y = "") +
  theme_minimal()

#Mejor Modelo

ggplot(calif, aes(x = MedianIncome, y = MedianHouseValue)) +
  geom_point(alpha = 0.5) +
  geom_abline(intercept = coef(fitR1)[1], slope = coef(fitR1)[2], color = "red") +
  labs(x = "Ingreso Mediano",
       y = "Valor Mediano de la Casa")

#-------------------------------------------------------------------------------
#R-2: Usar regresión lineal múltiple. Justificar si aporta mejoras respecto al 
#modelo lineal simple. Tener en cuenta no linealidad e interacciones.

fitR2_1 <- lm(MedianHouseValue ~ ., data = calif)
summary(fitR2_1)

#Se obtiene un R^2 de 0.6371

# Asignamos nuevos nombres de variables para simplificar 
calif_new <- calif
names(calif_new) <- c(paste("X", 1:8, sep = ""), "Y")

#Comenzamos backward selection con bastantes términos y vamos eliminando
#poco a poco.

fitR2_2 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1*X2 + X1*X3 + X1*X6 + X1*X7 + X1*X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X4 + X3*X6 + X3*X7 +
                X4*X5 + X4*X8 +
                X5*X6 + X5*X7 +
                X6*X7 + X6*X8 +
                X7*X8, 
              data=calif_new)

summary(fitR2_2)

#Eliminamos termino lineal X1 (p-valor 0.762592)

fitR2_3 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X6 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X4 + X3*X6 + X3*X7 +
                X4*X5 + X4*X8 +
                X5*X6 + X5*X7 +
                X6*X7 + X6*X8 +
                X7*X8, 
              data=calif_new)

summary(fitR2_3)

#Eliminamos término interacción entre X3 y X4 (p-valor 0.66173)

fitR2_4 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X6 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X6 + X3*X7 +
                X4*X5 + X4*X8 +
                X5*X6 + X5*X7 +
                X6*X7 + X6*X8 +
                X7*X8, 
              data=calif_new)

summary(fitR2_4)

#Eliminamos termino lineal de X7 (p-valor 0.46477)

fitR2_5 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X6 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X6 + X3:X7 +
                X4*X5 + X4*X8 +
                X5*X6 + X5:X7 +
                X6:X7 + X6*X8 +
                X7:X8, 
              data=calif_new)

summary(fitR2_5)

#Eliminamos término de interacción entre X1 y X6 (p-valor 0.45293)

fitR2_6 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X6 + X3:X7 +
                X4*X5 + X4*X8 +
                X5*X6 + X5:X7 +
                X6:X7 + X6*X8 +
                X7:X8, 
              data=calif_new)

summary(fitR2_6)

#Eliminamos término interacción entre X5 y X7 (p-valor 0.09387)

fitR2_7 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X6 + X3:X7 +
                X4*X5 + X4*X8 +
                X5*X6 +
                X6:X7 + X6*X8 +
                X7:X8, 
              data=calif_new)

summary(fitR2_7)

#Eliminamos término de interacción entre X7 y X8 (p-valor 0.000837)

fitR2_8 <- lm(Y ~ I(X3^2) + I(X4^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X6 + X3:X7 +
                X4*X5 + X4*X8 +
                X5*X6 +
                X6:X7 + X6*X8, 
              data=calif_new)

summary(fitR2_8)

#Eliminamos el término cuadrático de X4 (p-valor 0.000692)

fitR2_9 <- lm(Y ~ I(X3^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                X3*X6 + X3:X7 +
                X4*X5 + X4*X8 +
                X5*X6 +
                X6:X7 + X6*X8, 
              data=calif_new)

summary(fitR2_9)

#Quitamos el término de interacción entre X5 y X6 (p-valor 1.88e-06)

fitR2_10 <- lm(Y ~ I(X3^2) + I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                 X3*X6 + X3:X7 +
                 X4*X5 + X4*X8 +
                 X6:X7 + X6*X8, 
               data=calif_new)

summary(fitR2_10)

#Quitamos término cuadrático de X3 (p-valor 5.24e-09)

fitR2_11 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                 X3*X6 + X3:X7 +
                 X4*X5 + X4*X8 +
                 X6:X7 + X6*X8, 
               data=calif_new)

summary(fitR2_11)

#Quitamos término interacción entre X6 y X7 (p-valor 1.28e-12)

fitR2_12 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X7^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                 X3*X6 + X3:X7 +
                 X4*X5 + X4*X8 + 
                 X6*X8, 
               data=calif_new)

summary(fitR2_12)

#Quitamos término cuadrático de X7 (p-valor 7.08e-09)

fitR2_13 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X7 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                 X3*X6 + X3:X7 +
                 X4*X5 + X4*X8 + 
                 X6*X8, 
               data=calif_new)

summary(fitR2_13)

#Quitamos término de interacción entre X1 y X7 (p-valor 2.26e-08)

fitR2_14 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X6 + X2*X8 +
                 X3*X6 + X3:X7 +
                 X4*X5 + X4*X8 + 
                 X6*X8, 
               data=calif_new)

summary(fitR2_14)

#Quitamos término de interacción entre X2 y X6 (p-valor 6.48e-11)

fitR2_15 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X8 +
                 X3*X6 + X3:X7 +
                 X4*X5 + X4*X8 + 
                 X6*X8, 
               data=calif_new)

summary(fitR2_15)

#Eliminamos término lineal de X6 (p-valor 0.0770)

fitR2_16 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X8 +
                 X2*X3 + X2*X5 + X2*X8 +
                 X3:X6 + X3:X7 +
                 X4*X5 + X4*X8 + 
                 X6:X8, 
               data=calif_new)

summary(fitR2_16)

#Eliminamos término interacción entre X2 y X5 (p-valor 0.0179)

fitR2_17 <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                 X1:X2 + X1:X3 + X1:X8 +
                 X2*X3 + X2*X8 +
                 X3:X6 + X3:X7 +
                 X4*X5 + X4*X8 + 
                 X6:X8, 
               data=calif_new)

summary(fitR2_17)

#Todos los términos del ajuste tienen un p-valor<2e-16

#Por lo tanto el mejor modelo de regresión lineal múltiple encontrado para términos 
#cuadráticos en términos de interpretabilidad y rendimiento según el threshold escogido
#es el siguiente

fitR2_final <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                    X1:X2 + X1:X3 + X1:X8 +
                    X2*X3 + X2*X8 +
                    X3:X6 + X3:X7 +
                    X4*X5 + X4*X8 + 
                    X6:X8, 
                  data=calif_new)


R2_final <- summary(fitR2_final)$r.squared
RMSE_final <- sqrt(sum(fitR2_final$residuals^2))/length(fitR2_final$residuals)

R2_multi_lin <- summary(fitR2_1)$r.squared
RMSE_multi_lin <- sqrt(sum(fitR2_1$residuals^2))/length(fitR2_1$residuals)

resultados_R2 <- data.frame("Regresion" = c("Lineal sobre todas las variables",
                                          "No-linealidad e interacciones"),
                            "R2" = c(R2_multi_lin, R2_final),
                            "RMSE" = c(RMSE_multi_lin, RMSE_final))

#Se ha conseguido incrementar el valor de R^2 en 0.05 y se ha reducido un poco el RSME.

#-------------------------------------------------------------------------------

#R-3: Aplicar el algoritmo k-NN para regresión.

library(kknn)

#k-NN
nombre <- "california"
run_knn_fold <- function(i, x, tt = "test") {
  file <- paste(x, "-5-", i, "tra.dat", sep="")
  x_tra <- read.csv(file, comment.char="@", header=FALSE)
  file <- paste(x, "-5-", i, "tst.dat", sep="")
  x_tst <- read.csv(file, comment.char="@", header=FALSE)
  In <- length(names(x_tra)) - 1
  names(x_tra)[1:In] <- paste ("X", 1:In, sep="")
  names(x_tra)[In+1] <- "Y"
  names(x_tst)[1:In] <- paste ("X", 1:In, sep="")
  names(x_tst)[In+1] <- "Y"
  if (tt == "train") {
    test <- x_tra
  }
  else { test <- x_tst
  }
  fitMulti <- kknn(Y~.,x_tra,test)
  yprime <- fitMulti$fitted.values
  sum(abs(test$Y-yprime)^2)/length(yprime) 
}

knnMSEtrain<-mean(sapply(1:5,run_knn_fold,nombre,"train"))
knnMSEtest<-mean(sapply(1:5,run_knn_fold,nombre,"test"))


#No lineal
run_lm_fold <- function(i, x, tt = "test") {
  file <- paste(x, "-5-", i, "tra.dat", sep="")
  x_tra <- read.csv(file, comment.char="@" , header=FALSE )
  file <- paste(x, "-5-", i, "tst.dat", sep="")
  x_tst <- read.csv(file, comment.char="@" , header=FALSE )
  In <- length(names(x_tra)) - 1
  names(x_tra)[1:In] <- paste ("X", 1:In, sep="")
  names(x_tra)[In+1] <- "Y"
  names(x_tst)[1:In] <- paste ("X", 1:In, sep="")
  names(x_tst)[In+1] <- "Y"
  if (tt == "train") { test <- x_tra }
  else { test <- x_tst }
  fitMulti <- lm(Y ~ I(X5^2) + I(X6^2) + I(X8^2) +
                X1:X2 + X1:X3 + X1:X8 +
                X2*X3 + X2*X8 +
                X3:X6 + X3:X7 +
                X4*X5 + X4*X8 + 
                X6:X8, 
              data=x_tra)
  yprime <- predict(fitMulti, test)
  sum(abs(test$Y-yprime)^2)/length(yprime) 
}

lmMSEtrain<-mean(sapply(1:5,run_lm_fold, nombre, "train"))
lmMSEtest<-mean(sapply(1:5,run_lm_fold, nombre, "test"))

#-------------------------------------------------------------------------------

#R-4: Comparación de algoritmos.


run_lm2_fold <- function(i, x, tt = "test") {
  file <- paste(x, "-5-", i, "tra.dat", sep="")
  x_tra <- read.csv(file, comment.char="@" , header=FALSE )
  file <- paste(x, "-5-", i, "tst.dat", sep="")
  x_tst <- read.csv(file, comment.char="@" , header=FALSE )
  In <- length(names(x_tra)) - 1
  names(x_tra)[1:In] <- paste ("X", 1:In, sep="")
  names(x_tra)[In+1] <- "Y"
  names(x_tst)[1:In] <- paste ("X", 1:In, sep="")
  names(x_tst)[In+1] <- "Y"
  if (tt == "train") { test <- x_tra }
  else { test <- x_tst }
  fitMulti <- lm(Y ~ ., 
                 data=x_tra)
  yprime <- predict(fitMulti, test)
  sum(abs(test$Y-yprime)^2)/length(yprime) ##MSE
}

lm2MSEtrain<-mean(sapply(1:5,run_lm2_fold, nombre, "train"))
lm2MSEtest<-mean(sapply(1:5,run_lm2_fold, nombre, "test"))

#Leemos la tabla con los errores medios de test tras haber cambiado el MSE del
#dataset california

resultados <- read.csv("regr_test_alumnos.csv")
tablatst <- cbind(resultados[,2:dim(resultados)[2]])
colnames(tablatst) <- names(resultados)[2:dim(resultados)[2]]
rownames(tablatst) <- resultados[,1]

#Leemos la tabla con los errores medios de entrenamiento tras cambiar el MSE del
#dataset california
resultados <- read.csv("regr_train_alumnos.csv")
tablatra <- cbind(resultados[,2:dim(resultados)[2]])
colnames(tablatra) <- names(resultados)[2:dim(resultados)[2]]
rownames(tablatra) <- resultados[,1]

#Wilcoxon
difs_tst <- (tablatst[,1] - tablatst[,2]) / tablatst[,1]
difs_tra <- (tablatra[,1] - tablatra[,2]) / tablatra[,1]
wilc_1_2_tst <- cbind(ifelse(difs_tst<0, abs(difs_tst)+0.1, 0+0.1), ifelse (difs_tst>0, abs(difs_tst)+0.1, 0+0.1))
wilc_1_2_tra <- cbind(ifelse(difs_tra<0, abs(difs_tra)+0.1, 0+0.1), ifelse (difs_tra>0, abs(difs_tra)+0.1, 0+0.1))

colnames(wilc_1_2_tst) <- c(colnames(tablatst)[1], colnames(tablatst)[2])
colnames(wilc_1_2_tra) <- c(colnames(tablatst)[1], colnames(tablatst)[2])

LMvsKNNtst <- wilcox.test(wilc_1_2_tst[,1], wilc_1_2_tst[,2], alternative = "two.sided", paired=TRUE)
Rmas_tst <- LMvsKNNtst$statistic
pvalue_tst <- LMvsKNNtst$p.value
LMvsKNNtst <- wilcox.test(wilc_1_2_tst[,2], wilc_1_2_tst[,1], alternative = "two.sided", paired=TRUE)
Rmenos_tst <- LMvsKNNtst$statistic

LMvsKNNtra <- wilcox.test(wilc_1_2_tra[,1], wilc_1_2_tra[,2], alternative = "two.sided", paired=TRUE)
Rmas_tra <- LMvsKNNtra$statistic
pvalue_tra <- LMvsKNNtra$p.value
LMvsKNNtra <- wilcox.test(wilc_1_2_tra[,2], wilc_1_2_tra[,1], alternative = "two.sided", paired=TRUE)
Rmenos_tra <- LMvsKNNtra$statistic

#Friedman
test_friedman_tst <- friedman.test(as.matrix(tablatst))
test_friedman_tst

test_friedman_tra <- friedman.test(as.matrix(tablatra))
test_friedman_tra

#Holm
tam <- dim(tablatst)
groups <- rep(1:tam[2], each=tam[1])
pairwise.wilcox.test(as.matrix(tablatst), groups, p.adjust = "holm", paired = TRUE)
pairwise.wilcox.test(as.matrix(tablatra), groups, p.adjust = "holm", paired = TRUE)

