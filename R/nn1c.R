# This function uses the NN1 (border effect) rules to indicate if a tree can be used as a reference used only in circles.
#
# @param x numeric variable: x coordinates of the reference tree
#
# @param y  numeric variable: y coordinates of the reference tree
#
# @param x1 numeric variable: y coordinate of the subject tree
#
# @param y1 numeric variable: y coordinate of the subject tree
#
# @param r  numeric variable: radious of the plot
#
# @return Numeric variable
#
# @examples
#
# nn1c(2,2,4,3,5)
#
#' @keywords internal
nn1c <- function(x, y, x1, y1, r) {
  xx <- dista(x, y, x1, y1) # distance between the first and the last tree
  yy <- dista(x, y, r, r) # distance between the first tree and the center of the plot
  z <- r - yy # distance of the first tree to the edge of the plot
  nn1 <- ifelse(z >= xx, 1, 0) # i 1 = the tree can be used as a reference tree
  nn1
}
