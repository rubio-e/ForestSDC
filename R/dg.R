#' Calculate Quadratic Mean Diameter (QMD)
#'
#' This function calculates the quadratic mean diameter (QMD) of a set of tree diameters.
#' The QMD is a commonly used forestry measure to assess the average tree diameter
#' in a stand, weighted by the basal area of the trees. It is useful for understanding
#' stand structure and growth.
#'
#' The formula used is:
#' \deqn{QMD = \sqrt{\frac{\sum BA}{k \times n}}}
#' where:
#' - \eqn{\sum BA} is the sum of the basal areas of all trees.
#' - \eqn{k} is a constant factor for conversion.
#' - \eqn{n} is the number of trees.
#'
#' @param d Numeric vector. A vector of tree diameters (in centimeters).
#'
#' @return Numeric. The quadratic mean diameter (in centimeters).
#'
#' @examples
#' # Example tree diameters
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#'
#' # Calculate the quadratic mean diameter
#' dg(x)
#'
#' @export
dg <- function(d) {
  x <- d
  # Validate input
  if (!is.numeric(x)) {
    stop("'x' must be a numeric vector of tree diameters.")
  }

  if (length(x) == 0) {
    stop("'x' cannot be empty.")
  }

  # Calculate basal areas (using the assumed g() function for basal area)
  basal_areas <- ForestSDC::g(x)

  # Define the constant factor (k)
  k <- 0.0000785

  # Calculate the quadratic mean diameter (QMD)
  qmd <- sqrt(sum(basal_areas, na.rm = TRUE) / (k * length(x)))

  return(qmd)
}
