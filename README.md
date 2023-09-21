# CRAN Task View Analysis

This repository aims at providing a reproducible Rmarkdown report to analyze the state of a given R package ecosystem as defined in a CRAN Task View.

## Related projects

- [Mapping Research Software Landscapes through Exploratory Studies of GitHub Data](https://github.com/kequach/Thesis-Mapping-RS)
- [Augur: Python library and web service for Open Source Software Health and Sustainability metrics & data collection, by CHAOSS](https://chaoss.github.io/augur/)
- [rOpenSci's pkgcheck R package](https://github.com/ropensci-review-tools/pkgcheck)

## For contributing

### Pre-commit

This project uses pre-commit to automatically screen incoming code for a minumum standard.

To comply:
- Install pre-commit on your machine
    - `brew install pre-commit`
- Navigate to this repo
    - `cd cran-task-view-analysis`
- Set up pre-commit
    - `pre-commit install`
- Make changes to the code
- Commit your changes
    - `git commit -m "your message"`
- Review the pre-commit output
