# This function gives the species names of the five nearest neighbours
#
# @param x numeric variable: x coordinates
#
# @param y numeric variable: y coordinates
#
# @param sp factor variable: species
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
# m <- matrix(c("pinus", "quercus"), ncol = 1, nrow = 100)
#
# sp_mix_5(x = x, y = y, sp = m[, 1], data = nnss)
#' @keywords internal
sp_mix_5 <- function(x, y, sp, data) {
  t5 <- apply(data[, 1:5], 2, as.numeric)
  s1 <- sp[t5[, 1]]
  s2 <- sp[t5[, 2]]
  s3 <- sp[t5[, 3]]
  s4 <- sp[t5[, 4]]
  s5 <- sp[t5[, 5]]
  data.frame(s1, s2, s3, s4, s5)
}
