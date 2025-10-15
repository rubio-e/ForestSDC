#' Individual Tree Crown Area
#'
#' This function calculates the crown area of an individual tree based on two
#' measurements of its crown diameters. The crown area is computed using the
#' average of the two diameters and is assumed to be circular.
#'
#' @param cw_a A numeric variable representing the first tree crown diameter in meters.
#' @param cw_b A numeric variable representing the second tree crown diameter in meters.
#'
#' @return A numeric variable representing the tree crown area in square meters.
#'
#' @examples
#' crown_area <- ca(10, 15)
#' crown_area # Output: Area in square meters
#'
#' @keywords internal
ca <- function(cw_a, cw_b) {
  x <- cw_a
  y <- cw_b
  xx <- (x + y) / 2 # Calculate the average crown diameter
  yy <- 0.7854 * (xx^2) # Calculate the crown area using the formula for the area of a circle
  return(yy) # Return the crown area
}
