#' Shannon's Entropy Index
#'
#' This function calculates Shannon's entropy index (\eqn{H'}) for a given dataset.
#' Shannon's entropy index measures the diversity in the dataset, considering both
#' the richness (number of unique categories) and evenness (distribution of individuals).
#'
#' The formula is:
#' \deqn{H' = - \sum_{i=1}^S p_i \log(p_i)}
#'
#' Where:
#' - \eqn{p_i} is the proportion of individuals belonging to the \eqn{i}-th category.
#' - \eqn{S} is the total number of unique categories in the dataset.
#' @md
#' @param sp A numeric or factor vector representing categories (e.g., species or groups).
#'
#' @return A numeric value representing Shannon's entropy index (\eqn{H'}).
#'
#' @examples
#' x <- c("n", "m", "n", "n", "m")
#' shannon(x)
#'
#' @export
shannon <- function(sp) {
  x <- sp
  # Calculate the frequency of each category
  y <- table(x)

  # Calculate proportions of each category
  xx <- y / sum(y)

  # Shannon's entropy index formula
  h <- -sum(xx * log(xx), na.rm = TRUE)

  return(h)
}
