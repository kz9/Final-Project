# line plot sex versus site
# load needed library
library(tidyr)
library(dplyr)
library(plotly)

# function for line plot
# data: a data frame
# race_pass: a list of race passed
# site_pass: a string of specific site
# min & max: year value
# option: population, age_adjust_rate, crude_rate
build_bar <- function(data, race_pass, site_pass, min, max, option) {
  # make data easy to plot
  modified_data <- data %>%
    filter(year >= min, year <= max) %>%
    filter(sex == "Male and Female") %>%
    filter(site == site_pass) %>%
    group_by(race, year) %>%
    summarise(count_item = sum(eval(sym(option)), na.rm = T)) %>%
    filter(race %in% race_pass) %>%
    spread(key = race, value = count_item)

  # make bar plot
  p <- plot_ly(data = modified_data, split = TRUE)
  for (i in 1:length(race_pass)){
    race <- race_pass[i]
    p <- add_trace(p, y=modified_data[[race]], x=~year,
                   type="bar",
                   name=race_pass[i]) %>%
                   layout(colorway = c('#764EC5', '#7DD1F0', '#B4B3AE', '#B0E063', '#FF6369', '#FFE669'))
  }
  p
}
