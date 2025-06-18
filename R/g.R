#' Basal Area from Tree Diameter
#'
#' This function calculates the basal area of a tree based on its diameter at breast height (DBH).
#' The formula used is \eqn{g = \frac{\pi}{4} \times \left(\frac{d}{100}\right)^2},
#' where d is the diameter in centimeters.
#' @md
#'
#' @param x Numeric variable. Tree diameter in centimeters.
#'
#' @return Numeric variable. Basal area in square meters.
#'
#' @examples
#'
#' x <- 25
#' g(x) # Calculates the basal area for a tree with a 25 cm diameter.
#' @export
g <- function(x) {
  xx <- 0.7854 * ((x / 100)^2)
  xx
}
