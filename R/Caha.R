#' Calculate Crown Area Cover per Hectare
#'
#' This function calculates the total crown area cover per hectare based on
#' the tree crown diameters provided. It computes the crown area for each tree
#' as the area of a circle using the formula:
#' \deqn{A = \pi \times \left(\frac{cw}{2}\right)^2}
#' where \eqn{cw} is the crown diameter in m.
#' The total crown area is then scaled to a per-hectare value using the specified plot area.
#'
#' @param cw Numeric vector. Tree crown diameters (in meters).
#' @param ps Numeric. Total plot area (in square meters).
#'
#' @return Numeric. Crown area cover per hectare (in square meters).
#'
#' @examples
#' # Example crown diameters and plot area
#' x <- c(10, 8, 6, 8, 5, 7, 2, 3, 11, 10)
#'
#' # Calculate crown area cover per hectare
#' Caha(x, 400)
#'
#' @export
Caha <- function(cw, ps) {
  x <- cw
  y <- ps
  # Validate inputs
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("Both 'x' and 'y' must be numeric.")
  }
  if (y <= 0) {
    stop("Plot area 'y' must be greater than 0.")
  }

  # Calculate total crown area (sum of circular areas of each tree)
  total_crown_area <- sum(pi * (x / 2)^2, na.rm = TRUE)

  # Calculate crown area cover per hectare
  crown_area_per_hectare <- (total_crown_area * 10000) / y

  return(crown_area_per_hectare)
}
