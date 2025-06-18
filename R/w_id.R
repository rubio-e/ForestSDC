# This function computes the distance between all the trees in the plot
#
# @param x numeric variable
#
# @param y  numeric variable
#
# @return Numeric variable.
#
# @examples
#
# x <- runif(100, min = 1, max = 99)
#
# y <- runif(100, min = 1, max = 99)
#
# nnss <- w_id(x, y)
#
# head(nnss)
#' @keywords internal
w_id <- function(x, y) {
  # mtx <- nnss_rcpp(x, y)
  # # mtx <- matrix(nrow = length(x),ncol = length(x))
  # # for (i in 1:length(x)) {
  # #   for (j in 1:length(x)) {
  # #     mtx[i,j] <- dista(x[i], y[i], x[j], y[j])
  # #   }
  # # }
  # colnames(mtx) <- 1:length(x)
  # rownames(mtx) <- 1:length(x)
  #
  # mtx.idTree <- matrix(nrow = length(mtx[, 1]), ncol = length(mtx[, 1]))
  # for (i in 1:length(mtx[, 1])) {
  #   mtx.idTree[i, ] <- names(mtx[, i][order(mtx[i, ])])
  # }
  # mtx <- mtx.idTree

  xx <- data.frame(x, y)
  yy <- FNN::get.knn(xx, k = 4, algo = "kd_tree")$nn.index
  zz <- cbind(c(1:length(yy[, 1])), yy)
  zz
}
