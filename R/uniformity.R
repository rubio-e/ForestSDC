#' @keywords internal
uniformity <- function(x, y) {
  nnss <- w_id(x, y)

  an <- angle5(x = x, y = y, data = nnss)

  dt <- data.frame()
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

    dt[i, 1] <- (aa + bb + cc + dd) * .25
  }

  colnames(dt) <- "Ui"
  dt
}
