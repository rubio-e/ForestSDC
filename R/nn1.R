# This function uses the NN1 (border effect) rules to indicate if a tree can be used as a reference.
#
# @param x numeric variable: x coordinates of the reference tree
#
# @param y  numeric variable: y coordinates of the reference tree
#
# @param z numeric variable: subject tree
#
# @param xmax numeric variable: max value of the x coordinate of the entire plot
#
# @param ymax  numeric variable: max value of the x coordinate of the entire plot
#
# @return Numeric variable.
#
# @examples
#
# nn1(50,20,10,100,100)
#
#' @keywords internal
nn1 <- function(x, y, z, xmax, ymax) {
  ifelse(z > x | z > y | (xmax - x) < z | (ymax - y) < z, 0, 1)
}
