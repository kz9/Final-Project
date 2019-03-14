# line plot sex versus site
# load needed library
library(tidyr)
library(dplyr)
library(plotly)

# function for line plot
# data: a data frame
# sex_pass: a list of gender passed
# site_pass: a string of specific site
# min & max: year value
# option: population, age_adjust_rate, crude_rate
build_line <- function(data, sex_pass, site_pass, min, max, option) {
  # make data easy to plot
  modified_data <- data %>%
    filter(year >= min, year <= max) %>%
    filter(race == "All Races") %>%
    filter(site == site_pass) %>%
    group_by(sex, year) %>%
    summarise(count_item = sum(eval(sym(option)), na.rm = T)) %>%
    filter(sex %in% sex_pass) %>%
    spread(key = sex, value = count_item)

  # make line plot
  p <- plot_ly(data = modified_data, split = TRUE)
  for (i in 1:length(sex_pass)) {
    sex <- sex_pass[i]
    p <- add_trace(p,
      y = modified_data[[sex]], x = ~year,
      type = "scatter", mode = "markers+lines",
      name = sex_pass[i]
    ) %>%
      layout(colorway = c("#764EC5", "#DAB72D", "#969696"))
  }
  p
}
