# sankey diagram
# load needed library
library(plotly)
library(dplyr)

# sankey drawing function
# state_pass: a list of state name
# race_pass: a list of race name
# sex_pass: a list of gender
# min & max: year value
# site_pass: a list of site name
build_sankey <- function(data, state_pass, race_pass, sex_pass,
                         min, max, site_pass) {
  # modified pass data for plot
  modified_data <- data %>%
    filter(area %in% state_pass) %>%
    filter(race %in% race_pass) %>%
    filter(sex %in% sex_pass) %>%
    filter(year >= min, year <= max) %>%
    filter(site %in% site_pass)

  label_list <- c(
    unique(modified_data$area), unique(modified_data$race),
    unique(modified_data$sex), unique(modified_data$site)
  )

  # table state vs race
  table_sr <- modified_data %>%
    group_by(area, race) %>%
    summarise(
      total_pop = sum(count, na.rm = T)
    ) %>%
    mutate(
      area_index = match(area, label_list) - 1,
      race_index = match(race, label_list) - 1
    )

  # table race vs sex
  table_rs <- modified_data %>%
    group_by(race, sex) %>%
    summarise(
      total_pop = sum(count, na.rm = T)
    ) %>%
    mutate(
      race_index = match(race, label_list) - 1,
      sex_index = match(sex, label_list) - 1
    )

  # table sex vs site
  table_ss <- modified_data %>%
    group_by(sex, site) %>%
    summarise(
      total_pop = sum(count, na.rm = T)
    ) %>%
    mutate(
      sex_index = match(sex, label_list) - 1,
      site_index = match(site, label_list) - 1
    )

  # make a sankey diagram
  p <- plot_ly(
    type = "sankey",
    node = list(
      label = label_list,
      color = "#764EC5",
      pad = 15,
      thickness = 10,
      line = list(
        width = 0.5
      )
    ),

    link = list(
      source = c(table_sr$area_index, table_rs$race_index, table_ss$sex_index),
      target = c(table_sr$race_index, table_rs$sex_index, table_ss$site_index),
      value = c(table_sr$total_pop, table_rs$total_pop, table_ss$total_pop),
      color = "#FFE669",
      label = c("Population flow", "Population flow", "Population flow")
    )
  ) %>%
    layout(
      font = list(
        size = 10
      )
    )
  p
}
