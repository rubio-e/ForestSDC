# ForestSDC  <a href='https://github.com/rubio-e/ForestSDC'><img src='man/figures/LOGO_FORESTSDC.png' align="right" width="200" /></a>

**ForestSDC**: *Forest stand Structure, tree Diversity, and species Composition*
<!-- badges: start -->
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/rubio-e/ForestSDC)
[![License: GPL (\>=3)](https://img.shields.io/badge/license-GPL%20(%3E=%203)-blue.svg)](https://github.com/covid19br/nowcaster/blob/main/LICENSE.md)
<!-- badges: end -->

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

### Simulación de una base de datos

Se crea una base de datos para un sitio circular de 1000 metros cuadrados.

```r
set.seed(42)
plot_radius <- 17.84124 # for a 1000 m2 plot
azi <- runif(100, min = 0, max = 360)
dis <- runif(100, min = 1, max = plot_radius)
df_xy <- coordxy(azi, dis, plot_radius*2)
sp <- factor(sample(c("Pinus", "Quercus", "Abies"), 100, replace = TRUE))
d <- runif(100, min = 7.5, max = 60)
h <- 5.4349 + d * 0.4219
plot <- rep("P01", 100)
dataP01 <- data.frame(plot, df_xy, sp, d, h)
head(dataP01)
```
### Explorar la base de datos simulados
```r
##   plot         x        y      sp        d         h
## 1  P01 21.250908 20.08736   Abies 32.75335 19.253538
## 2  P01 19.020675 16.81538   Abies 37.96331 21.451621
## 3  P01  8.622874 25.48756 Quercus 28.13321 17.304301
## 4  P01 15.565028 16.59728 Quercus 10.23341  9.752375
## 5  P01 22.247359 17.04060   Pinus 46.71001 25.141853
## 6  P01  9.034611 27.68094   Pinus 52.80422 27.712999
```

### Graficar la posición del arbolado utilizando las librerías `ggplot2`, `dplyr` y `ggforce`
```r
library(ggplot2)
library(dplyr)
library(ggforce)
dataP02 %>%
  ggplot()+
  labs(title = "Circular plot", caption = "Different color are given by the species")+
  geom_point(aes(x,y, color = sp))+
  geom_circle(aes(x0 = plot_radius, y0 = plot_radius, r = plot_radius)) +
  coord_fixed()+
  theme_bw()+
  theme_minimal()
```

```r
# Falta plot
```
### Uso de la función `nnss_circle()`: Parcelas circulares

Calcula índices espaciales para árboles dentro de una parcela circular.

```r
test002 <- nnss_circle(plot = plot, x = x, y = y, sp = sp, d = d, h = h, r = plot_radius, data = dataP02)
head(test002)
```

```r
## # A tibble: 6 × 13
## # Groups:   plot [1]
##   plot      x     y sp         d     h    Ui    Mi dDomi hDomi  dDif  hDif   NN1
##   <chr> <dbl> <dbl> <fct>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 P01    21.2  1.80 Abies   44.7  24.3  0.75  0.75  0.75  0.75 0.353 0.275     0
## 2 P01    16.2 16.5  Abies   14.3  11.5  0.5   1     0     0    0.462 0.338     1
## 3 P01    16.3 18.4  Querc…  31.4  18.7  0.25  0.75  0.25  0.25 0.276 0.210     1
## 4 P01    25.9 24.0  Pinus   35.9  20.6  0.5   0.5   1     1    0.492 0.362     1
## 5 P01    15.7 21.3  Pinus   12.0  10.5  0     0.75  0     0    0.688 0.521     1
## 6 P01    10.5 28.5  Abies   38.5  21.7  0.5   0.5   0.75  0.75 0.413 0.315     1
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

Este paquete está disponible bajo la licencia GPL >= 3.

## Cómo citar

> Rubio-Camacho, E. A. (2025). *ForestSDC: Forest stand Structure, tree Diversity and species Composition* (Version 0.1.0) [Software]. https://github.com/rubio-e/ForestSDC

---

> *ForestSDC permite análisis ecológicos y estructurales reproducibles en inventarios forestales, promoviendo el monitoreo de bosques sostenibles en distintas regiones del mundo.*
