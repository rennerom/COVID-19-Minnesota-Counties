# required packages

packages = c("tidyverse",
             "lubridate",
             "scales",
             "shiny",
             "shinyWidgets",
             "shinythemes",
             "thematic",
             "bslib")

# check if each package is on the local machine
# if a package is installed, it will be loaded
# if any are not, the missing package(s) will be installed and loaded

init_packages = function(x) {
    if (!require(x, character.only = TRUE)) {
        suppressWarnings(install.packages(x, dependencies = TRUE, quietly = TRUE))
        suppressPackageStartupMessages(library(x, character.only = TRUE, quietly = TRUE))
    }
}

package.check <- lapply(packages, init_packages)
