#' Dominant Tree Diameter
#'
#' This function calculates the dominant tree diameter, defined as the mean
#' diameter at breast height (dbh) of the 100 thickest trees within a specified
#' plot area. It considers the tree diameters provided and determines which
#' trees qualify as dominant based on their thickness.
#'
#' @param d Numeric vector. A vector of tree diameters (in centimeters).
#' @param ps Numeric variable. The plot area (in square meters).
#'
#' @return Numeric value representing the mean diameter at breast height
#' of the dominant trees (in centimeters).
#'
#' @examples
#' # Example tree diameters and plot area
#' d <- c(12, 25, 40, 40, 55, 35, 35, 25, 12, 15)
#' ps <- 400
#'
#' # Calculate the dominant tree diameter
#' d_dom(d, ps)
#' @export
d_dom <- function(d, ps) {
  # Calculate the number of dominant trees based on plot area (100 thickest)
  xx <- round(ps / 100)
  xy <- numeric(length(d)) # Initialize vector to store counts

  for (i in seq_along(d)) {
    z <- d[i]
    zx <- length(d[d >= z]) # Count of trees thicker than current tree
    xy[i] <- zx
  }

  # Determine dominant trees based on thickness
  yx <- ifelse(xy <= xx, "dom_tree", "not_dom")

  # Calculate the mean diameter of dominant trees
  yy <- mean(d[which(yx == "dom_tree")])
  return(yy)
}
