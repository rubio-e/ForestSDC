#' Identify Dominant Trees in a Plot Area
#'
#' This function identifies the dominant trees in a specified plot area by selecting
#' the 100 thickest trees based on their diameters. Dominant trees are classified
#' as those whose diameters fall within the top 100 in the given plot area.
#'
#' @param x Numeric vector. A vector of tree diameters measured in centimeters.
#' @param y Numeric variable. The total plot area in square meters.
#'
#' @return Character vector. A vector of the same length as `x`, where each entry is labeled
#'         as "dom_tree" for dominant trees and "not_dom" for non-dominant trees.
#'
#' @examples
#' # Example tree diameters
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10)
#'
#' # Specify the plot area
#' y <- 1000
#'
#' # Identify dominant trees
#' dom_trees(x, y)
#'
#' @export
dom_trees <- function(x, y) {
  # Validate inputs
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("Both 'x' (tree diameters) and 'y' (plot area) must be numeric.")
  }

  # Calculate the number of dominant trees to identify (based on plot area)
  num_dominant_trees <- round(y / 100)

  # Initialize a vector to store the dominance status
  dominance_status <- character(length(x))

  for (i in seq_along(x)) {
    current_diameter <- x[i]

    # Count how many trees have a diameter greater than or equal to the current diameter
    num_trees_larger_or_equal <- sum(x >= current_diameter)

    # Label trees as "dom_tree" or "not_dom" based on their size relative to the top 100
    dominance_status[i] <- ifelse(num_trees_larger_or_equal <= num_dominant_trees, "dom_tree", "not_dom")
  }

  return(dominance_status)
}
