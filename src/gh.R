# This is a collection of scripts that will connect to the github api and check for the existance of a file in a repo.

# Install libraries
install.packages("gh")

# Load libraries
library(gh)

#' Check if a file exists in a repo
#' The file is handed to the funcion as a string
#' @param file The file to check for
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return TRUE if the file exists, FALSE if it does not
gh_file_exists <- function(file, repo, owner) {
  # Get the repo
  repo <- gh(repo, owner)

  # Get the contents of the repo
  contents <- gh(repo, owner, "contents")

  # Check if the file exists
  file_exists <- file %in% contents$name

  # Return the result
  return(file_exists)
}


