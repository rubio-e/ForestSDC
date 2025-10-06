# ForestSDC  <a href='https://github.com/rubio-e/ForestSDC'><img src='man/figures/LOGO_FORESTSDC.png' align="right" width="200" /></a>

**ForestSDC**: *Forest stand Structure, tree Diversity, and species Composition*
<!-- badges: start -->
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/rubio-e/ForestSDC)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.md)
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

## Uso básico de ForestSDC
La librería cuenta con bases de datos reales que pueden ser utilizados para practicar.

```r
library(ForestSDC)
# Cálculo del índice de Shannon
library(ForestSDC)
data("pipse_azimuth")
head(pipse_azimuth)
```

### Diversidad de especies
El cálculo de índices de diversidad en sitios individuales se puede llevar a cabo siguiendo el estándar de la programación en R. Por ejemplo, para calcular el índice de entropía de Shannon se puede utilizar la función `shannon`.
```r
shannon(pipse_azimuth$sp)
[1] 1.542215
```

Este procedimiendo se puede seguir para los otros índices como el de `Simpson` o `Margalef`.
```r
margalef(pipse_azimuth$sp)
[1] 1.737178

simpson(pipse_azimuth$sp)
[1] 0.2862
```



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
##   plot         x         y      sp        d        h
## 1  P01  8.639807 15.400107   Abies 19.15307 13.51558
## 2  P01 24.425945  1.899083   Abies 33.14083 19.41702
## 3  P01 28.918045 21.439935   Abies 13.64687 11.19251
## 4  P01 16.712357 17.962755   Abies 23.23114 15.23612
## 5  P01 17.724337 16.430860 Quercus 32.92668 19.32667
## 6  P01 22.147076 32.765615   Abies 50.71430 26.83126
```

### Graficar la posición del arbolado utilizando las librerías `ggplot2`, `dplyr` y `ggforce`
```r
library(ggplot2)
library(dplyr)
library(ggforce)
dataP01 %>%
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
test001 <- nnss_circle(plot = plot, x = x, y = y, sp = sp, d = d, h = h, r = plot_radius, data = dataP01)
head(test001)
```

```r
## # A tibble: 6 × 13
## # Groups:   plot [1]
##   plot      x     y sp         d     h    Ui    Mi dDomi hDomi  dDif  hDif   NN1
##   <chr> <dbl> <dbl> <fct>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 P01    8.64 15.4  Abies   19.2  13.5  0.5   0.75  0     0    0.354 0.261     1
## 2 P01   24.4   1.90 Abies   33.1  19.4  0.75  0.5   0.75  0.75 0.422 0.306     0
## 3 P01   28.9  21.4  Abies   13.6  11.2  0.75  0.75  0     0    0.533 0.393     0
## 4 P01   16.7  18.0  Abies   23.2  15.2  0.5   0.5   0     0    0.410 0.317     1
## 5 P01   17.7  16.4  Querc…  32.9  19.3  0.5   0.5   0.75  0.75 0.223 0.169     1
## 6 P01   22.1  32.8  Abies   50.7  26.8  0.5   0.5   0.75  0.75 0.463 0.369     0
```

### `nnss_square()`: Parcelas cuadradas
```{r}
ntrees <- 200
x <- runif(ntrees, min = 1, max = 50)
y <- runif(ntrees, min = 1, max = 50)
sp <- factor(sample(c("Pinus", "Quercus", "Abies"), 100, replace = TRUE))
d <- runif(ntrees, min = 7.5, max = 60)
h <- 5.4349 + d * 0.4219
plot <- rep("P02", ntrees)
dataP02 <- data.frame(plot, x, y, sp, d, h)
test002 <-nnss_square(plot = plot, x = x, y = y, sp = sp, d = d, h = h, xmax = 50, ymax = 50, data = dataP02)
head(test002)
```
```{r}
## # A tibble: 6 × 13
## # Groups:   plot [1]
##   plot      x     y sp         d     h    Ui    Mi dDomi hDomi  dDif  hDif   NN1
##   <chr> <dbl> <dbl> <fct>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 P02    39.0 45.5  Querc…  7.68  8.67  0.5   0.5   0     0    0.724 0.502     1
## 2 P02    10.8 17.3  Querc… 17.2  12.7   0.25  0.75  0.5   0.5  0.443 0.338     1
## 3 P02    15.6 10.3  Abies   8.84  9.17  0.5   1     0     0    0.730 0.537     1
## 4 P02    49.3 21.8  Abies  18.0  13.0   0.5   0.25  0     0    0.497 0.381     0
## 5 P02    11.6  4.54 Querc… 25.7  16.3   0.5   0.75  0.25  0.25 0.223 0.160     0
## 6 P02    41.9 47.1  Abies  27.8  17.2   0.25  1     0.75  0.75 0.399 0.275     0
```

```{r}
test002$NN1 <- as.factor(test002$NN1)
test002 %>%
  ggplot()+
  geom_point(aes(x,y, color = NN1))+
  geom_rect(aes(xmin = 5, xmax = 45, ymin = 5, ymax = 45), color="black", alpha=0)+
  geom_rect(aes(xmin = 0, xmax = 50, ymin = 0, ymax = 50), color="black", alpha=0)+
  coord_fixed()+
  theme_minimal()
```

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
