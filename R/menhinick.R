#' Menhinick's Species Richness Index
#'
#' This function calculates Menhinick's species richness index, which is another measure
#' of species diversity in a given sample. The index is calculated using the following formula:
#'
#' \deqn{D = \frac{S}{\sqrt{N}}}
#'
#' where:
#' - \eqn{S} is the number of unique species in the sample,
#' - \eqn{N} is the total number of individuals in the sample.
#' @md
#' @param sp A numeric or factor variable representing the species or individuals
#'          in a sample.
#'
#' @return A numeric value representing Menhinick's species richness index.
#'
#' @examples
#' x <- c("P. patula", "A. religiosa", "A. religiosa", "Q. castanea", "P. patula")
#' menhinick(x)
#'
#' @export
menhinick <- function(sp) {
  x <- sp
  # Calculate the number of unique species
  num_species <- length(unique(x))

  # Calculate the total number of individuals
  total_individuals <- length(x)

  # Menhinick's index formula
  menhinick_index <- num_species / sqrt(total_individuals)

  return(menhinick_index)
}
