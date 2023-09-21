# This is a collection of scripts that will connect to the github api and check for the existance of a file in a repo.

# We want to import the md5 package to check the "fingerprint" of a file.
# This is useful for checking if a file is up to date.
library(digest)

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
  file_exists <- !http_error(httr::GET(url, httr::add_headers(Authorization = paste0("token ", gh::gh_token()))))
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
    # If the file is github workflow, run a different function
    if (files[i] == ".github/workflows/") {
      print("Checking Workflow md5 matches...")
      # Check if the workflow is up to date
      results[i] <- gh_workflow_check(repo, owner)
    }
    else {
      # Check if the file exists
      results[i] <- gh_file_exists(files[i], repo, owner)
    }
  }

  # Return the results
  return(results)
}


#' A function that checks if the workflow is up to date for CI
#' The repo checks if .github/workflow exists
#' If it does, an extra function runs to check if it matches the up to date tidyverse repo.
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return a string description if the workflow is up to date, FALSE if it is not
gh_workflow_check <- function(repo, owner) {
  # Check if the workflow exists
  workflow_exists <- gh_file_exists(".github/workflows/", repo, owner)
  # If the workflow exists, check if it is up to date
  if (workflow_exists) {
    print("Workflow exists")
    # Check if the workflow is up to date
    # There are two scenarios. The workflows folder exists, which is great!
    # But even better is if it matches the tidyverse fingerprint.
    workflow_up_to_date <- gh_workflow_tidyverse_fingerprint(repo, owner)
    print(workflow_up_to_date)
    # Return the result 
    return(workflow_up_to_date)

  } else {
    # Return FALSE if the workflow does not exist
    return(FALSE)
  }
}


#' A function that lists the files in a github folder
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @param location The location of the folder to check
#' @return A list of download files in the folder
gh_list_files <- function(repo, owner, location) {
    # Create the url
    url <- paste0("https://api.github.com/repos/", owner, "/", repo, "/contents/", location)
    # Get the contents of the url.
    # If the file throws a 404 error, file exists will be False
    # If the file does not throw a 404 error, file exists will be True
    # Use the httr package to get the url with the GitHub authentication token
    files <- httr::GET(url, httr::add_headers(Authorization = paste0("token ", gh::gh_token())))
    # Within files is a download url. We want to extract that and return it. download_url.

    # Convert the files to a list because reading the httr return is a pain
    files <- httr::content(files)
    # Convert the list to a dataframe. Thi might allow us to handle multiple returns more easily in the future.
    files <- as.data.frame(files)
    # Get the download url from the dataframe and return it.
    files <- files$download_url
    # Return the result
    return(files)
    }



#' A function that checks if the workflow is up to date for CI
#' Checks if the fingerprint of the file matches the most up to date tidyverse fingerprint
#' The reference file is located at https://github.com/tidyverse/tidytemplate/blob/main/.github/workflows/R-CMD-check.yaml
#' Ideally, this would also allow for a user to specify a different fingerprint to check against to see if older versions or standards are met.
#' @param repo The repo to check in
#' @param owner The owner of the repo
#' @return TRUE if the workflow is up to date, FALSE if it is not
gh_workflow_tidyverse_fingerprint <- function(repo, owner) {
  # Fetch a list of all files in the workflows folder
  workflow_files <- gh_list_files(repo, owner, ".github/workflows/")
  # We will check if any contents of the files in the vector matches the tidyverse fingerprint
  # The tidyverse fingerprint is located at https://github.com/tidyverse/tidytemplate/blob/main/.github/workflows/R-CMD-check.yaml

  # Get the md5 fingerprint of the tidyverse workflow
  tidyverse_workflow <- httr::GET("https://raw.githubusercontent.com/tidyverse/tidytemplate/main/.github/workflows/R-CMD-check.yaml")
  tidyverse_workflow_md5 <- digest(tidyverse_workflow$content, algo = "md5")
  
  # We will make an empty list of hashes and populate it with the workflow file fingerprints.
  hashes <- vector(mode = "character", length = length(workflow_files))
  # loop through the workflow file names
  for (i in seq_along(workflow_files)) {
    # Get the file 
    file <- httr::GET(workflow_files)
    # Get the md5 fingerprint of the file
    file_md5 <- digest(file$content, algo = "md5")
    # Add the fingerprint to the list
    hashes[i] <- file_md5
  }
  
  # Check if the tidyverse_workflow_md5 appears in the hashes.
  # If it does, return TRUE
  if (tidyverse_workflow_md5 %in% hashes) {
    return(TRUE)
  } else {return(FALSE)}
  
}
