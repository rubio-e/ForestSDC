#' Calculate Nearest Neighbor Indices for Square Plots
#'
#' This function calculates nearest neighbor indices for trees within a square plot.
#' It requires coordinates, tree diameter, height, and species information, along with the
#' plot's maximum x and y dimensions. The function returns several indices related to tree competition and spacing.
#'
# @param plot A numeric or character variable representing the plot identifier.
#' @param x A numeric vector of x-coordinates for each tree.
#' @param y A numeric vector of y-coordinates for each tree.
#' @param d A numeric vector representing tree diameters.
#' @param h A numeric vector representing tree heights.
#' @param sp A factor or character vector representing tree species.
#' @param xr A numeric vector including the min and the max values of the x-coordinates for the plot.
#' @param yr A numeric vector including the min and the max values of the x-coordinates for the plot.
#' @param data A data frame containing all the required columns (`x`, `y`, `sp`, `d`, `h`).
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
#'
#' data("pipse_one")
#'
#' nnss_test <- nnss_square(x = x, y = y, sp = sp, d = d,
#' h = h, xr = c(0,50), yr = c(0,50), data = pipse_one)
#'
#' head(nnss_test)
#'
#' @export
nnss_square <- function(x, y, sp, d, h, xr, yr, data = NULL) {

  x_min <- xr[1]
  x_max <- xr[2]
  y_min <- yr[1]
  y_max <- yr[2]

  if (is.null(data)) {
    if (length(unique(c(length(x), length(y), length(sp), length(d), length(h)))) > 1) {
      stop("All input vectors (x, y, sp, d, h) must have the same length.")
    }
    data1 <-
      data.frame(
        x = x,
        y = y,
        xc = x - x_min,
        yc = y - y_min,
        sp = sp,
        d = d,
        h = h
      )
  } else {
    x_col  <- as.character(substitute(x))
    y_col  <- as.character(substitute(y))
    sp_col <- as.character(substitute(sp))
    d_col  <- as.character(substitute(d))
    h_col  <- as.character(substitute(h))

    data1 <-
      data.frame(
        x = data[[x_col]],
        y = data[[y_col]],
        xc = data[[x_col]] - x_min,
        yc = data[[y_col]] - y_min,
        sp = data[[sp_col]],
        d = data[[d_col]],
        h = data[[h_col]]
      )
  }

  # Identify duplicated rows
  data_duplicated <- data1 |>
    dplyr::add_count(x, y) |>
    dplyr::filter(n > 1) |>
    dplyr::distinct()

  if (nrow(data_duplicated) >= 1) {
    warning("Duplicated rows found in the data. These rows will be returned for review.")
    return(data_duplicated)
  } else {
    # Calculate Nearest Neighbor indices using your external function `nnss5q`
    nnss_alli <- data1 |>
      dplyr::mutate(df_nnss = nnss5q(
        x = data1$xc,
        y = data1$yc,
        sp = data1$sp,
        d = data1$d,
        h = data1$h,
        xmax = x_max - x_min,
        ymax = y_max - y_min
      ))

    # Separate the calculated indices into individual columns
    nnss_results <- nnss_alli |>
      tidyr::separate(col = "df_nnss", into = c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1"), sep = ";")

    # Convert the new columns to numeric
    cols <- c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")
    nnss_results[cols] <- lapply(nnss_results[cols], as.numeric)

    return(nnss_results[, c("xc", "yc", "sp", "d", "h", "Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")])
  }
}
