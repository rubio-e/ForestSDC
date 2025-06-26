#' Calculate IVI Index Table
#'
#' Computes a table of Importance Value Index (IVI) for tree species based on
#' abundance (Nha), dominance (Xha), and frequency, using plot-level data. It will
#' compute the species frequency based on the number of plots. So it is recommended to compute the IVI
#' per area and not just for individual plots.
#'
#' @param sp A column in `data` indicating species names.
#' @param xha A numeric column used for dominance calculation (e.g., basal area or crown area).
#' @param plot A factor or character column indicating plot identifiers.
#' @param data A data frame containing all the input columns.
#' @param plot_area Numeric value representing the area of the individual plots (e.g., 10000 m²).
#'
#' @return A data frame with species-wise IVI metrics: Abundance, Dominance, Frequency, and IVI.
#' @export
#'
#' @examples
#' # ivi_index_table(sp, xha, plot, data = mydata, plot_area = 400)
ivi_index_table <- function(sp, xha, plot, data, plot_area) {
  # Convert arguments to character strings (non-standard evaluation)
  sp_col <- deparse(substitute(sp))
  xha_col <- deparse(substitute(xha))
  plot_col <- deparse(substitute(plot))

  # Prepare data frame
  df <- data.frame(
    sp = as.character(data[[sp_col]]),
    xha = as.numeric(data[[xha_col]]),
    plot = as.character(data[[plot_col]])
  )

  # Adjust area for total number of plots
  total_area <- plot_area * length(unique(df$plot))

  Xha <- function(x, y) {
    xx <- sum(x, na.rm = T)
    yy <- ((xx) * 10000) / y
    return(yy)
  }

  # Abundance (Nha) per species
  nha_df <- df %>%
    dplyr::group_by(sp) %>%
    dplyr::summarise(Nha = Nha(xha, total_area), .groups = "drop")

  # Dominance (Xha) per species
  xha_df <- df %>%
    dplyr::group_by(sp) %>%
    dplyr::summarise(Xha = Xha(xha, total_area), .groups = "drop")

  # Frequency: number of plots per species
  plot_count <- df %>%
    dplyr::group_by(plot, sp) %>%
    dplyr::summarise(count = dplyr::n(), .groups = "drop") %>%
    dplyr::group_by(sp) %>%
    dplyr::summarise(Plots = dplyr::n(), .groups = "drop")

  # Combine all metrics
  table <- dplyr::full_join(nha_df, xha_df, by = "sp") %>%
    dplyr::full_join(plot_count, by = "sp")

  # Replace NA with 0 (in case some species are missing in any metric)
  table[is.na(table)] <- 0

  # Calculate relative values
  table <- table %>%
    dplyr::mutate(
      Abundance = (Nha / sum(Nha)) * 100,
      Dominance = (Xha / sum(Xha)) * 100,
      Frequency = (Plots / sum(Plots)) * 100,
      IVI_raw = Abundance + Dominance + Frequency,
      IVI = (IVI_raw / sum(IVI_raw)) * 100
    ) %>%
    dplyr::select(sp, Nha, Xha, Plots, Abundance, Dominance, Frequency, IVI) %>%
    dplyr::arrange(dplyr::desc(IVI))

  return(as.data.frame(table))
}
