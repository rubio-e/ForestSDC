# magnitud
#
# This function computes the magnitud of a vector.
#
# @param x numeric variable
#
# @param y  numeric variable
#
# @return Numeric variable.
#
# @examples
#
# magnitud(2,2)
#
#' @keywords internal
magnitud <- function(x, y) {
  xx <- sqrt(x^2 + y^2)
  xx
}
