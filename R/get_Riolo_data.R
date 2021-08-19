#' Load Riolo Data
#'
#' @param Riolo_var string Riolo variable name
#' @param sex string for sex
#' @param rescale Boolean for whether to rescale data using Michigan scaling
#' factor
#'
#' @return data.frame with Riolo data
#' @export
#'
get_Riolo_data <- function(Riolo_var, sex, rescale = FALSE) {
  sex_sub <- if_else(sex == "F", "Female", "Male")
  R <- get(Riolo_var) %>%
    filter(Sex == sex_sub)
  if (rescale) {
    R <- R %>%
      mutate(Mean = 0.871 * Mean,
             SD = 0.871 * SD)
  }
  return(R)
}