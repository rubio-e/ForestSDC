#' Simpson's Index Complement
#'
#' This function calculates the complement of Simpson's index (\eqn{D'}), a diversity measure
#' that represents the probability of two randomly selected individuals belonging to
#' different categories.
#'
#' The formula is:
#' \deqn{D' = 1 - \sum_{i=1}^S p_i^2}
#'
#' Where:
#' - \eqn{p_i} is the proportion of individuals in the \eqn{i}-th category,
#' - \eqn{S} is the total number of categories.
#' @md
#' @param sp A numeric or factor vector representing categories (e.g., species or groups).
#'
#' @return A numeric value representing the complement of Simpson's index (\eqn{D'}).
#'
#' @examples
#' x <- c("n", "m", "n", "n", "m")
#' simpson_complement(x)
#'
#' @export
simpson_complement <- function(sp) {
  x <- sp
  # Calculate the frequency of each category
  y <- table(x)

  # Calculate proportions of each category
  xx <- y / sum(y)

  # Calculate Simpson's index complement
  yy <- sum(xx^2, na.rm = TRUE)
  xy <- 1 - yy

  return(xy)
}
