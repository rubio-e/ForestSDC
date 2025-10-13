#' Calculate Species Richness (S)
#'
#' This function calculates species richness (\eqn{S}), which represents the
#' number of unique species or categories in the given data. The formula is:
#' \deqn{S = \sum I(counts > 0)}
#' where:
#' - \eqn{counts} represents the frequency of each unique species or category.
#' @md
#' @param sp Numeric or factor variable. A vector representing species or categories.
#'
#' @return Numeric. The species richness (\eqn{S}).
#'
#' @examples
#' x <- c("n", "m", "n", "n", "m")
#' rich(x)
#'
#' @export
rich <- function(sp) {
  x <- sp
  counts <- table(x)
  richness <- sum(counts > 0)
  return(richness)
}
