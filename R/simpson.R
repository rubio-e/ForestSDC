#' Simpson's index.
#'
#' @param x Numeric or factor variable
#'
#' @return Numeric variable.
#'
#' @examples
#'
#' x <- c("n", "m", "n", "n", "m")
#'
#' simpson(x)
#' @export
simpson <- function(x) {
  y <- table(x)
  xx <- y / sum(y)
  xy <- sum(xx^2, na.rm = T)
  return(xy)
}
