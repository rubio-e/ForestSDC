#' BALMOD Competition Index
#'
#' This function calculates the BALMOD competition index for trees based on their
#' diameters, heights, and the area of the plot. The BALMOD index measures competition
#' among trees by integrating basal area proportion, relative spacing, and dominant height.
#'
#' The BALMOD index is computed as:
#'
#' \deqn{\text{BALMOD} = \frac{1 - \pi}{RS}}
#'
#' where:
#' - \eqn{\pi} is the proportion of the basal area of the individual tree (\eqn{\pi = \frac{\text{BAL}}{G_{\text{ha}}}}),
#' - \eqn{RS} is the relative spacing (\eqn{RS = \frac{\sqrt{10000 / N}}{h_{\text{dom}}}}),
#' - \eqn{N} is the total number of trees in the plot,
#' - \eqn{h_{\text{dom}}} is the dominant height, defined as the mean height of the tallest trees.
#' @md
#' @param x A numeric vector representing the diameters of the trees in cm.
#' @param y A numeric vector representing the heights of the trees in meters.
#' @param z A numeric variable representing the plot area in square meters.
#'
#' @return A numeric vector containing the BALMOD index for each tree.
#'
#' @examples
#' x <- c(10, 20, 30, 40, 50, 25, 30, 22, 11, 10) # Tree diameters in cm
#' y <- c(12, 23, 33, 45, 43, 22, 31, 32, 13, 11) # Tree heights in meters
#' z <- 400 # Plot area in square meters
#'
#' BALMOD(x, y, z) # Calculate BALMOD index
#'
#' @export
BALMOD <- function(x, y, z) {
  # Calculate the proportion of basal area
  pi <- (bal(x, z) / Gha(x, z))

  # Calculate the relative spacing
  RS <- sqrt(10000 / length(x)) / h_dom(y, x, z)

  # Compute the BALMOD index
  BALMOD <- (1 - pi) / RS

  # Return the BALMOD index
  return(BALMOD)
}
