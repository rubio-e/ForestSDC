# This function computes the angle between two points in the space.
#
# @param x numeric variable
#
# @param y  numeric variable
#
# @param x1 numeric variable
#
# @param y1  numeric variable
#
# @return numeric variable
#
# @examples
#
# angulo_a(5,5,4,4)
#
#' @keywords internal
angulo_a <- function(x, y, x1, y1) {
  xx <- x1 - x
  yy <- y1 - y
  z <- angulo(xx, yy)
  return(z)
}
