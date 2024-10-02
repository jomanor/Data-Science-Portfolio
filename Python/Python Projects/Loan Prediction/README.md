# Loan Default Prediction / Predicción de Incumplimiento de Pagos 🏦📊

## Overview 🇬🇧 

This project aims to answer the research question: *What borrower details, financial attributes, and potential interactions predict loan default for loans issued between 2012 and 2019 using advanced machine learning techniques?* Through a structured methodology involving data cleaning, exploratory data analysis (EDA), feature engineering, and model evaluation, the project explores the relationship between various loan features and the likelihood of default. Advanced techniques like Logistic Regression, Random Forest, and Decision Tree models are used to provide valuable insights and improve prediction accuracy.

### 📊 Data
The dataset used in this project is **Lending Club Loan Data**, which includes information about loans issued between 2012 and 2019. Key attributes related to borrower details and financial features are:
- `int_rate`: The interest rate of the loan.
- `total_rec_prncp`: Total principal received.
- `last_pymnt_amnt`: The amount of the last payment made by the borrower.

### 🎯 Research Question and Hypotheses

- **Research Question**: *What borrower details, financial attributes, and potential interactions predict loan default for loans issued between 2012 and 2019 using Advanced Machine Learning techniques?*
  
- **Alternative Hypothesis (H1)**: Suggests that there is a significant relationship between at least one borrower detail, financial attribute, or potential interaction and loan defaults for loans issued between 2012 and 2019.

- **Null Hypothesis (H0)**: Suggests no significant relationship between borrower details, financial attributes, or potential interactions and loan defaults for loans issued between 2012 and 2019.

### ⚙️ Methodology

This project follows a systematic approach, including:
1. **Data Cleaning**: Handling missing data and outliers.
2. **Exploratory Data Analysis (EDA)**: Investigating key patterns and relationships.
3. **Feature Engineering**: Creating meaningful features from existing data (e.g., time variables from loan start dates).
4. **Feature Selection**: Identifying the most relevant features for prediction.
5. **Modeling**: Implementing **Logistic Regression**, **Random Forest**, and **Decision Tree** models.
6. **Evaluation**: Using **Confusion Matrix** and **ROC Curve** for performance evaluation.

### 🧪 Model Results and Analysis

#### Logistic Regression Coefficients:
- **int_rate**: Positive coefficient (0.78), indicating that higher interest rates increase the likelihood of default.
- **total_rec_prncp**: Negative coefficient (-1.49), suggesting that a higher total principal received reduces the probability of default.
- **last_pymnt_amnt**: Negative coefficient (-7.63), showing that larger last payment amounts lower the default risk.

#### Feature Importance (Random Forest & Decision Tree):

- **Random Forest**: 
  - `last_pymnt_amnt` (0.54) is the most important feature.
  - `total_rec_prncp` (0.38) follows in importance.
  - `int_rate` (0.08) is the least important feature.
  
- **Decision Tree**:
  - `last_pymnt_amnt` (0.67) is the most important feature.
  - `total_rec_prncp` (0.30) comes next.
  - `int_rate` (0.03) has minimal impact.

These results demonstrate that **last payment amount (`last_pymnt_amnt`)** is consistently the strongest predictor of loan default, followed by **total principal received (`total_rec_prncp`)**.

### 🔍 Model Evaluation

The models were evaluated based on precision, recall, F1-score, and accuracy. The **Random Forest** model, which excluded `int_rate`, performed the best across all metrics. Evaluation tools like the **Confusion Matrix** and **ROC Curve** further reinforced the superior performance of this model.

### 📈 Conclusion

- **Alternative Hypothesis (H1)** is accepted. Evidence supports the significant relationship between borrower details and financial attributes (like `last_pymnt_amnt`, `total_rec_prncp`) and loan defaults.
- **Null Hypothesis (H0)** is rejected, as there is a clear association between the identified features and the likelihood of default.

The **Random Forest** model, with the exclusion of `int_rate`, emerges as the best performing model for predicting loan defaults, achieving the highest scores in all performance metrics.

## Descripción 🇪🇸 

Este proyecto tiene como objetivo responder a la pregunta de investigación: *¿Qué detalles del prestatario, atributos financieros e interacciones potenciales predicen el incumplimiento de préstamos emitidos entre 2012 y 2019 utilizando técnicas avanzadas de aprendizaje automático?* A través de una metodología estructurada que incluye limpieza de datos, análisis exploratorio de datos (EDA), ingeniería de características y evaluación de modelos, el proyecto explora la relación entre diversas características del préstamo y la probabilidad de incumplimiento. Se utilizan técnicas avanzadas como la **Regresión Logística**, **Random Forest** y **Árbol de Decisión** para proporcionar valiosas ideas y mejorar la precisión de la predicción.

