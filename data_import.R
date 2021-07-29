# Load data
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

mn_county_list <- mn_county_data %>% 
    select(county) %>% 
    rename(County = county) %>% 
    distinct() %>% 
    arrange(County)

min_date <- min(mn_state_data$date)
max_date <- max(mn_state_data$date)


