setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('init.R')
source('data_import.R')

shiny::runApp(
    getwd()
)

