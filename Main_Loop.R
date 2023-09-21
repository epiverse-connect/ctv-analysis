# import src functions
source("_scripts/gh.R")
# Note that keyring relies on sodium. A system pre-requisite is libsodium i.e run brew install libsodium.
library(keyring)
library(gh)
library(httr)

# Set the GitHub PAT
# run key_set("github_pat", "YOUR_PAT_TOKEN")
github_pat <- key_get("github_pat")
gh_token(github_pat)

# What is the list of files to check for?
files <- c("README.md", "pkgdown.yaml", "pkgdown.yml", "LICENSE", ".github/workflows/")

# A list of test repos. This list will be generated from a function parameter in the future so as to dynamically generate the list from cran.
# The list is a list of lists containing i) the repo name and ii) the owner of the repo.

url_list <- c("https://github.com/tobadia/R0", "https://github.com/reconhub/epicontacts")

# For each repo in the list, split the url and add it to repos.
repos <- list()
for (i in seq_along(url_list)) {
    # Split the url
    url_info <- gh_split_url(url_list[i])
    # Add the repo to the list
    repos[[i]] <- url_info
}

print(repos)
# Repos should look like a list of lists
# [[1]]
# [[1]]$user
# [1] "tobadia"

# [[1]]$repo
# [1] "R0"


# [[2]]
# [[2]]$user
# [1] "reconhub"

# [[2]]$repo
# [1] "epicontacts"

# pass files to gh_file_list_exists in a loop of repos
for (i in seq_along(repos)) {
    # Get the repo
    repo <- repos[[i]]$repo
    # Get the owner
    owner <- repos[[i]]$user
    # Check if the files exist
    file_results <- gh_file_list_exists(files, repo, owner)
    # Print the results
    print(file_results)
}
