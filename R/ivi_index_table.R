#' Calculate IVI Index Table
#'
#' Computes a table of Importance Value Index (IVI) for tree species based on
#' abundance (Nha), dominance (Xha), and frequency, using plot-level data. It will
#' compute the species frequency based on the number of plots. So it is recommended to compute the IVI
#' per area and not just for individual plots.
#'
#' @param sp A column in `data` indicating species names.
#' @param x A numeric column used for dominance calculation (e.g., basal area or crown area).
#' @param plot A factor or character column indicating plot identifiers.
#' @param data A data frame containing all the input columns.
#' @param ps Numeric value representing the area of the individual plots (e.g., 10000 m²).
#'
#' @return A data frame with species-wise IVI metrics: Abundance, Dominance, Frequency, and IVI.
#' @export
#'
#' @examples
#' data("pipse_cplot")
#' ivi_index_table(sp = sp, x = ca, plot = plot, data = pipse_cplot, ps = 1000)
#'
ivi_index_table <- function(sp, x, plot, data = NULL, ps) {
  plot_area <- ps
  if (is.null(data)) {
    if (length(unique(c(length(plot), length(sp), length(x)))) > 1) {
      stop("All input vectors (plot, sp, xha) must have the same length.")
    }

    df <-
      data.frame(
        sp = sp,
        x = x,
        plot = plot
      )
  } else {

    # Convert arguments to character strings (non-standard evaluation)
    sp_col <- deparse(substitute(sp))
    x_col <- deparse(substitute(x))
    plot_col <- deparse(substitute(plot))

    # Prepare data frame
    df <- data.frame(
      sp = as.character(data[[sp_col]]),
      x = as.numeric(data[[x_col]]),
      plot = as.character(data[[plot_col]])
    )
  }

  # Adjust area for total number of plots
  total_area <- plot_area * length(unique(df$plot))

  Xha <- function(x, y) {
    xx <- sum(x, na.rm = T)
    yy <- ((xx) * 10000) / y
    return(yy)
  }

  # Abundance (Nha) per species
  nha_df <- df |>
    dplyr::group_by(sp) |>
    dplyr::summarise(Nha = Nha(x, total_area), .groups = "drop")

  # Dominance (Xha) per species
  xha_df <- df |>
    dplyr::group_by(sp) |>
    dplyr::summarise(Xha = Xha(x, total_area), .groups = "drop")

  # Frequency: number of plots per species
  plot_count <- df |>
    dplyr::group_by(plot, sp) |>
    dplyr::summarise(count = dplyr::n(), .groups = "drop") |>
    dplyr::group_by(sp) |>
    dplyr::summarise(Plots = dplyr::n(), .groups = "drop")

  # Combine all metrics
  table <- dplyr::full_join(nha_df, xha_df, by = "sp") |>
    dplyr::full_join(plot_count, by = "sp")

  # Replace NA with 0 (in case some species are missing in any metric)
  table[is.na(table)] <- 0

  # Calculate relative values
  tbl01 <-
    table |>
    dplyr::mutate(
      Abundance = (table$Nha / sum(table$Nha)) * 100,
      Dominance = (table$Xha / sum(table$Xha)) * 100,
      Frequency = (table$Plots / sum(table$Plots)) * 100)

  tbl02 <-
    tbl01 |>
    dplyr::mutate(IVI_raw = tbl01$Abundance + tbl01$Dominance + tbl01$Frequency)

  tbl03 <-
    tbl02 |>
    dplyr::mutate(IVI = (tbl02$IVI_raw / sum(tbl02$IVI_raw)) * 100)

  tbl04 <- tbl03[,c("sp","Nha", "Xha", "Plots", "Abundance", "Dominance", "Frequency", "IVI" )]

  tbl05 <- tbl04[order(tbl04$IVI, decreasing=TRUE),]

  tbl05$rank <- 1:nrow(tbl05)

  return(tbl05)

}
