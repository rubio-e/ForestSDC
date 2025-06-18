#' Calculate Coordinates from Azimuth and Distance
#'
#' This function calculates the Cartesian coordinates (x, y) based on a given azimuth
#' angle and distance from a reference point. The function can be used for both circular
#' and square plots, where the size of the plot is specified by the diameter (for circles)
#' or the side length (for squares).
#'
#' @param azi Numeric variable. Azimuth angle in degrees (0-360).
#' @param dis Numeric variable. Distance from the reference point (in the same unit as z).
#' @param z Numeric variable. Diameter of the circle or side length of the square plot.
#'
#' @return A numeric vector containing the calculated coordinates (x, y).
#'
#' @examples
#' # Calculate coordinates for an azimuth of 350 degrees and a distance of 15 units
#' coordxy(350, 15, 20)
#'
#' @export
coordxy <- function(azi, dis, z) {
  # Define the center based on the plot size
  center <- z / 2

  # Calculate the x and y coordinates
  x <- sin(azi * (pi / 180)) * dis + center
  y <- cos(azi * (pi / 180)) * dis + center

  # Combine the coordinates into a matrix
  xy <- cbind(x = x, y = y)

  return(xy)
}
