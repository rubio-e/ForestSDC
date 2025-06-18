#' Calculate Nearest Neighbor Indices for Square Plots
#'
#' This function calculates nearest neighbor indices for trees within a square plot.
#' It requires coordinates, tree diameter, height, and species information, along with the
#' plot's maximum x and y dimensions. The function returns several indices related to tree competition and spacing.
#'
#' @param plot A numeric or character variable representing the plot identifier.
#' @param x A numeric vector of x-coordinates for each tree.
#' @param y A numeric vector of y-coordinates for each tree.
#' @param d A numeric vector representing tree diameters.
#' @param h A numeric vector representing tree heights.
#' @param sp A factor or character vector representing tree species.
#' @param xmax A numeric value representing the maximum x-coordinate value for the plot.
#' @param ymax A numeric value representing the maximum y-coordinate value for the plot.
#' @param data (Optional) A data frame containing all the required columns (`plot`, `x`, `y`, `sp`, `d`, `h`).
#'
#' @return A data frame with calculated nearest neighbor indices for each tree.
#' Columns include:
#'   - `Ui`: Uniformity index
#'   - `Mi`: Mixture index
#'   - `dDomi`: Dominance based on diameter
#'   - `hDomi`: Dominance based on height
#'   - `dDif`: Diameter difference
#'   - `hDif`: Height difference
#'   - `NN1`: Distance to the nearest neighbor
#' @md
#'
#' @examples
#' set.seed(42)
#' x <- runif(100, min = 1, max = 50)
#' y <- runif(100, min = 1, max = 50)
#' sp <- factor(sample(c("Pinus", "Quercus"), 100, replace = TRUE))
#' d <- runif(100, min = 7.5, max = 60)
#' h <- runif(100, min = 2, max = 40)
#' plot <- rep("P01", 100)
#' dataP01 <- data.frame(plot, x, y, sp, d, h)
#' nnss_square(plot = plot, x = x, y = y, sp = sp, d = d, h = h, xmax = 50, ymax = 50, data = dataP01)
#'
#' @export
nnss_square <- function(plot, x, y, sp, d, h, xmax, ymax, data = NULL) {
  # Use data if provided, or create a data frame from individual arguments
  if (!is.null(data)) {
    plot <- data$plot
    x <- data$x
    y <- data$y
    sp <- data$sp
    d <- data$d
    h <- data$h
  } else {
    data <- data.frame(plot, x, y, sp, d, h)
  }

  # Ensure correct column names
  colnames(data) <- c("plot", "x", "y", "sp", "d", "h")

  # Identify duplicated rows
  data_duplicated <- data |>
    dplyr::add_count(plot, x, y) |>
    dplyr::filter(n > 1) |>
    dplyr::distinct()

  if (nrow(data_duplicated) >= 1) {
    warning("Duplicated rows found in the data. These rows will be returned for review.")
    return(data_duplicated)
  } else {
    # Calculate Nearest Neighbor indices using an external function `nnss5q`
    nnss_alli <- data |>
      dplyr::group_by(plot) |>
      dplyr::mutate(i = nnss5q(
        x = x,
        y = y,
        sp = sp,
        d = d,
        h = h,
        xmax = xmax,
        ymax = ymax
      ))

    # Separate the calculated indices into individual columns
    nnew <- nnss_alli |>
      tidyr::separate(i, into = c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1"), sep = ";")

    # Convert the new columns to numeric
    cols <- c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")
    nnew[cols] <- lapply(nnew[cols], as.numeric)

    return(nnew)
  }
}
