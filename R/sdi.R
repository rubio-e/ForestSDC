#' Calculate Stand Density Index (SDI)
#'
#' This function calculates the Stand Density Index (SDI) using the formula:
#' \deqn{SDI = Nha \times \left(\frac{dg}{25.4}\right)^{1.605}}
#' where:
#' - \eqn{Nha} is the number of trees per hectare.
#' - \eqn{dg} is the quadratic mean diameter (in cm).
#' @md
#' @param d Numeric vector. A vector of tree diameters (e.g., in cm).
#' @param ps Numeric. The plot area (e.g., in square meters).
#'
#' @return Numeric. The stand density index.
#'
#' @examples
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#' y <- 1000
#' sdi(x, y)
#'
#' @export
sdi <- function(d, ps) {
  x <- d
  y <- ps
  Nha(x, y) * (dg(x) / 25.4)^1.605
}
