#' Shannon's Evenness Index
#'
#' This function calculates Shannon's evenness index, which measures the
#' evenness of the distribution of species (or any type of data) in a community.
#' The formula used is:
#'
#' \deqn{E_H = \frac{H'}{H_{\text{max}}}}
#'
#' where:
#' - \eqn{H'} is the Shannon diversity index:
#'   \deqn{H' = - \sum p_i \log(p_i)}
#'   with \eqn{p_i} being the proportion of individuals of species \eqn{i}.
#' - \eqn{H_{\text{max}}} is the maximum Shannon index for a given number of unique species \eqn{S},
#'   and is given by \eqn{H_{\text{max}} = \log(S)}.
#' @md
#' @param x A numeric or factor vector representing species or groups in the community.
#'
#' @return A numeric value representing Shannon's evenness index, which ranges from 0 (uneven) to 1 (perfectly even).
#'
#' @examples
#' x <- c("n", "m", "n", "n", "m")
#' shannon_evenness(x)
#'
#' @export
shannon_evenness <- function(x) {
  # Calculate the relative abundance (proportion) of each category
  y <- table(x)
  yy <- y / sum(y) # Proportions of each category

  # Shannon diversity index
  h <- (-1) * sum(yy * log(yy), na.rm = TRUE)

  # Maximum possible Shannon index (when all species are equally abundant)
  xx <- sum(table(unique(x))) # Total number of unique species (S)
  hx <- h / log(xx) # Evenness index

  return(hx)
}
