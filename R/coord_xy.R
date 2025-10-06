#' Convert azimuth and distance to XY coordinates
#'
#' This function transforms azimuth and distance values into Cartesian coordinates (x, y).
#' Useful for forestry, surveying, or spatial applications where polar measurements are common.
#'
#' @param azi Numeric vector of azimuth angles.
#' @param dis Numeric vector of distances, same length as \code{azi}.
#' @param r Optional numeric scalar for centering. If provided, coordinates will be shifted by \code{r/2}.
#' @param center Optional numeric vector of length 2 (\code{c(x0, y0)}) to shift the origin.
#'        Overrides \code{r} if both are provided.
#' @param deg Logical, whether the angles are in degrees (default = TRUE). If FALSE, assumed in radians.
#'
#' @return A \code{data.frame} with two columns: \code{x} and \code{y}.
#' @examples
#' # Example with degrees
#' coord_xy(azi = c(0, 90, 180), dis = c(10, 10, 10))
#'
#' # Example with radians
#' coord_xy(azi = c(0, pi/2, pi), dis = c(10, 10, 10), deg = FALSE)
#'
#' # Using center
#' coord_xy(azi = c(0, 90), dis = c(5, 5), center = c(2, 2))
#'
#' @export
coord_xy <- function(azi, dis, r = NULL, center = NULL, deg = TRUE) {
  stopifnot(length(azi) == length(dis))

  if (deg) {
    azi <- azi * pi / 180
  }

  x0 <- y0 <- 0

  if (!is.null(center)) {
    stopifnot(length(center) == 2)
    x0 <- center[1]
    y0 <- center[2]
  } else if (!is.null(r)) {
    x0 <- y0 <- r / 2
  }

  x <- x0 + dis * sin(azi)
  y <- y0 + dis * cos(azi)

  data.frame(x = x, y = y)
}
