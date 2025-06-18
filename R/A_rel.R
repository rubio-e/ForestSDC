#' Relative Value for the Species Profile Index A
#'
#' This function calculates the relative value of the Species Profile Index A,
#' which represents the observed species diversity in relation to the maximum
#' possible diversity for a given set of species. The relative value is expressed
#' as a percentage.
#'
#' @param x A numeric vector representing tree heights.
#' @param y A character or factor vector representing species.
#'
#' @return A numeric value representing the relative Species Profile Index A (as a percentage).
#'
#' @examples
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#' y <- c(
#'   "P. patula", "P. patula", "P. patula", "A. religiosa",
#'   "Q. castanea", "P. patula", "P. patula", "P. patula",
#'   "P. patula", "P. patula"
#' )
#' A_rel(x, y)
#'
#' @export
A_rel <- function(x, y) {
  A_rel_value <- (A_index(x, y) / A_max(y)) * 100
  return(A_rel_value)
}
