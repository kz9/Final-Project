# setup map function
# load needed library
library(dplyr)
library(plotly)
library(stringr)

# function for map
# data: a data frame
# option: population, age_adjust_rate, crude_rate
# min & max: year value
build_map <- function(data, option, min, max) {
  # modify data for easier map plot
  modified_data <- data %>%
    filter(area %in% c("District of Columbia", state.name)) %>%
    filter(year >= min, year <= max) %>%
    filter(sex %in% "Male and Female") %>%
    filter(race %in% "All Races") %>%
    filter(site %in% "All Cancer Sites Combined") %>%
    mutate(code = ifelse(area == "District of Columbia", "DC",
      state.abb[match(area, state.name)]
    )) %>%
    group_by(code) %>%
    summarise(count_item = ifelse(option == "count",
      sum(eval(sym(option)), na.rm = T),
      mean(eval(sym(option)), na.rm = T)
    )) %>%
    arrange(-count_item)
  # setup hover text
  modified_data$hover <- with(
    modified_data,
    paste(
      state.name[match(code, state.abb)],
      "<br>", option, ":", count_item
    )
  )

  # specify some map projection/options
  g <- list(
    scope = "usa",
    projection = list(type = "albers usa"),
    showlakes = TRUE,
    lakecolor = toRGB("white")
  )
  p <- plot_geo(modified_data, locationmode = "USA-states") %>%
    add_trace(
      z = ~count_item,
      text = ~hover,
      locations = ~code,
      color = ~count_item, colors = "Purples"
    ) %>%
    colorbar(title = str_to_title(gsub("_", " ", option))) %>%
    layout(
      title = str_to_title(gsub("_", " ", option)),
      geo = g
    )
  p
}
