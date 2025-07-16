#' Azimuth and distance data for Pinus pseudostrobus
#'
#' This dataset includes tree measurements and spatial orientation information
#' for *Pinus pseudostrobus* individuals sampled in multiple plots.
#'
#' @format A data frame with `r nrow(pipse_azimuth)` rows and `r ncol(pipse_azimuth)` variables:
#' \describe{
#'   \item{plot}{Plot identifier (character)}
#'   \item{sp}{Species code, here `PIPSE` for *Pinus pseudostrobus* (character)}
#'   \item{d}{Diameter at breast height in cm (numeric)}
#'   \item{h}{Tree height in m (numeric)}
#'   \item{azimuth}{Azimuth from plot center to tree in degrees (numeric, 0–360)}
#'   \item{distance}{Distance from plot center to tree in meters (numeric)}
#' }
#'
#' @details
#' The data were collected to analyze spatial distribution patterns and size variation of *Pinus pseudostrobus* in sampled forest plots. This dataset can be used for modeling spatial structure or basal area estimations.
#'
#' @source Field data collected by Ernesto Rubio.
"pipse_azimuth"
