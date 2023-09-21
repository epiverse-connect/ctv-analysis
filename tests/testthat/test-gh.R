# tests the functions in _scripts/gh.R


# load testthat package
library(testthat)


test_that("gh_file_exists", {
  # Test that the function returns TRUE when the file exists
  expect_true(gh_file_exists("README.md", "gh", "r-lib"))
  # Test that the function returns FALSE when the file does not exist
  expect_false(gh_file_exists("NOTREADME.md", "gh", "r-lib"))
})
```
