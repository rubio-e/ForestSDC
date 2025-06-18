# This function gives the size of the five nearest neighbours
#
# @param x numeric variable: x coordinates
#
# @param y numeric variable: y coordinates
#
# @param d numeric variable: tree diameter
#
# @param h numeric variable: tree height
#
# @param sp factor variable: species
#
# @param r numeric variable: radious of the circle plot
#
# @return data.frame
#
#
#
# x <- runif(100,  min = 1,  max = 99)
#
# y <- runif(100,  min = 1,  max = 99)
#
# sp <- matrix(c("pinus", "quercus"),  ncol = 1,  nrow = 100)
#
# d <- runif(100,  min = 7.5,  max = 60)
#
# h <- runif(100,  min = 2,  max = 40)
#
# nnss5(x = x,  y = y,  sp = sp[, 1],  d = d,  h = h,  r=50)
#
#' @keywords internal
nnss5 <- function(x, y, sp, d, h, r) {
  nnss <- w_id(x, y)
  # Uniformity index
  an <- angle5(x = x, y = y, data = nnss)
  Ui <- data.frame()
  for (i in 1:length(an[, 1])) {
    xx <- sort(an[i, ], T)
    a <- (360 - xx[1]) + xx[2]
    b <- xx[1] - xx[2]
    aa <- winkel(ifelse(a < b, a, b))

    a <- (360 - xx[2]) + xx[3]
    b <- xx[2] - xx[3]
    bb <- winkel(ifelse(a < b, a, b))

    a <- (360 - xx[3]) + xx[4]
    b <- xx[3] - xx[4]
    cc <- winkel(ifelse(a < b, a, b))

    a <- (360 - xx[1]) + xx[4]
    b <- xx[1] - xx[4]
    dd <- winkel(ifelse(a < b, a, b))

    Ui[i, 1] <- (aa + bb + cc + dd) * .25
  }
  colnames(Ui) <- "Ui"
  Ui
  # Species mixture index
  sp_mix <- sp_mix_5(x = x, y = x, sp = sp, data = nnss)
  E2 <- ifelse(sp_mix$s1 == sp_mix$s2, 0, 1)
  E3 <- ifelse(sp_mix$s1 == sp_mix$s3, 0, 1)
  E4 <- ifelse(sp_mix$s1 == sp_mix$s4, 0, 1)
  E5 <- ifelse(sp_mix$s1 == sp_mix$s5, 0, 1)
  Mi <- (E2 + E3 + E4 + E5) * .25

  # Diamater Dominance
  dSize <- size5(x = x, y = x, size = d, data = nnss)
  E2 <- ifelse(dSize$s1 > dSize$s2, 1, 0)
  E3 <- ifelse(dSize$s1 > dSize$s3, 1, 0)
  E4 <- ifelse(dSize$s1 > dSize$s4, 1, 0)
  E5 <- ifelse(dSize$s1 > dSize$s5, 1, 0)
  dDomi <- (E2 + E3 + E4 + E5) * .25

  # Heigth Dominance
  hSize <- size5(x = x, y = x, size = h, data = nnss)
  E2 <- ifelse(hSize$s1 > hSize$s2, 1, 0)
  E3 <- ifelse(hSize$s1 > hSize$s3, 1, 0)
  E4 <- ifelse(hSize$s1 > hSize$s4, 1, 0)
  E5 <- ifelse(hSize$s1 > hSize$s5, 1, 0)
  hDomi <- (E2 + E3 + E4 + E5) * .25

  # Diameter Differentiation
  E2 <- apply(dSize[, c(1, 2)], 1, min) / apply(dSize[, c(1, 2)], 1, max)
  E3 <- apply(dSize[, c(1, 3)], 1, min) / apply(dSize[, c(1, 3)], 1, max)
  E4 <- apply(dSize[, c(1, 4)], 1, min) / apply(dSize[, c(1, 4)], 1, max)
  E5 <- apply(dSize[, c(1, 5)], 1, min) / apply(dSize[, c(1, 5)], 1, max)
  dDif <- 1 - ((E2 + E3 + E4 + E5) * .25)

  # Heigth Differentiation
  E2 <- apply(hSize[, c(1, 2)], 1, min) / apply(hSize[, c(1, 2)], 1, max)
  E3 <- apply(hSize[, c(1, 3)], 1, min) / apply(hSize[, c(1, 3)], 1, max)
  E4 <- apply(hSize[, c(1, 4)], 1, min) / apply(hSize[, c(1, 4)], 1, max)
  E5 <- apply(hSize[, c(1, 5)], 1, min) / apply(hSize[, c(1, 5)], 1, max)
  hDif <- 1 - ((E2 + E3 + E4 + E5) * .25)

  # NN1 border effect
  nn1 <- nn1_5(x = x, y = y, data = nnss, r)

  data.frame(Ui, Mi, dDomi, hDomi, dDif, hDif, nn1)
}
