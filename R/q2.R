#' Hill's number for q2 based on the Simpson's index.
#'
#' @param sp Numeric or factor variable
#'
#' @return Numeric variable.
#'
#' @examples
#'
#' x <- c("n", "m", "n", "n", "m")
#'
#' q2(x)
#'
#' @export
q2 <- function(sp) {
  return(1/simpson(sp))
}
