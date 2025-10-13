#' Number of Trees per Hectare
#'
#' This function calculates the number of trees per hectare based on the total
#' number of trees in a given plot area. The index is calculated using the following formula:
#'
#' \deqn{N = \frac{N_{\text{trees}} \times 10000}{A}}
#'
#' where:
#' - \eqn{N_{\text{trees}}} is the total number of trees in the sample,
#' - \eqn{A} is the plot area in square meters.
#' @md
#' @param d A numeric or character vector representing tree diameter or other tree attribute.
#' @param ps A numeric variable representing the plot area in square meters.
#'
#' @return A numeric value representing the number of trees per hectare.
#'
#' @examples
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#' y <- 1000
#' Nha(x, y)
#'
#' @export
Nha <- function(d, ps) {
  x <- d
  y <- ps
  # Calculate the total number of trees in the plot
  num_trees <- length(x)

  # Number of trees per hectare formula
  Nha <- (num_trees * 10000) / y

  return(Nha)
}
