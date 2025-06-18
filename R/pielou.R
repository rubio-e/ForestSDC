#' Calculate Pielou's Equitativity Index
#'
#' This function calculates Pielou's equitativity index, which measures the evenness
#' of species distribution in a community. The formula is:
#' \deqn{J' = \frac{H'}{\log(S)}}
#' where:
#' - \eqn{H'} is the Shannon diversity index.
#' - \eqn{S} is the number of unique categories or species.
#' @md
#' @param x Numeric or factor variable. A vector representing species or categories.
#'
#' @return Numeric. The Pielou equitativity index.
#'
#' @examples
#' x <- c("n", "m", "n", "n", "m")
#' pielou(x)
#'
#' @export
pielou <- function(x) {
  unique_count <- length(unique(x))
  evenness <- shannon(x) / log(unique_count)
  return(evenness)
}
