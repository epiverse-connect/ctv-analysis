# CRAN Task View Analysis

This repository contains the code for the analysis of the [CRAN Task View for epidemiology](https://github.com/cran-task-views/Epidemiology).

## 🤷 Why? 

- 📦 Help users and developers find the best packages for their needs.
    - ✅ Give users and developers a flavour of how maintained and trustworthy a package is.
    - 🧑‍💻 Guides developers on what could be worked on.
- 👪 Builds a community culture of quality, inclusion, and trust.
    - 🌳 Get a top down oversight of the state of the R epidemiology ecosystem.
    - 📈 Track the progress of the ecosystem over time.
    - 🤝 Encourages and rewards developing packages geared toward collaboration.

You can view the analysis [here](http://hugogruson.fr/cran-task-view-analysis/).

## 🎯 Aims

Many packages are submitted to the Cran Task View for epidemiology.

The question is how much should we trust them? How well maintained are they? What should we work on as a community?

This package aims to start answering those questions.

### 📊 [Analysis](http://hugogruson.fr/cran-task-view-analysis/)

- This analysis aims to look programatically at tangible aspects of the packages to help us answer the above questions.

- Whilst each individual check is only a proxy for quality, the combination of them should give us a good idea of the state of that package.

- When looking at all the packages, we get a broader picture of the ecosystem.

⚠️ Note that this analysis is not a replacement for manual expert review and code audit.

## 🤷 What is wrong with using any tool that does the job?

It is tempting to use any tool that does the job. However, we need to be careful about the tools we use. When thinking about trust, we can break it down into verification and validation. Has the product been designed correctly? Has the product been built correctly?

Both verification and validation require people to work on and review the package, however there are barriers to this. This package aims to see how many barriers those projects have.

Simple things, like if certain maintainer files are in place or not, can be a good proxy for the quality and trustability of the package. 

### 🗒️ Example: Why Readme files are important

If a project has a readme file, it means that they are helping developers and users to work with and contributing to their code. Over time, this will strengthen the quality of the code, reducing the likelihood that there are mistakes, and improving the features. Eventually we can trust the package more.

The lack of a readme indicates that any contributors will probably not be improving the features, but rather will be spending most of their time trying to understand the package. 

## ⚙️ Other tools

Code smell checkers is big business in the software engineering world. 

These tools are used to check the quality of code and help developers improve their code. They are also used by users to assess the quality of a package before using it. Such tools include:

- [Code Climate](https://codeclimate.com/)
- [Codacy](https://www.codacy.com/)
- [DeepSource](https://deepsource.io/)
- [CodeFactor](https://www.codefactor.io/)
- [SonarCloud](https://sonarcloud.io/)

⚠️ Currently there is no tool that does this for R packages in epidemiology. ⚠️

Many of these tools perform poorly, or are completely incompatible with R. This is why we need to build our own which will be owned by the community.

## 📦 Related projects

- [Mapping Research Software Landscapes through Exploratory Studies of GitHub Data](https://github.com/kequach/Thesis-Mapping-RS)
- [Augur: Python library and web service for Open Source Software Health and Sustainability metrics & data collection, by CHAOSS](https://chaoss.github.io/augur/)
- [rOpenSci's pkgcheck R package](https://github.com/ropensci-review-tools/pkgcheck)
