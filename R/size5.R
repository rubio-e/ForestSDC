# This function gives the size of the five nearest neighbours
#
# @param x numeric variable: x coordinates
#
# @param y numeric variable: y coordinates
#
# @param size numeric variable: any variable related to the tree size i.e. diameter
#
# @param data factor data.frame: wId object
#
# @return factor data.frame variable:
#
# @examples
#
# x <- runif(100, min = 1, max = 99)
#
# y <- runif(100, min = 1, max = 99)
#
# require(forstr)
#
# nnss <- w_id(x, y)
#
# d <- runif(100, min = 7.5, max = 40)
#
# size5(x = x, y = y, size = d, data = nnss)
#' @keywords internal
size5 <- function(x, y, size, data) {
  t5 <- apply(data[, 1:5], 2, as.numeric)
  s1 <- size[t5[, 1]]
  s2 <- size[t5[, 2]]
  s3 <- size[t5[, 3]]
  s4 <- size[t5[, 4]]
  s5 <- size[t5[, 5]]
  data.frame(s1, s2, s3, s4, s5)
}
