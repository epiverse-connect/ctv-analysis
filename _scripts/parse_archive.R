archive_df <- httr2::request("https://cran.r-project.org/src/contrib/PACKAGES.in") |>
  httr2::req_perform() |>
  httr2::resp_body_string() |>
  stringr::str_split_1("Package: ") |>
  stringr::str_trim() |>
  stringr::str_split("\n", 2) |>
  purrr::discard_at(1) |>
  do.call(rbind, args = _) |>
  as.data.frame() |>
  rename(package = V1, archivals = V2) |>
  mutate(archivals = stringr::str_extract_all(archivals, "\\d{4}\\-\\d{2}\\-\\d{2}")) |>
  tidyr::unnest_longer(archivals)
