# Define server logic required to draw a histogram
server <- function(input, output) {
    thematic::thematic_shiny()
    output$county_plots <- renderPlot({
        
        filtered_counties <- mn_county_data %>% 
            filter(county %in% input$county_filter)
        
        minnesota_dates <- mn_county_data %>% 
            filter(date >= input$date_filter[1] & date<= input$date_filter[2])
        
        max_cases <- minnesota_dates %>% 
            top_n(1, cases_avg_per_100k)
        
        max_cases_filtered_counties <- filtered_counties %>%
            filter(date >= input$date_filter[1] & date<= input$date_filter[2]) %>% 
            top_n(1, cases_avg_per_100k)
        
        y_trim_amt <- ((100 - input$y_trim) / 100)
        
        
        ##################################################
        # GGPLOTS
        ##################################################
        
        p <- ggplot(mn_county_data,aes(x=date)) +
            
            geom_line(aes(y=cases_avg_per_100k, 
                          group = county),
                      alpha = .05,
                      show.legend = FALSE) +
            
            geom_line(data = filtered_counties,
                      aes(x = date,
                          y = cases_avg_per_100k,
                          color = county),
                      size = 1.5,
                      alpha = .85,
                      show.legend = TRUE) +
            
            scale_x_date(limits = c(input$date_filter[1], input$date_filter[2]),
                         labels = label_date_short(),
                         date_breaks = "1 month") +
            
            scale_y_continuous(limits = c(0,y_trim_amt*max_cases$cases_avg_per_100k)) +
            # theme_minimal() +
            ylab('7 Day Average Covid Cases per 100k') +
            xlab('') +
            theme(plot.title = element_text(size = 40),
                  axis.text.x=element_text(angle=0, hjust=1, size = 12),
                  axis.text.y=element_text(size=12),
                  axis.title.y = element_text(size = 16),
                  legend.title = element_text(size = 20),
                  legend.text = element_text(size = 16),
                  panel.grid.major.x = element_blank()) +
            
            guides(color=guide_legend(title="County"))
            
        
        state_level <- geom_line(data = mn_state_data,
                                 aes(x = date,
                                     y = cases_avg_per_100k),
                                 alpha = .45,
                                 size = 2)
        
        p + if(input$state_switch){state_level}
        
    })
}