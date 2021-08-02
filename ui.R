# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = bslib::bs_theme(bootswatch = "minty"),
    # Application title
    titlePanel("COVID-19 in Minnesota"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(width = 3,
                     tags$head(tags$style(HTML('.irs-from, .irs-to, .irs-min, .irs-max, .irs-single {
            visibility: hidden !important;
    }'))),
                     tags$head(tags$style("#county_plots{height:90vh !important;}")),
                     selectizeInput(
                         inputId = 'county_filter',
                         label = 'Select County:',
                         choices = c("", mn_county_list),
                         selected = NULL,
                         multiple = TRUE, # allow for multiple inputs
                         options = list(create = FALSE) # if TRUE, allows newly created inputs
                     ),
                     dateRangeInput(inputId = "date_filter", 
                                    label = "Date Filter", 
                                    start = min_date,
                                    end = max_date, 
                                    min = min_date, 
                                    max = max_date,
                                    format = "m/d/yy"
                     ),
                     br(),
                     sliderInput(inputId = "y_trim", 
                                 label = "Zoom y-axis in/out", 
                                 min = 0, 
                                 max = 100, 
                                 value = 0,
                                 ticks = FALSE),
                    br(),
                    prettySwitch(
                        inputId = "state_switch",
                        label = "Show State level data",
                        value=TRUE,
                        fill = TRUE
                     )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(width = 9,
                  plotOutput("county_plots")
        )
    )
)