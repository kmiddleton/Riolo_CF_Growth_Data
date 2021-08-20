#' Match Riolo Data
#'
#' @param tr string of trait to match
#'
#' @return string Riolo variable name
#' @export
#'
match_Riolo <- function(tr) {
  Riolo_vars <- readr::read_csv(system.file("extdata",
                                            "Riolo_data_linear.csv",
                                            package = "Riolo"),
                                col_types = "dcccccdcddd") %>%
    tidyr::drop_na() %>%
    dplyr::select(Short_Name, CGCS_Name) %>%
    unique() %>%
    dplyr::arrange(CGCS_Name)
  short_name <- stringr::str_flatten(stringr::str_split(tr, "_")[[1]][2:3],
                                     collapse = "_")
  Riolo_var <- Riolo_vars$Short_Name[Riolo_vars$CGCS_Name == short_name] %>%
    stringr::str_replace(., "-", "_")
  return(Riolo_var)
}
