# 🏠 House Pricing Prediction/Predicción del Precio de Viviendas

## Overview 🇬🇧

This project is based on the **House Pricing Kaggle Competition**, where the objective is to predict house prices based on various features related to the property and its surroundings. 

---

## Key Steps and Highlights 🔍

### 1. Extensive Exploratory Data Analysis (EDA) 📈

- **Data Cleaning and Imputation**: Missing data was handled carefully, identifying the underlying reasons behind missing values. Certain features were missing based on logical patterns (e.g., no garage data for houses without garages).
- **Feature Relationships**: Analyzed correlations and relationships between variables, visualizing trends and dependencies using graphs.
- **Target Distribution**: Analyzed the distribution of the target variable (house price) to understand the data's skewness and apply transformations when necessary.

### 2. Feature Engineering 🛠️

- **Time Variables**: Created several **time-related features** from the original year variables (e.g., year built, year sold). These variables help capture how the house's age and market timing influence its price.
- **Structural Features**: Generated **structural features** from the physical characteristics of the house, like the number of rooms, square footage, and materials used, to enhance the model’s predictive power.
- **Transformation of Variables**: Applied various transformations to skewed data, making features more suitable for regression.

### 3. Preprocessing and Model Preparation ⚙️

- **Data Preprocessing**: The dataset was scaled, transformed, and preprocessed to make it suitable for modeling. This included:
  - Imputation of missing values based on their observed patterns.
  - Encoding of categorical variables where necessary.
  - Feature scaling and normalization where needed.

### 4. Modeling with CatBoost 🧠

- **CatBoost Regression**: After preparing the data, a **CatBoost Regressor** was applied to predict the house prices. The model was chosen due to its robustness with categorical data and ability to handle overfitting.
- **Model Fine-tuning**: Hyperparameters were fine-tuned to improve performance, focusing on optimizing the **Root Mean Squared Error (RMSE)** metric.

### 5. Results and Insights 📊

- **Model Performance**: The model achieved an RMSE of **0.13**, indicating a high level of accuracy in predicting house prices.
- **Feature Importance**: Several engineered features such as time-based and structural variables significantly contributed to the model’s predictive capabilities.

---

## Conclusions 🔍

This project demonstrates the importance of thorough **Exploratory Data Analysis (EDA)**, thoughtful **feature engineering**, and choosing the right model for the task. By incorporating advanced **CatBoost Regression** and applying significant data transformations, the model was able to achieve a strong predictive performance in the Kaggle competition.

<br/>

## Descripción 🇪🇸

Este proyecto se basa en la **Competición de Precios de Viviendas de Kaggle**, donde el objetivo es predecir los precios de las viviendas en función de varias características relacionadas con la propiedad y su entorno. 

---

## Pasos Clave y Destacados 🔍

### 1. Análisis Exploratorio de Datos (EDA) Extenso 📈

- **Limpieza e Imputación de Datos**: Se manejaron cuidadosamente los datos faltantes, identificando las razones subyacentes detrás de los valores perdidos. Ciertas características estaban ausentes basándose en patrones lógicos (por ejemplo, datos de garaje ausentes para casas sin garaje).
- **Relaciones entre Características**: Se analizaron las correlaciones y relaciones entre variables, visualizando tendencias y dependencias mediante gráficos.
- **Distribución del Objetivo**: Se analizó la distribución de la variable objetivo (precio de la vivienda) para entender la asimetría de los datos y aplicar transformaciones cuando fue necesario.

### 2. Ingeniería de Características 🛠️

- **Variables de Tiempo**: Se crearon varias **características relacionadas con el tiempo** a partir de las variables de año originales (por ejemplo, año de construcción, año de venta). Estas variables ayudan a capturar cómo la antigüedad de la vivienda y el momento del mercado influyen en su precio.
- **Características Estructurales**: Se generaron **características estructurales** a partir de las características físicas de la vivienda, como el número de habitaciones, pies cuadrados y materiales utilizados, para mejorar el poder predictivo del modelo.
- **Transformación de Variables**: Se aplicaron varias transformaciones a datos sesgados, haciendo que las características fueran más adecuadas para la regresión.

### 3. Preprocesamiento y Preparación del Modelo ⚙️

- **Preprocesamiento de Datos**: El conjunto de datos fue escalado, transformado y preprocesado para hacerlo adecuado para el modelado. Esto incluyó:
  - Imputación de valores faltantes basada en sus patrones observados.
  - Codificación de variables categóricas cuando fue necesario.
  - Escalado y normalización de características según fuera necesario.

### 4. Modelado con CatBoost 🧠

- **Regresión CatBoost**: Después de preparar los datos, se aplicó un **Regresor CatBoost** para predecir los precios de las viviendas. Se eligió este modelo debido a su robustez con datos categóricos y su capacidad para manejar el sobreajuste.
- **Ajuste de Hiperparámetros**: Se ajustaron los hiperparámetros para mejorar el rendimiento, centrándose en optimizar la métrica de **Error Cuadrático Medio (RMSE)**.

### 5. Resultados e Insights 📊

- **Rendimiento del Modelo**: El modelo alcanzó un RMSE de **0.13**, lo que indica un alto nivel de precisión en la predicción de precios de viviendas.
- **Importancia de Características**: Varios atributos ingenierizados, como las variables relacionadas con el tiempo y las estructurales, contribuyeron significativamente a las capacidades predictivas del modelo.

---

## Conclusiones 🔍

Este proyecto demuestra la importancia de un **Análisis Exploratorio de Datos (EDA)** exhaustivo, una **ingeniería de características** reflexiva y la elección del modelo adecuado para la tarea. Al incorporar una **Regresión CatBoost** avanzada y aplicar transformaciones significativas en los datos, el modelo logró un sólido rendimiento predictivo en la competencia de Kaggle.
