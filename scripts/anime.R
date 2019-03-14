# animation function
## load needed library
library(plotly)

# build animation
# data: passed data set
# option: the rate that client choose to observe
build_animation <- function(data, option) {
  modified_data <- data %>%
    filter(area %in% c("District of Columbia", state.name)) %>%
    filter(sex %in% "Male and Female") %>%
    filter(race %in% "All Races") %>%
    filter(site %in% "All Cancer Sites Combined") %>%
    select(area, year, population, count, option) %>%
    group_by(area, year) %>%
    summarise(
      total_pop = sum(population, na.rm = T),
      total_cancer = sum(count, na.rm = T),
      total_option = mean(eval(sym(option)), na.rm = T)
    )

  # setup animation
  p <- modified_data %>%
    plot_ly(
      x = ~total_cancer,
      y = ~total_option,
      size = ~total_pop,
      color = ~area,
      colors = "Spectral",
      frame = ~year,
      text = ~area,
      hoverinfo = "text",
      type = "scatter",
      mode = "markers"
    ) %>%
    layout(
      xaxis = list(
        type = "log",
        title = "Cancer Patient Population"
      ),
      yaxis = list(
        type = "log",
        title = gsub("_", " ", option)
      )
    ) %>%
    animation_button(
      x = 1, xanchor = "right", y = 0, yanchor = "bottom"
    )
  p
}
