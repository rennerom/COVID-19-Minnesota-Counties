# covid_us_counties<- read.csv("~/Documents/R/COVID/covid-19-data/rolling-averages/us-counties.csv")
# 
# us.states <- read.csv("~/Documents/R/COVID/covid-19-data/rolling-averages/us-states.csv")

mn_county_data<- read.csv("~/Documents/R/COVID/covid-19-data/rolling-averages/us-counties.csv") %>% 
    tibble() %>% 
    filter(state=='Minnesota') %>% 
    mutate(date=as.Date(date)) %>% 
    mutate(across(where(is.numeric), ~replace_na(.x, 0)))

mn_state_data <- read_csv(url("https://raw.githubusercontent.com/rennerom/covid-19-data/master/rolling-averages/us-states.csv")) %>% 
    tibble() %>% 
    filter(state=='Minnesota') %>% 
    mutate(date=as.Date(date)) %>% 
    mutate(across(where(is.numeric), ~replace_na(.x, 0)))

# minnesota <- us.states %>% 
#     tibble() %>% 
#     filter(state=='Minnesota') %>% 
#     mutate(date=as.Date(date))
# 
# minnesota_counties <- covid_us_counties %>% 
#     tibble() %>% 
#     filter(state=='Minnesota') %>% 
#     mutate(date = as.Date(date))

mn_county_list <- mn_county_data %>% 
    select(county) %>% 
    rename(County = county) %>% 
    distinct() %>% 
    arrange(County)

# mn_county_list <- minnesota_counties %>% 
#     select(county) %>% 
#     rename(County = county) %>% 
#     distinct() %>% 
#     arrange(County)
# 
# min_date <- min(minnesota$date)
# max_date <- max(minnesota$date)

min_date <- min(mn_state_data$date)
max_date <- max(mn_state_data$date)


