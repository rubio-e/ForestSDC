# nn1_5
#
# This function computes the nn1 border effect
#
# @param x numeric variable: x coordinates
#
# @param y numeric variable: y coordinates
#
# @param data factor data.frame: wId object
#
# @param r radius of the plot
#
# @return data.frame
#
# @examples
#
# x <- runif(100, min = 1, max = 99)
#
# y <- runif(100, min = 1, max = 99)
#
# require(forestAnalytics)
#
# nnss <- w_id(x, y)
#
# nn1_5(x = x, y = y, data = nnss, 50)
#
#' @keywords internal
nn1_5q <- function(x, y, data, xmax, ymax) {
  t5 <- apply(data[, 1:5], 2, as.numeric)
  nn1 <- nn1q(x[t5[, 1]], y[t5[, 1]], x[t5[, 5]], y[t5[, 5]], xmax, ymax)
  nn1
}
