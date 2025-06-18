#
# This function computes the direction of a vector.
#
# @param x numeric variable
#
# @param y  numeric variable
#
# @return Numeric variable.
#
# @examples
#
# angulo(2,2)
#
#' @keywords internal
angulo <- function(x, y) {
  angulo <- abs(atan(y / x) * 180 / pi)
  ifelse(y < 0 & x >= 0, angulo + 90,
    ifelse(y < 0 & x < 0, angulo + 180,
      ifelse(y >= 0 & x < 0, angulo + 270, abs(angulo - 90))
    )
  )
}
