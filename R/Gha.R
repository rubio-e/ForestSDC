#' Calculate Basal Area per Hectare (G/ha)
#'
#' This function calculates the basal area per hectare (\eqn{G/ha}) using the formula:
#' \deqn{G/ha = \frac{\sum g}{A} \times 10000}
#' where:
#' - \eqn{\sum g} is the sum of the basal area of individual trees.
#' - \eqn{A} is the plot area in square meters.
#' @md
#' @param x Numeric vector. A vector of tree diameters (e.g., in cm).
#' @param y Numeric. The plot area (e.g., in square meters).
#'
#' @return Numeric. The basal area per hectare (\eqn{G/ha}).
#'
#' @examples
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#' y <- 1000
#' Gha(x, y)
#'
#' @export
Gha <- function(x, y) {
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("Both 'x' and 'y' must be numeric.")
  }
  basal_area_sum <- sum(ForestSDC::g(x), na.rm = TRUE)
  basal_area_per_hectare <- (basal_area_sum * 10000) / y
  return(basal_area_per_hectare)
}
