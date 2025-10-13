#' Relative Value for the Species Profile Index A
#'
#' This function calculates the relative value of the Species Profile Index A,
#' which represents the observed species diversity in relation to the maximum
#' possible diversity for a given set of species. The relative value is expressed
#' as a percentage.
#'
#' @param h A numeric vector representing tree heights.
#' @param sp A character or factor vector representing species.
#'
#' @return A numeric value representing the relative Species Profile Index A (as a percentage).
#'
#' @examples
#'
#' data(pipse_azimuth)
#'
#' A_rel(h = pipse_azimuth$h, sp = pipse_azimuth$sp)
#'
#' @export
A_rel <- function(h, sp) {
  x <- h
  y <- sp
  A_rel_value <- (A_index(x, y) / A_max(y)) * 100
  return(A_rel_value)
}
