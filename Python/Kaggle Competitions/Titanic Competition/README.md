# Titanic Survival Prediction / Predicción de Supervivientes en el Titanic 🚢

## Overview 🇬🇧

This project is based on the **Kaggle Titanic Survival Competition**, which aims to predict whether a passenger survived the sinking of the Titanic based on various demographic and social features. The project includes a comprehensive **Exploratory Data Analysis (EDA)**, **feature engineering**, and the use of **machine learning models** for classification.

---

## Key Steps and Highlights 🔍

### 1. Extensive Exploratory Data Analysis (EDA) 📈

- **Data Cleaning**: Handled missing data in key features such as age, passenger class, and ticket fare, identifying the underlying reasons behind missing values.
- **Data Visualization**: Created plots to observe the distribution of features and their relationship with survival, helping to identify significant patterns.
- **Target Variable Distribution**: Analyzed the distribution of the target variable (survival) to understand the proportion of survivors in the dataset.

### 2. Feature Engineering 🛠️

- **Derived Features**: Created new variables from existing ones, such as:
  - **Family Size**: Combining name and sibling/spouse information to identify family groups.
  - **Title Extraction**: Extracting titles (Mr., Mrs., etc.) from names to capture information about social status.
- **Variable Transformation**: Applied transformations to categorical variables, such as one-hot encoding to convert categorical features into numerical format.

### 3. Data Preparation and Modeling ⚙️

- **Data Preprocessing**: Prepared the dataset by:
  - Imputing missing values based on analysis.
  - Scaling features as necessary.
- **Classification Models**: Implemented various machine learning models, including:
  - **Logistic Regression**
  - **Decision Trees**
  - **Random Forest**
- **Hyperparameter Tuning**: Adjusted hyperparameters to improve performance, focusing on optimizing the **accuracy metric**.

### 4. Results and Insights 📊

- **Model Performance**: Models achieved an **accuracy of 80%** in predicting survival, with the **Random Forest** model delivering the best results.
- **Feature Importance**: Identified key features, such as passenger class and gender, which significantly impacted survival rates.

<br/>

## Descripción 🇪🇸

Este proyecto se basa en la **Competición de Supervivencia del Titanic de Kaggle**, cuyo objetivo es predecir si un pasajero sobrevivió al hundimiento del Titanic en función de varias características demográficas y sociales. El proyecto incluye un **Análisis Exploratorio de Datos (EDA)** exhaustivo, **ingeniería de características** y el uso de modelos de **aprendizaje automático** para realizar la clasificación.

---

## Pasos Clave y Destacados 🔍

### 1. Análisis Exploratorio de Datos 📈

- **Limpieza de Datos**: Se manejaron datos faltantes en características clave, como edad, clase del pasajero y tarifa del boleto, identificando las razones subyacentes detrás de los valores ausentes.
- **Visualización de Datos**: Se crearon gráficos para observar la distribución de características y su relación con la supervivencia, ayudando a identificar patrones significativos.
- **Distribución de la Variable Objetivo**: Se analizó la distribución de la variable objetivo (supervivencia) para entender la proporción de sobrevivientes en el conjunto de datos.

### 2. Ingeniería de Características 🛠️

- **Características Derivadas**: Se crearon nuevas variables a partir de las existentes, como:
  - **Familia**: Combinando el nombre y la información sobre hermanos/cónyuges para identificar grupos familiares.
  - **Título**: Extrayendo títulos (Sr., Sra., etc.) de los nombres para capturar información sobre el estatus social.
- **Transformación de Variables**: Se aplicaron transformaciones a variables categóricas, como la codificación one-hot para convertir características categóricas en formato numérico.

### 3. Preparación y Modelado ⚙️

- **Preprocesamiento de Datos**: El conjunto de datos fue preparado mediante:
  - Imputación de valores faltantes basada en su análisis.
  - Escalado de características según fuera necesario.
- **Modelos de Clasificación**: Se implementaron varios modelos de aprendizaje automático, incluyendo:
  - **Regresión Logística**
  - **Árboles de Decisión**
  - **Random Forest**
- **Ajuste de Hiperparámetros**: Se ajustaron los hiperparámetros para mejorar el rendimiento, centrándose en optimizar la métrica de **exactitud**.

### 4. Resultados e Insights 📊

- **Rendimiento del Modelo**: Los modelos alcanzaron una **exactitud del 80%** en la predicción de la supervivencia, con el modelo de **Random Forest** ofreciendo los mejores resultados.
- **Importancia de Características**: Se identificaron características clave, como la clase del pasajero y el sexo, que tuvieron un impacto significativo en la tasa de supervivencia.
