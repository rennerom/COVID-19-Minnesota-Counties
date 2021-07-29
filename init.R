# required packages
packages = c("tidyverse",
             "lubridate",
             "scales",
             "shiny",
             "shinyWidgets")

# check if each package is on the local machine
# if a package is installed, it will be loaded
# if any are not, the missing package(s) will be installed and loaded

init_packages = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
    }
}

package.check <- lapply(packages, init_packages)

