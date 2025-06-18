# ForestSDC

**ForestSDC**: *Forest stand Structure, tree Diversity and species Composition*

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/rubio-e/ForestSDC)

## Descripción

**ForestSDC** es un paquete de R diseñado para facilitar el análisis de inventarios forestales y parcelas permanentes de investigación. Incluye herramientas para calcular índices estructurales, métricas de biodiversidad y estadísticas de vecinos más cercanos, apoyando investigaciones sobre dinámica forestal, salud del ecosistema y diversidad biológica.

## Características principales

- Cálculo de índices de diversidad (Shannon, Simpson, Margalef, Menhinick, Pielou, etc.).
- Análisis estructural: área basal, altura dominante, densidad de arbolado, índice BAL y BALMOD.
- Cálculo de índices espaciales con vecinos más cercanos en parcelas circulares (`nnss_circle`) y cuadradas (`nnss_square`).
- Clasificación de árboles dominantes y distribución diamétrica.

## Instalación

```r
# Instala devtools si no lo tienes
install.packages("devtools")

# Instala ForestSDC desde GitHub
devtools::install_github("rubio-e/ForestSDC")
```

## Uso básico

```r
library(ForestSDC)

# Cálculo del índice de Shannon
especies <- c("P. patula", "A. religiosa", "P. patula", "Q. castanea")
shannon(especies)
```

---

## 📊 Funciones destacadas: Análisis de Vecinos más Cercanos

### `nnss_circle()`: Parcelas circulares

Calcula índices espaciales para árboles dentro de una parcela circular.

```r
set.seed(42)

data_circle <- data.frame(
  plot = rep("P01", 100),
  x = runif(100, 0, 99),
  y = runif(100, 0, 99),
  sp = sample(c("Pinus", "Quercus"), 100, replace = TRUE),
  d = runif(100, 10, 40),
  h = runif(100, 5, 30)
)

result_circle <- nnss_circle(
  plot = plot,
  x = x,
  y = y,
  sp = sp,
  d = d,
  h = h,
  r = 50,
  data = data_circle
)

head(result_circle)
```

### `nnss_square()`: Parcelas cuadradas

```r
set.seed(42)

data_square <- data.frame(
  plot = rep("P02", 100),
  x = runif(100, 0, 50),
  y = runif(100, 0, 50),
  sp = sample(c("Pinus", "Quercus"), 100, replace = TRUE),
  d = runif(100, 7.5, 60),
  h = runif(100, 2, 40)
)

result_square <- nnss_square(
  plot = plot,
  x = x,
  y = y,
  sp = sp,
  d = d,
  h = h,
  xmax = 50,
  ymax = 50,
  data = data_square
)

head(result_square)
```

---

## 📈 Ejemplos adicionales

### `A_index()`: Índice de perfil de especies

```r
x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
y <- c("P. patula", "P. patula", "P. patula", "A. religiosa", "Q. castanea",
       "P. patula", "P. patula", "P. patula", "P. patula", "P. patula")
A_index(x, y)
```

### `shannon()`: Índice de Shannon

```r
species <- c("P. patula", "A. religiosa", "A. religiosa", "Q. castanea", "P. patula")
shannon(species)
```

---

## Dependencias

- `dplyr`
- `tidyr`
- `FNN`

## Autor

**Ernesto Rubio**  
📧 ernestorub@gmail.com

## Licencia

Este paquete está disponible bajo la licencia MIT.

## Cómo citar

> Rubio-Camacho, E. A. (2025). *ForestSDC: Forest stand Structure, tree Diversity and species Composition* (Version 0.1.0) [Software]. https://github.com/rubio-e/ForestSDC

---

> *ForestSDC permite análisis ecológicos y estructurales reproducibles en inventarios forestales, promoviendo el monitoreo de bosques sostenibles en distintas regiones del mundo.*
