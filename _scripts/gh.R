# This is a collection of scripts that will connect to the github api and check for the existance of a file in a repo.

#' Github urls need to be split to user and repo to make the api call work.
#' @param url The url to split
#' @return A list containing the user and repo
gh_split_url <- function(url) {
  # Split the url
  split_url <- strsplit(url, "/")[[1]]

  # print the split url to verify it is correct
  print(split_url)
  # Get the user
  user <- split_url[4]
  # Get the repo
  repo <- split_url[5]

  # Return the result
  return(list(user = user, repo = repo))
}

#' Check if a file exists in a repo
#' The file is handed to the funcion as a string
#' @param file The file to check for
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return TRUE if the file exists, FALSE if it does not
gh_file_exists <- function(file, repo, owner) {
  # Create the url
  url <- paste0("https://api.github.com/repos/", owner, "/", repo, "/contents/", file)
  # Get the contents of the url.
  # If the file throws a 404 error, file exists will be False
  # If the file does not throw a 404 error, file exists will be True
  file_exists <- !grepl("404", httr::GET(url)$status_code)
  # Lets display the result to verify the url matches the status OK in a manual review.
  print(paste0("File: ", file, " exists: ", file_exists))
  # Return the result
  return(file_exists)
}

#' We want to shove a vector to the gh_file_exists function
#' A function that loops through the files to check in a repo
#' @param files A vector of files to check for in the repo
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return A vector of TRUE/FALSE values for each file
gh_file_list_exists <- function(files, repo, owner) {
  # Create an empty vector to store the results
  results <- vector(mode = "logical", length = length(files))
  # Loop through the files
  for (i in seq_along(files)) {
    # Check if the file exists
    results[i] <- gh_file_exists(files[i], repo, owner)
  }

  # Return the results
  return(results)
}
