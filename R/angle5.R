# This function computes the angle of all neighbors from the reference tree
#
# @param x numeric variable
#
# @param y  numeric variable
#
# @param data matrix of the w_id object
#
# @return numeric matrix with the angles
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
# angle5(x, y, data = nnss)
#' @keywords internal
angle5 <- function(x, y, data) {
  t5 <- apply(data[, 1:5], 2, as.numeric)

  mtx <- matrix(nrow = length(t5[, 1]), ncol = length(t5[1, ]))

  for (i in 1:length(mtx[, 1])) {
    for (j in 1:length(mtx[1, ])) {
      mtx[i, j] <- angulo_a(x[t5[i]], y[t5[i]], x[t5[i, j]], y[t5[i, j]])
    }
  }

  return(mtx)
}
