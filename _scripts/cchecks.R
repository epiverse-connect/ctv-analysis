tf <- tempfile(fileext = ".md")
download.file(
  "https://github.com/cran-task-views/Epidemiology/raw/main/Epidemiology.md",
  tf
)

library(ctv)
library(purrr)

ctv_pkgs <- ctv::read.ctv(tf) |>
  purrr::pluck("packagelist", "name")

get_pkg_checks <- function(pkg) {

  glue::glue("https://cran.r-project.org/web/checks/check_results_{pkg}.html") |>
    xml2::read_html() |>
    xml2::xml_find_first("//table") |>
    rvest::html_table() |>
    with(data = _, table(Status))

}

res <- ctv_pkgs |>
  purrr::map(get_pkg_checks) |>
  dplyr::bind_rows() |>
  cbind(package = ctv_pkgs)

write.csv(res, glue::glue("_data/cchecks_{Sys.Date()}.csv"), row.names = FALSE)
