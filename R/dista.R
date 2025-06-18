#' Compute the Distance between Two Points
#'
#' This function calculates the Euclidean distance between two points in a 2D space.
#' The distance is computed using the formula:
#' \deqn{d = \sqrt{(x1 - x)^2 + (y1 - y)^2}}
#' where \eqn{(x, y)} and \eqn{(x1, y1)} are the coordinates of the two points.
#'
#' @param x Numeric. The x-coordinate of the first point.
#' @param y Numeric. The y-coordinate of the first point.
#' @param x1 Numeric. The x-coordinate of the second point.
#' @param y1 Numeric. The y-coordinate of the second point.
#'
#' @return Numeric. The Euclidean distance between the two points.
#'
#' @examples
#' # Calculate the distance between points (5, 5) and (4, 4)
#' dista(5, 5, 4, 4)
#'
#' @export
dista <- function(x, y, x1, y1) {
  # Validate inputs
  if (!is.numeric(c(x, y, x1, y1))) {
    stop("All inputs must be numeric.")
  }

  # Compute the differences in coordinates
  xz <- x1 - x
  yz <- y1 - y

  # Calculate and return the Euclidean distance
  dist <- sqrt(xz^2 + yz^2)
  return(dist)
}
