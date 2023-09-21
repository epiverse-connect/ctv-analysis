tf <- tempfile()

# Loop to extract all the tarballs in tf
list.files("_packages", full.names = TRUE) |>
  purrr::walk(function(f) {
    untar(
      tarfile = f,
      exdir   = tf
    )
  })

safe_lint <- purrr::safely(lintr::lint_package)
# Loop to lint all extracted packages in tf
res <- list.files(tf, full.names = TRUE) |>
  purrr::set_names(basename) |>
  purrr::map(function(package) {
    safe_lint(
      package
    )
  })
