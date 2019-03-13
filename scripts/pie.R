# pie chart for site versus state
# load needed library
library(dplyr)
library(plotly)
library(plotrix)

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
  
  origin <- c(modified_data$age_adjusted_rate, modified_data$crude_rate)
  percentage <- round(origin / sum(origin) * 100, 1)
  pie3D(origin,
        labels = paste0(percentage, "%"),
        explode = 0.1, 
      main = "Pie Chart of Site VS State",
  col=c("#DAB72D","#764EC5"),
  mar = c(4.5, 4.5, 4.5, 4.5))
  legend("topright", c("Age Adjusted Rate", "Crude Rate"),
         fill = c("#DAB72D","#764EC5"))
}
