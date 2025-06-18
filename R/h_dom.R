#' Dominant Tree Height (Mean Height of the 100 Thickest Trees in a Hectare)
#'
#' This function calculates the dominant tree height, which is the mean height
#' of the 100 thickest trees in a specified plot area, based on their diameters.
#'
#' @param h Numeric vector. Tree heights (in centimeters).
#' @param d Numeric vector. Tree diameters (in centimeters).
#' @param ps Numeric variable. Plot area (in square meters).
#'
#' @return Numeric value representing the dominant tree height, which is
#'         the mean height of the 100 thickest trees.
#'
#' @examples
#' h <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#' d <- c(12, 25, 40, 40, 55, 35, 35, 25, 12, 15)
#' ps <- 400
#' h_dom(h, d, ps)
#'
#' @export
h_dom <- function(h, d, ps) {
  # Validate inputs
  if (!is.numeric(h) || !is.numeric(d) || !is.numeric(ps)) {
    stop("All inputs 'h', 'd', and 'ps' must be numeric.")
  }

  # Calculate the number of dominant trees based on plot area
  num_dominant_trees <- round(ps / 100)

  # Initialize a vector to store dominance status of trees
  dominance_status <- character(length(d))

  # Identify dominant trees by diameter
  for (i in seq_along(d)) {
    current_diameter <- d[i]
    num_trees_larger_or_equal <- sum(d >= current_diameter)

    # Label as "h100" if the tree is among the top 100 by diameter, otherwise "ndom"
    dominance_status[i] <- ifelse(num_trees_larger_or_equal <= num_dominant_trees, "h100", "ndom")
  }

  # Calculate the mean height of the dominant trees (h100)
  dominant_heights <- h[dominance_status == "h100"]
  mean_dominant_height <- mean(dominant_heights, na.rm = TRUE)

  return(mean_dominant_height)
}
