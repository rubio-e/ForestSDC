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
#' h = h, xr = cbind(0,50), yr = cbind(0,50), data = pipse_one)
#'
#' head(nnss_test)
#'
#' @export
nnss_square <- function(x, y, sp, d, h, xr, yr, data = NULL) {
  # Validate input
  if (is.null(data)) {
    if (length(unique(c(length(x), length(y), length(sp), length(d), length(h)))) > 1) {
      stop("All input vectors (plot, x, y, sp, d, h) must have the same length.")
    }
    data1 <-
      data.frame(
        # plot = plot,
        x = x,
        y = y,
        xc = x-xr[,1],
        yc = y-yr[,1],
        sp = sp,
        d = d,
        h = h
      )
  } else {
    # required_cols <- c("plot", "x", "y", "sp", "d", "h")
    # if (!all(required_cols %in% colnames(data))) {
    #   stop("The data frame must contain the columns: plot, x, y, sp, d, h.")
    # }
    # plot <- deparse(substitute(plot))
    x <- deparse(substitute(x))
    y <- deparse(substitute(y))
    sp <- deparse(substitute(sp))
    d <- deparse(substitute(d))
    h <- deparse(substitute(h))

    data1 <-
      data.frame(
        # plot = data[[plot]],
        x = data[[x]],
        y = data[[y]],
        xc = data[[x]]-xr[,1],
        yc = data[[y]]-yr[,1],
        sp = data[[sp]],
        d = data[[d]],
        h = data[[h]]
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
    # Calculate Nearest Neighbor indices using an external function `nnss5q`
    nnss_alli <- data1 |>
      # dplyr::group_by(plot) |>
      dplyr::mutate(df_nnss = nnss5q(
        x = data1$xc,
        y = data1$yc,
        sp = sp,
        d = d,
        h = h,
        xmax = xr[,2]-xr[,1],
        ymax = yr[,2]-yr[,1]
      ))

    # Separate the calculated indices into individual columns
    nnss_results <- nnss_alli |>
      tidyr::separate(col = "df_nnss", into = c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1"), sep = ";")

    # Convert the new columns to numeric
    cols <- c("Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")
    nnss_results[cols] <- lapply(nnss_results[cols], as.numeric)

    return(nnss_results[,c("xc","yc","sp","d","h","Ui", "Mi", "dDomi", "hDomi", "dDif", "hDif", "NN1")])
  }
}
