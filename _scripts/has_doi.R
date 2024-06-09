has_doi <- function(pkg) {

  tryCatch({
    glue::glue("https://cran.r-project.org/web/packages/{pkg}/citation.html") |>
      as.character() |>
      httr2::request() |>
      httr2::req_perform() |>
      httr2::resp_body_string() |>
      stringr::str_detect(stringr::fixed("https://doi.org/"))
  }, error = function(e) FALSE)

}
