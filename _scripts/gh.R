#' Check if a file exists in a repo
#' The file is handed to the function as a string
#' @param file The file to check for
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return TRUE if the file exists, FALSE if it does not
gh_file_exists <- function(file, repo) {
  # Create the url
  url <- file.path("https://api.github.com/repos", repo, "contents", file)
  # Get the contents of the url.
  # If the file throws a 404 error, file exists will be False
  # If the file does not throw a 404 error, file exists will be True
  file_exists <- !httr::http_error(
    httr::GET(
      url,
      httr::add_headers(Authorization = paste0("token ", gh::gh_token()))
    )
  )
  # Return the result
  return(file_exists)
}

#' We want to shove a vector to the gh_file_exists function
#' A function that loops through the files to check in a repo
#' @param files A vector of files to check for in the repo
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return A vector of TRUE/FALSE values for each file
gh_file_list_exists <- function(files, repo) {
  # Create an empty vector to store the results
  results <- vector(mode = "logical", length = length(files))
  # Loop through the files
  for (i in seq_along(files)) {
    # Check if the file exists
    results[i] <- gh_file_exists(files[i], repo)
  }

  # Return the results
  return(results)
}
