library(readODS)
library(tidyverse)

M <- read_ods("Riolo_data.ods", sheet = "Linear") %>%
  mutate(Rda_Name = str_replace_all(Short_Name, "-", "_")) %>%
  drop_na()

write_data <- function(d, ...) {
  outfile <- paste0(d$Rda_Name[1], ".rda")
  Rda_Name <- d$Rda_Name[1]
  d <- d %>% select(-Rda_Name)
  assign(Rda_Name, d)
  save(list = Rda_Name, file = paste0("../../data/", outfile))
}

M %>%
  group_by(Variable_Num) %>%
  group_map(.f = write_data)

for (v in unique(M$Variable_Num)) {
  d <- M %>% filter(Variable_Num == v)
  fileConn <- paste0("../../R/", d$Short_Name[1], ".R")
  write_lines(paste0("#' ", d$Long_Name[1]), fileConn)
  write_lines(paste0("#' "), fileConn, append = TRUE)
  write_lines(paste0("#' Variable ", d$Short_Name[1],
                    " from Riolo et al. (1974)"), fileConn,
             append = TRUE)
  write_lines(paste0("#' "), fileConn, append = TRUE)
  write_lines(paste0("#' "), fileConn, append = TRUE)
  write_lines(paste0("#' @name ", d$Rda_Name[1]), fileConn, append = TRUE)
  write_lines(paste0("#' @docType data"), fileConn, append = TRUE)
  write_lines(paste0("#' @format A data.frame with 22 observations ",
                     "of the following 11 variables: \\describe{"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{Variable_Num}{Variable number of Riolo}"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{Type}{Variable type (Angular or Linear)}"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{Long_Name}{Descriptive variable name}"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{Short_Name}{Abbreviated variable name}"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{Numeric_Name}{Numeric landmark coding}"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{CGCS_Name}{CGCS variable coding}"),
              fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{Age}{Age in years}"), fileConn,
              append = TRUE)
  write_lines(paste0("#'   \\item{Sex}{Female or Male}"), fileConn,
              append = TRUE)
  write_lines(paste0("#'   \\item{N}{Numeber of observations}"), fileConn,
              append = TRUE)
  write_lines(paste0("#'   \\item{Mean}{Mean value}"), fileConn, append = TRUE)
  write_lines(paste0("#'   \\item{SD}{Standard deviation}"), fileConn,
              append = TRUE)
  write_lines(paste0("#' }"), fileConn, append = TRUE)
  write_lines(paste0("#' @keywords datasets"), fileConn, append = TRUE)
  write_lines(paste0("#' "), fileConn, append = TRUE)
  write_lines(paste0("NULL"), fileConn, append = TRUE)
  write_lines(paste0(""), fileConn, append = TRUE)
}
