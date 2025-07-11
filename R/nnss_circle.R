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
#' @param ccoords a vector including the center coordinates of the plots.
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
#' plot_radius <- 17.84124 # for a 1000 m2 plot
#' azi <- runif(100, min = 0, max = 360)
#' dis <- runif(100, min = 1, max = plot_radius)
#' df_xy <- coordxy(azi, dis, plot_radius*2)
#' sp <- factor(sample(c("Pinus", "Quercus"), 100, replace = TRUE))
#' d <- runif(100, min = 7.5, max = 60)
#' h <- 5.4349 + d * 0.4219
#' plot <- rep("P01", 100)
#' dataP02 <- data.frame(plot, df_xy, sp, d, h)
#' nnss_circle(plot = plot, x = x, y = y, sp = sp, d = d,
#' h = h, r = plot_radius, data = dataP02)
#'
#' @export
nnss_circle <- function(plot, x, y, sp, d, h, r, data = NULL, ccoords = NULL) {
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
  if (is.null(ccoords)) {
    nnss_results <- data1 |>
      dplyr::group_by(plot) |>
      dplyr::mutate(df_nnss = nnss5c(x = x, y = y, sp = sp, d = d, h = h, r = r)) |>
      tidyr::separate(col = "df_nnss", into = c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1"), sep = ";")
  } else {
    data1$xx <- data1$x-(ccoords[,1]-r)
    data1$yy <- data1$y-(ccoords[,2]-r)
    nnss_results <- data1 |>
      dplyr::group_by(plot) |>
      dplyr::mutate(df_nnss = nnss5c(x = data1$xx, y = data1$yy, sp = sp, d = d, h = h, r = r)) |>
      tidyr::separate(col = "df_nnss", into = c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1"), sep = ";")
  }

  # Convert calculated columns to numeric
  numeric_cols <- c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")
  nnss_results[numeric_cols] <- lapply(nnss_results[numeric_cols], as.numeric)

  return(nnss_results)
}
