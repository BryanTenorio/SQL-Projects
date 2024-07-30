-- Limpieza de datos

-- 1. Tabla de respaldo
-- 2. Remover duplicados
-- 3. Estandarizar los datos
-- 4. Valores Nulos o Valores Blancos
-- 5. Remover algunas Columnas

-- Paso 1: Creación de Tabla de Respaldo
-- Crear una tabla de respaldo con la misma estructura que la tabla original
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Verificar la estructura de la tabla de respaldo
SELECT * 
FROM layoffs_staging;

-- Insertar datos en la tabla de respaldo
INSERT layoffs_staging
SELECT *
FROM layoffs;

-- Verificar los datos en la tabla de respaldo
SELECT * 
FROM layoffs_staging;

-- Paso 2: Remover duplicados
-- Identificar duplicados con ROW_NUMBER()
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
FROM layoffs_staging;

-- Crear CTE para duplicados
WITH duplicate_cte AS
(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
        ) AS row_num
	FROM layoffs_staging
)

-- Seleccionar y verificar los duplicados identificados
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Crear una segunda tabla de respaldo para trabajar con los duplicados
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Verificar la estructura de la segunda tabla de respaldo
SELECT * 
FROM layoffs_staging2;

-- Desactivar las actualizaciones seguras para permitir la eliminación masiva
SET SQL_SAFE_UPDATES = 0;

-- Insertar los datos en la segunda tabla de respaldo, incluyendo el row_num
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Verificar los duplicados en la segunda tabla de respaldo
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

-- Eliminar los duplicados de la segunda tabla de respaldo
DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

-- Verificar que los duplicados han sido eliminados
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

-- Paso 3: Estandarizar los datos
-- Eliminar los espacios en blanco al inicio y al final de la columna company
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- Verificar los valores distintos de la columna industry
SELECT DISTINCT industry
FROM layoffs_staging2;

-- Estandarizar los valores en la columna industry que empiezan con 'Crypto'
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Verificar los valores distintos de la columna location
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- Verificar los valores distintos de la columna country
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- Estandarizar los valores en la columna country que empiezan con 'United States'
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- Convertir la columna `date` al formato DATE
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Hacer que la columna `date` sea de tipo DATE
	-- Hacer solo el cambio de variable en la fecha solo si tiene un formato establecido
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Verificar los cambios en la columna `date`
SELECT `date`
FROM layoffs_staging2;

-- Paso 4: Valores Blancos y Nulos
-- Verificar los registros con valores nulos en total_laid_off y percentage_laid_off
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Establecer industry como NULL donde esté vacío
UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

-- Verificar los registros donde industry es NULL o vacío
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- Verificar los registros específicos de la empresa 'Airbnb'
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Actualizar industry en registros donde esté NULL usando valores no nulos de la misma empresa
SELECT t1.industry, t2. industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1. industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1. industry IS NULL
AND t2.industry IS NOT NULL;

-- Paso 5: Eliminación de filas y columnas innecesarias
-- Verificar los registros con valores nulos en total_laid_off y percentage_laid_off
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Eliminar los registros con valores nulos en total_laid_off y percentage_laid_off
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Verificar la tabla después de la eliminación
SELECT *
FROM layoffs_staging2;

-- Eliminar la columna row_num que ya no es necesaria
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Verificar la estructura final de la tabla de respaldo
SELECT *
FROM layoffs_staging2;







