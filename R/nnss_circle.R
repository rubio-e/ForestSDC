#' Calculate Nearest Neighbor Indices for Circular Plots
#'
#' This function calculates nearest neighbor indices for trees within a circular plot.
#' It requires coordinates, tree diameter, height, and species information, and returns
#' several indices related to tree competition and spacing.
#'
#' @param plot A numeric or character variable representing the plot identifier.
#' @param x A numeric vector of x-coordinates for each tree.
#' @param y A numeric vector of y-coordinates for each tree.
#' @param d A numeric vector representing tree diameters.
#' @param h A numeric vector representing tree heights.
#' @param sp A factor or character vector representing tree species.
#' @param r A numeric value representing the radius of the circular plot (must be positive).
#' @param data A data frame containing all the required columns (`plot`, `x`, `y`, `sp`, `d`, `h`).
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
#' x <- runif(100, min = 1, max = 99)
#' y <- runif(100, min = 1, max = 99)
#' sp <- factor(sample(c("Pinus", "Quercus"), 100, replace = TRUE))
#' d <- runif(100, min = 7.5, max = 60)
#' h <- runif(100, min = 2, max = 40)
#' plot <- rep("P01", 100)
#' dataP01 <- data.frame(plot, x, y, sp, d, h)
#' nnss_circle(plot = plot, x = x, y = y, sp = sp, d = d, h = h, r = 50, data = dataP01)
#'
#' @export
nnss_circle <- function(plot, x, y, sp, d, h, r, data = NULL) {
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
    required_cols <- c("plot", "x", "y", "sp", "d", "h")
    if (!all(required_cols %in% colnames(data))) {
      stop("The data frame must contain the columns: plot, x, y, sp, d, h.")
    }
    plot <- deparse(substitute(plot))
    x <- deparse(substitute(x))
    y <- deparse(substitute(y))
    sp <- deparse(substitute(sp))
    d <- deparse(substitute(d))
    h <- deparse(substitute(h))
    data1 <-
      data.frame(
        plot = data[, plot],
        x = data[, x],
        y = data[, y],
        sp = data[, sp],
        d = data[, d],
        h = data[, h]
      )
  }

  if (!is.numeric(r) || r <= 0) {
    stop("Radius (r) must be a positive numeric value.")
  }

  # Check for duplicate rows
  duplicates <- data1 |>
    dplyr::add_count(plot, x, y) |>
    dplyr::filter(n > 1) |>
    dplyr::distinct()

  if (nrow(duplicates) > 0) {
    warning("Duplicated rows found in the data. These rows will be returned for review.")
    return(duplicates)
  }

  # Calculate nearest neighbor indices using the external function `nnss5c`
  nnss_results <- data1 |>
    dplyr::group_by(plot) |>
    dplyr::mutate(i = nnss5c(x = x, y = y, sp = sp, d = d, h = h, r = r)) |>
    tidyr::separate(i, into = c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1"), sep = ";")

  # Convert calculated columns to numeric
  numeric_cols <- c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")
  nnss_results[numeric_cols] <- lapply(nnss_results[numeric_cols], as.numeric)

  return(nnss_results)
}
