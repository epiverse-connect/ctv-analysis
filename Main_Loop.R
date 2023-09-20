# import src functions
source("src/gh.R")
# Note that keyring relies on sodium. A system pre-requisite is libsodium i.e run brew install libsodium.
library(keyring)
library(gh)

# Set the GitHub PAT
# run key_set("github_pat", "YOUR_PAT_TOKEN")
github_pat <- key_get("github_pat")
gh_token(github_pat)

# What is the list of files to check for?
files <- c("README.md", "pkgdown.yaml", "pkgdown.yml")

# A list of test repos. This list will be generated from a function parameter in the future so as to dynamically generate the list from cran.
# The list is a list of lists containing i) the repo name and ii) the owner of the repo.

repos <- list(
  gh_split_url("https://github.com/tobadia/R0"),
  gh_split_url("https://github.com/reconhub/epicontacts")
)

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
    results <- gh_file_list_exists(files, repo, owner)
    # Print the results
    print(results)
}

