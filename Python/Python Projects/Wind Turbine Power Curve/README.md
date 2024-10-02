# Wind Turbine Power Curve Estimation/Estimación de la Curva de Potencia de un Molino de viento 🧭🌬️

## Overview 🇬🇧 

The wind turbine power curve shows the relationship between the wind turbine power and hub height wind speed. It essentially captures the wind turbine performance. Hence, it plays an important role in condition monitoring and control of wind turbines. Power curves made available by the manufacturers help in estimating the wind energy potential in a candidate site. Accurate models of power curve serve as an important tool in wind power forecasting and aid in wind farm expansion.

### 📊 Data
This data is an actual operational dataset of an inland wind turbine which is freely available on [TAMU Library](https://tamucs-my.sharepoint.com/personal/yu-ding_tamu_edu/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fyu%2Dding%5Ftamu%5Fedu%2FDocuments%2FWind%5FSpatio%5FTemporal%5FDataset1%2Ezip&parent=%2Fpersonal%2Fyu%2Dding%5Ftamu%5Fedu%2FDocuments&cid=34459bcf-3ce4-41fb-ac24-c1ccc5fbb0ac). The data were collected from July 30, 2010 through July 31, 2011. The dataset also includes environmental variables collected from met masts.

The attributes in the file are:

- V: wind speed (m/s),
- D: wind direction (degree),
- rho: air density (kg/m^3),
- I: turbulence intensity,
- Sb: below-hub wind shear,
- y: output power relative to the input power (%).

### 🎯 Objective
The objective of this project is to analyze the wind-turbine data and predict the power curve of a wind turbine using regression techniques.

### 🧪 Conclusion

For predicting the relative power, we face two key issues:
- Relative power cannot go outside the range of [0, 100].
- We know that the true power curve is non-linear.

To address the first problem in a regression model, we can apply a sigmoid function, though it may alter the distribution of the response variable. To solve both issues, tree-based methods were employed, which provided better results than other models. The results are summarized below:

| Model | R² Value | Test RMSE |
| --- | --- | --- |
| Polynomial (Degree 4) Regression | 0.92814 | 9.072 |
| Randomforest Regression | 0.99398 | 6.721 |
| Gradient Boost Regression | 0.97786 | 6.631 |
| XGBoost Regression | 0.97755 | 6.404 |

Furthermore, feature importance plots suggest that **Wind Speed (Velocity)**, **Wind Direction**, and **Wind Shear** are the most important features for predicting relative power.

<br/>

## Descripción 🇪🇸 

La curva de potencia de un aerogenerador muestra la relación entre la potencia de la turbina eólica y la velocidad del viento a la altura del buje. Captura esencialmente el rendimiento de la turbina, y por ello, juega un papel importante en el monitoreo y control de las condiciones de los aerogeneradores. Las curvas de potencia proporcionadas por los fabricantes ayudan a estimar el potencial energético eólico en un sitio candidato. Modelos precisos de la curva de potencia son una herramienta clave en la previsión de la energía eólica y en la expansión de parques eólicos.

### 📊 Datos
Este conjunto de datos es un dataset operativo real de un aerogenerador en tierra, disponible gratuitamente en [TAMU Library](https://tamucs-my.sharepoint.com/personal/yu-ding_tamu_edu/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fyu%2Dding%5Ftamu%5Fedu%2FDocuments%2FWind%5FSpatio%5FTemporal%5FDataset1%2Ezip&parent=%2Fpersonal%2Fyu%2Dding%5Ftamu%5Fedu%2FDocuments&cid=34459bcf-3ce4-41fb-ac24-c1ccc5fbb0ac). Los datos fueron recolectados desde el 30 de julio de 2010 hasta el 31 de julio de 2011. También incluye variables ambientales recopiladas de mástiles meteorológicos.

Los atributos en el archivo son:

- V: velocidad del viento (m/s),
- D: dirección del viento (grados),
- rho: densidad del aire (kg/m^3),
- I: intensidad de la turbulencia,
- Sb: cizalladura del viento bajo el buje,
- y: potencia de salida relativa a la de ingreso (%).

### 🎯 Objetivo
El objetivo de este proyecto es analizar los datos del aerogenerador y predecir la curva de potencia de un aerogenerador utilizando técnicas de regresión.

### 🧪 Conclusión

Al predecir la potencia relativa, nos encontramos con dos problemas clave:
- La potencia relativa no puede estar fuera del rango [0, 100].
- Sabemos que la curva de potencia real es no lineal.

Para abordar el primer problema en un modelo de regresión, podemos aplicar una función sigmoidea, aunque puede alterar la distribución de la variable de respuesta. Para resolver ambos problemas, se emplearon métodos basados en Random Forest, que proporcionaron mejores resultados que otros modelos. Los resultados se resumen a continuación:

| Modelo | Valor R² | RMSE de Prueba |
| --- | --- | --- |
| Regresión Polinómica (Grado 4) | 0.92814 | 9.072 |
| Regresión con Randomforest | 0.99398 | 6.721 |
| Regresión con Gradient Boost | 0.97786 | 6.631 |
| Regresión con XGBoost | 0.97755 | 6.404 |

Además, los gráficos de importancia de las características sugieren que la **Velocidad del Viento**, **Dirección del Viento**, y **Cizalladura del Viento** son las características más importantes para predecir la potencia relativa.

