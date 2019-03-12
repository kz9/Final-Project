# pie chart for site versus state
# load needed library
library(tidyr)
library(dplyr)
library(plotly)
#library(plotrix)
library(ggplot2)

# function for pie chart
# state_pass: a string of state name
# site_pass: a string of site name
# min & max: year value
build_pie <- function(data, state_pass, site_pass, min, max){
  modified_data <- data %>%
    filter(area == state_pass) %>%
    filter(site == site_pass) %>%
    filter(year <= max, year >= min) %>%
    filter(race == "All Races") %>%
    summarise(
      age_adjusted_rate = sum(age_adjusted_rate, na.rm = T),
      crude_rate = sum(crude_rate, na.rm = T)
    )
  
  # bp <- ggplot(modified_data,
  #              aes(x="", y=values,
  #                  fill=c("Age Adjusted Rate", "Crude Rate")))+
  #   geom_bar(width = 1, stat = "identity")+
  #   coord_polar("y", start=0)+
  #   scale_fill_brewer(palette = "Blues")+
  #   theme_minimal()+
  #   labs(fill = "Features")
  # bp
  
  sum <- modified_data$age_adjusted_rate + modified_data$crude_rate +
    modified_data$total_population
  pie3D(c(modified_data$age_adjusted_rate,
               modified_data$crude_rate),
        labels = c("Age Adjusted Rate", "Crude Rate"),
      main = "Pie Chart of Site VS State")
}
