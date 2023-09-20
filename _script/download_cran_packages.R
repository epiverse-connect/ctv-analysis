download_tarball <- function(pkgname, version) {

  fn <- glue::glue("{pkgname}_{version}.tar.gz")
  download.file(
    glue::glue("https://cran.r-project.org/src/contrib/{fn}"),
    file.path("_packages", fn)
  )

}

purrr::walk2(
  ctv_pkg_descriptions$Package,
  ctv_pkg_descriptions$Version,
  download_tarball
)

# Manual work around https://github.com/bernadette-eu/Bernadette/pull/10
file.remove(file.path("_packages", "Bernadette_1.1.4.tar.gz"))
