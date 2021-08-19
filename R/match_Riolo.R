#' Match Riolo Data
#'
#' @param tr string of trait to match
#'
#' @return string Riolo variable name
#' @export
#'
match_Riolo <- function(tr) {
  Riolo_vars <- read_csv(system.file("extdata",
                                     "Riolo_data_linear.csv",
                                     package = "Riolo"),
                         col_types = "dcccccdcddd") %>%
    drop_na() %>%
    select(Short_Name, CGCS_Name) %>%
    unique() %>%
    arrange(CGCS_Name)
  short_name <- str_flatten(str_split(tr, "_")[[1]][2:3], collapse = "_")
  Riolo_var <- Riolo_vars$Short_Name[Riolo_vars$CGCS_Name == short_name] %>%
    str_replace(., "-", "_")
  return(Riolo_var)
}
