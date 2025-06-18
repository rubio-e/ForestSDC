#' Diameter Category Classification
#'
#' This function categorizes tree diameters into classes of 5 cm, starting
#' from 2.5 cm. It takes a numeric variable or vector representing tree
#' diameters and returns the corresponding diameter categories.
#'
#' @param x A numeric variable or vector representing tree diameters in centimeters.
#'
#' @return A factor variable or vector representing tree diameter classes in
#'         increments of 10 cm.
#'
#' @examples
#' # Create a data frame with tree diameters
#' d_data <- data.frame(d = c(10.1, 23, 31.5, 40, 52.4, 27, 33, 22, 11, 10))
#'
#' # Categorize the diameters into classes
#' d_data$diam_cat <- cat_d(d_data$d)
#'
#' # Display the categorized data
#' print(d_data)
#'
#' @export
cat_d <- function(x) {
  # Define the breaks for diameter categories
  y <- seq(2.4, 507.5, 5) # Break points for cutting
  xy <- seq(5, 505, 5) # Labels for the categories

  # Cut the input diameter data into categories
  cat_d <- as.data.frame(cut(x, y, labels = xy))

  # Return the categorized variable without unused levels
  return(droplevels(cat_d[, 1]))
}
