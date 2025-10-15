#' Hill's number for q1
#'
#' This function calculates exp value for the Shannon's entropy index (\eqn{H'}) for a given dataset.
#'
#' The formula is:
#' \deqn{q1 = exp(- \sum_{i=1}^S p_i \log(p_i))}
#'
#' Where:
#' - \eqn{p_i} is the proportion of individuals belonging to the \eqn{i}-th category.
#' - \eqn{S} is the total number of unique categories in the dataset.
#' @md
#' @param sp A numeric or factor vector representing categories (e.g., species or groups).
#'
#' @return A numeric value representing Hill's number for q1 index.
#'
#' @examples
#' x <- c("n", "m", "n", "n", "m")
#' q1(x)
#'
#' @export
q1 <- function(sp) {
    return(exp(shannon(sp)))
}
