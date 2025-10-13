#' Species Profile Index A
#'
#' This function calculates the Species Profile Index A, which measures species diversity
#' across three height zones:
#' - Zone 1: Trees with heights >= 80% of the maximum height.
#' - Zone 2: Trees with heights between 50% and 80% of the maximum height.
#' - Zone 3: Trees with heights < 50% of the maximum height.
#'
#'#' For each zone, the species proportions are used to compute a diversity profile index:
#' \deqn{PI = \sum_{i=1}^{S} |p_i \cdot \ln(p_i)|}
#'
#' Where:
#' - \eqn{S} is the total number of species in the zone.
#' - \eqn{p_i} is the proportion of the \eqn{i}-th species in the zone.
#'
#' The Species Profile Index A is the sum of the profile indices across all three zones:
#' \deqn{A = PI_1 + PI_2 + PI_3}
#' @references
#' Pretzsch, H. (2009). Forest Dynamics, Growth and Yield: From Measurement to Model. Springer-Verlag. https://doi.org/10.1007/978-3-540-88307-4
#' @md
#' @param x A numeric vector representing tree heights.
#' @param y A character or factor vector representing species corresponding to each tree height.
#' @return A numeric value representing the Species Profile Index A.
#'
#' @examples
#'
#' data(pipse_azimuth)
#'
#' A_index(x = pipse_azimuth$h, y = pipse_azimuth$sp)
#'
#' @export
A_index <- function(x, y) {
  # Normalize heights to percentage of the maximum height
  hmax <- (x / max(x)) * 100
  hmax_df <- data.frame(species = y, height = x, hmax = hmax)

  # Sort by height in descending order
  hmax_sorted <- hmax_df[order(-hmax_df$hmax), ]

  # Function to calculate profile index for a given height zone
  calculate_profile_index <- function(data) {
    if (nrow(data) == 0) {
      return(0)
    } # Return 0 if no data in the zone
    species_freq <- table(data$species) # Frequency table of species
    prop <- species_freq / sum(species_freq) # Proportion of species
    pi_values <- prop * log(prop) # Profile index calculation
    return(sum(abs(pi_values))) # Return sum of profile index values
  }

  # Split into three zones based on height
  z1 <- subset(hmax_sorted, hmax >= 80) # Trees with height ≥ 80% of max
  z2 <- subset(hmax_sorted, hmax < 80 & hmax >= 50) # Trees between 50-80% of max
  z3 <- subset(hmax_sorted, hmax < 50) # Trees < 50% of max height

  # Calculate A_index by summing profile indices from all three zones
  A_index <- calculate_profile_index(z1) +
    calculate_profile_index(z2) +
    calculate_profile_index(z3)

  return(A_index)
}