### 📊 Datos
El conjunto de datos utilizado es **Lending Club Loan Data**, que incluye información sobre préstamos emitidos entre 2012 y 2019. Los atributos clave relacionados con los detalles del prestatario y los rasgos financieros son:
- `int_rate`: Tasa de interés del préstamo.
- `total_rec_prncp`: Capital total recibido.
- `last_pymnt_amnt`: Monto del último pago realizado por el prestatario.

### 🎯 Pregunta de Investigación e Hipótesis

- **Pregunta de Investigación**: *¿Qué detalles del prestatario, atributos financieros e interacciones potenciales predicen el incumplimiento de préstamos emitidos entre 2012 y 2019 utilizando técnicas avanzadas de aprendizaje automático?*
  
- **Hipótesis Alternativa (H1)**: Sugiere que existe una relación significativa entre al menos uno de los detalles del prestatario, los atributos financieros o las interacciones potenciales y los incumplimientos de préstamos emitidos entre 2012 y 2019.

- **Hipótesis Nula (H0)**: Sugiere que no existe una relación significativa entre los detalles del prestatario, los atributos financieros o las interacciones potenciales y los incumplimientos de préstamos emitidos entre 2012 y 2019.

### ⚙️ Metodología

Este proyecto sigue un enfoque sistemático, que incluye:
1. **Limpieza de Datos**: Manejo de datos faltantes y valores atípicos.
2. **Análisis Exploratorio de Datos (EDA)**: Investigación de patrones clave y relaciones.
3. **Ingeniería de Características**: Creación de características significativas a partir de los datos existentes (por ejemplo, variables de tiempo a partir de las fechas de inicio del préstamo).
4. **Selección de Características**: Identificación de las características más relevantes para la predicción.
5. **Modelado**: Implementación de modelos como **Regresión Logística**, **Random Forest** y **Árbol de Decisión**.
6. **Evaluación**: Uso de **Matrices de Confusión** y **Curvas ROC** para evaluar el rendimiento.

### 🧪 Resultados del Modelo y Análisis

#### Coeficientes de la Regresión Logística:
- **int_rate**: Coeficiente positivo (0.78), indicando que tasas de interés más altas aumentan la probabilidad de incumplimiento.
- **total_rec_prncp**: Coeficiente negativo (-1.49), lo que sugiere que un mayor capital total recibido reduce la probabilidad de incumplimiento.
- **last_pymnt_amnt**: Coeficiente negativo (-7.63), mostrando que montos mayores en el último pago reducen el riesgo de incumplimiento.

#### Importancia de las Características (Random Forest y Árbol de Decisión):

- **Random Forest**:
  - `last_pymnt_amnt` (0.54) es la característica más importante.
  - `total_rec_prncp` (0.38) le sigue en importancia.
  - `int_rate` (0.08) es la característica menos importante.
  
- **Árbol de Decisión**:
  - `last_pymnt_amnt` (0.67) sigue siendo la característica más importante.
  - `total_rec_prncp` (0.30) viene después.
  - `int_rate` (0.03) tiene un impacto mínimo.

Estos resultados demuestran que el **último monto de pago (`last_pymnt_amnt`)** es consistentemente el predictor más fuerte del incumplimiento de préstamos, seguido por el **capital total recibido (`total_rec_prncp`)**.

### 🔍 Evaluación del Modelo

Los modelos fueron evaluados en función de precisión, recall, F1-score y exactitud. El modelo **Random Forest**, excluyendo `int_rate`, obtuvo el mejor rendimiento en todas las métricas. Herramientas como la **Matriz de Confusión** y la **Curva ROC** confirmaron el rendimiento superior de este modelo.

### 📈 Conclusión

- **Hipótesis Alternativa (H1)** aceptada. La evidencia respalda la existencia de una relación significativa entre los detalles del prestatario y los atributos financieros (como `last_pymnt_amnt`, `total_rec_prncp`) y los incumplimientos de préstamos.
- **Hipótesis Nula (H0)** rechazada, ya que existe una clara asociación entre las características identificadas y la probabilidad de incumplimiento.

El modelo **Random Forest**, con la exclusión de `int_rate`, surge como el mejor modelo para predecir incumplimientos de préstamos, logrando las puntuaciones más altas en todas las métricas de rendimiento.
