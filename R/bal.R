#' Calculate Basal Area Larger Index (BAL)
#'
#' This function calculates the Basal Area Larger Index (BAL), which is the sum
#' of the basal area of trees larger than a given subject tree in a specified plot area.
#' It provides an index of competition based on tree size.
#'
#' The formula for each tree is:
#' \deqn{BAL_i = \frac{\sum (BA_j > BA_i)}{A}}
#' where:
#' - \eqn{BA_i} is the basal area of the subject tree.
#' - \eqn{BA_j} is the basal area of a competing tree larger than \eqn{BA_i}.
#' - \eqn{A} is the plot area in square meters.
#' @md
#' @param d Numeric vector. Diameters of the subject trees in cm.
#' @param ps Numeric. Plot area in square meters.
#'
#' @return Numeric vector. The BAL values for each tree in `x`.
#'
#' @examples
#'
#' data(pipse_azimuth)
#'
#' bal(d = pipse_azimuth$d, ps = 400)
#'
#' @export
bal <- function(d, ps) {
  x <- d
  y <- ps
  # Validate inputs
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("Both 'x' and 'y' must be numeric.")
  }

  # Calculate basal areas
  basal_areas <- ForestSDC::g(x) # Basal area calculation

  total_basal_area <- sum(basal_areas, na.rm = TRUE) # Total basal area
  bal_values <- numeric(length(basal_areas)) # Initialize BAL vector

  # Calculate BAL for each tree
  for (i in seq_along(basal_areas)) {
    current_basal_area <- basal_areas[i]
    larger_basal_area_sum <- sum(basal_areas[basal_areas > current_basal_area], na.rm = TRUE)
    bal_values[i] <- larger_basal_area_sum / y # BAL normalized by plot area
  }

  return(bal_values)
}
