# Load data

#get current year data
mn_county_2022 <-  read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/rolling-averages/us-counties-2022.csv") %>%
    tibble() %>%
    filter(state=='Minnesota') %>%
    mutate(date=as.Date(date)) %>%
    mutate(across(where(is.numeric), ~replace_na(.x, 0)))

#append current year data to 2020 and 2021 (requires plyr)
data_dir = "data"
raw_data = list.files(path=data_dir, pattern="*.csv", full.names=TRUE)
data_csv = plyr::ldply(raw_data, read_csv) %>% tibble()
mn_county_data <- dplyr::bind_rows(data_csv, mn_county_2022) %>%
    filter(!county %in% c('unknown','Unknown'))

#get state data
mn_state_data <- read_csv(url("https://raw.githubusercontent.com/nytimes/covid-19-data/master/rolling-averages/us-states.csv")) %>%
    tibble() %>%
    filter(state=='Minnesota') %>%
    mutate(date=as.Date(date)) %>%
    mutate(across(where(is.numeric), ~replace_na(.x, 0)))

mn_county_list <- mn_county_data %>%
    select(county) %>%
    dplyr::rename(County = county) %>%
    distinct() %>%
    arrange(County)

min_date <- min(mn_state_data$date)
max_date <- max(mn_state_data$date)

# clean up
objects_to_remove <- c("data_dir",
                       "raw_data",
                       "mn_county_2022",
                       "data_csv")
rm(list = objects_to_remove)


