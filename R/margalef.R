#' Margalef's Species Richness Index
#'
#' This function calculates Margalef's species richness index, which is an indicator
#' of the species richness in a given sample. The index is based on the number of
#' species and the total number of individuals. It is calculated using the following formula:
#'
#' \deqn{D = \frac{S - 1}{\log(N)}}
#'
#' where:
#' - \eqn{S} is the number of unique species in the sample,
#' - \eqn{N} is the total number of individuals in the sample.
#' @md
#' @param x A numeric or factor variable representing the species or individuals
#'          in a sample.
#'
#' @return A numeric value representing Margalef's species richness index.
#'
#' @examples
#' x <- c("P. patula", "A. religiosa", "A. religiosa", "Q. castanea", "P. patula")
#' margalef(x)
#'
#' @export
margalef <- function(x) {
  # Calculate the number of unique species
  num_species <- length(unique(x))

  # Calculate the total number of individuals
  total_individuals <- length(x)

  # Margalef's index formula
  mg_index <- (num_species - 1) / log(total_individuals)

  return(mg_index)
}
