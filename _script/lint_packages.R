tf <- tempfile()

# Loop to extract all the tarballs in tf
list.files("_packages", full.names = TRUE) |>
  purrr::walk(function(f) {
    untar(
      tarfile = f,
      exdir   = tf
    )
  })

# Loop to lint all extracted packages in tf
res <- list.files(tf, full.names = TRUE) |>
  purrr::map(function(package) {
    lintr::lint_package(
      package
    )
  })
