# Proyectos de Análisis de Datos en SQL

Este repositorio contiene varios proyectos de análisis de datos realizados en SQL. Cada proyecto aborda diferentes aspectos del análisis de datos, desde la limpieza de datos hasta el análisis exploratorio.

## Tabla de Contenidos
1. [Limpieza de Datos](#limpieza-de-datos)
2. [Análisis Exploratorio de Datos (EDA)](#analisis-exploratorio-de-datos-eda)

## 1. Limpieza de Datos

En este proyecto se realiza la limpieza de un conjunto de datos utilizando MySQL Workbench. Los pasos incluyen la remoción de duplicados, estandarización de datos, manejo de valores nulos y blancos, y la eliminación de columnas innecesarias.

### Pasos Realizados

#### 1. Tabla de Respaldo
Se crea una tabla de respaldo y se insertan los datos originales en esta tabla para asegurar que los datos originales se mantengan intactos.

```sql
-- Creación de Tabla de Respaldo
CREATE TABLE layoffs_staging
LIKE layoffs;
INSERT layoffs_staging
SELECT *
FROM layoffs;
