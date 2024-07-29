# Proyectos de Análisis de Datos en SQL

Este repositorio contiene varios proyectos de análisis de datos realizados en SQL. Cada proyecto aborda diferentes aspectos del análisis de datos, desde la limpieza de datos hasta el análisis exploratorio.

## Tabla de Contenidos
1. [Limpieza de Datos](#limpieza-de-datos)
2. [Análisis Exploratorio de Datos (EDA)](#analisis-exploratorio-de-datos-eda)

## 1. Limpieza de Datos

En este proyecto se realiza la limpieza de un conjunto de datos utilizando MySQL Workbench. Los pasos incluyen la remoción de duplicados, estandarización de datos, manejo de valores nulos y blancos, y la eliminación de columnas innecesarias.

### Pasos Realizados

- **Tabla de Respaldo**: Creación de una tabla de respaldo para mantener los datos originales intactos.
- **Remover Duplicados**: Identificación y eliminación de filas duplicadas.
- **Estandarizar los Datos**: Estandarización de las columnas de la tabla.
- **Manejo de Valores Nulos o Blancos**: Reemplazo de valores blancos por nulos y eliminación de filas con valores nulos en columnas clave.
- **Remover Columnas Innecesarias**: Eliminación de columnas innecesarias para el análisis.

[Ver archivo completo](https://github.com/BryanTenorio/SQL-Projects/blob/main/Limpieza_Datos.sql)

## 2. Análisis Exploratorio de Datos (EDA)

En este proyecto se realiza un análisis exploratorio del conjunto de datos limpio para obtener insights sobre los datos.

### Pasos Realizados

- **Visualización General de los Datos**: Selección de todos los datos para obtener una visión general.
- **Valores Máximos**: Obtención de los valores máximos de `total_laid_off` y `percentage_laid_off`.
- **Empresas con Mayor Porcentaje de Despidos**: Selección de las empresas que han despedido el 100% de su personal y ordenación por fondos recaudados.
- **Despidos por Empresa**: Suma de los despidos por empresa y ordenación en orden descendente.
- **Rango de Fechas**: Obtención de las fechas mínima y máxima de los despidos.
- **Despidos por Industria**: Suma de los despidos por industria y ordenación en orden descendente.
- **Despidos por País**: Suma de los despidos por país y ordenación en orden descendente.
- **Despidos por Año**: Suma de los despidos por año y ordenación en orden descendente.
- **Despidos por Etapa**: Suma de los despidos por etapa de la empresa y ordenación en orden descendente.
- **Despidos por Mes**: Suma de los despidos por mes y ordenación cronológica.
- **Total Acumulado de Despidos por Mes**: Cálculo del total acumulado de despidos por mes.
- **Top 5 Empresas con Más Despidos por Año**: Selección de las 5 empresas con más despidos por año.

[Ver archivo completo](https://github.com/BryanTenorio/SQL-Projects/blob/main/EDA.sql)

## Sobre el Autor

Mi nombre es Jhon Tenorio y este repositorio es parte de mi portafolio como Analista de Datos. Aquí presento mis habilidades en SQL para la limpieza de datos y el análisis exploratorio. Para ver más proyectos y mi progreso en el análisis de datos, visita mi [perfil de GitHub](https://github.com/BryanTenorio).
