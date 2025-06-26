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
#' @param data A data frame containing all the required columns (`plot`, `x`, `y`, `sp`, `d`, `h`).
#'
#' @return A data frame with calculated nearest neighbor indices for each tree.
#' Columns include:
#'   - `Ui`: Uniformity index
#'   - `Mi`: Mixture index
#'   - `dDomi`: Dominance based on diameter
#'   - `hDomi`: Dominance based on height
#'   - `dDif`: Diameter differentiation
#'   - `hDif`: Height differentiation
#'   - `NN1`: Nearest-neighbor edge-correction
#' @md
#'
#' @examples
#' set.seed(42)
#' x <- runif(100, min = 1, max = 50)
#' y <- runif(100, min = 1, max = 50)
#' sp <- factor(sample(c("Pinus", "Quercus"), 100, replace = TRUE))
#' d <- runif(100, min = 7.5, max = 60)
#' h <- 5.4349 + d * 0.4219
#' plot <- rep("P01", 100)
#' dataP01 <- data.frame(plot, x, y, sp, d, h)
#' nnss_square(plot = plot, x = x, y = y, sp = sp, d = d, h = h, xmax = 50, ymax = 50, data = dataP01)
#'
#' @export
nnss_square <- function(plot, x, y, sp, d, h, xmax, ymax, data = NULL) {
  # Validate input
  if (is.null(data)) {
    if (length(unique(c(length(plot), length(x), length(y), length(sp), length(d), length(h)))) > 1) {
      stop("All input vectors (plot, x, y, sp, d, h) must have the same length.")
    }
    data1 <-
      data.frame(
        plot = plot,
        x = x,
        y = y,
        sp = sp,
        d = d,
        h = h
      )
  } else {
    # required_cols <- c("plot", "x", "y", "sp", "d", "h")
    # if (!all(required_cols %in% colnames(data))) {
    #   stop("The data frame must contain the columns: plot, x, y, sp, d, h.")
    # }
    plot <- deparse(substitute(plot))
    x <- deparse(substitute(x))
    y <- deparse(substitute(y))
    sp <- deparse(substitute(sp))
    d <- deparse(substitute(d))
    h <- deparse(substitute(h))

    data1 <-
      data.frame(
        plot = data[[plot]],
        x = data[[x]],
        y = data[[y]],
        sp = data[[sp]],
        d = data[[d]],
        h = data[[h]]
      )
  }

  # Identify duplicated rows
  data_duplicated <- data1 |>
    dplyr::add_count(plot, x, y) |>
    dplyr::filter(n > 1) |>
    dplyr::distinct()

  if (nrow(data_duplicated) >= 1) {
    warning("Duplicated rows found in the data. These rows will be returned for review.")
    return(data_duplicated)
  } else {
    # Calculate Nearest Neighbor indices using an external function `nnss5q`
    nnss_alli <- data1 |>
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
