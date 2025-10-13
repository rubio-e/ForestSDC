#' Maximum Value for the Species Profile Index A
#'
#' This function calculates the maximum possible value of the Species Profile Index A,
#' based on the number of distinct species present. It assumes that each species is equally distributed
#' across the three height zones.
#' @md
#' @param sp A character or factor vector representing species.
#'
#' @return A numeric value representing the maximum possible Species Profile Index A.
#'
#' @examples
#'
#' #' data(pipse_azimuth)
#'
#' A_max(sp = pipse_azimuth$sp)
#'
#' @export
A_max <- function(sp) {
  x <- sp
  # Calculate the maximum possible A_index based on species richness
  species_richness <- length(unique(x))
  A_max_value <- log(species_richness * 3)
  return(A_max_value)
}
