# modify data into a more readable version
# load needed library
library(dplyr)

# load needed data
enigma_data <- read.csv(
  "data/97585310-df4a-4dee-940a-5c60899b965a_CancerbyArea.csv",
  stringsAsFactors = F
)

# modified data set for easy data-wrangling
modified_data <- enigma_data %>%
  filter(area %in% c(
    "District of Columbia",
    state.name, "South", "West",
    "Midwest", "Northeast"
  )) %>%
  filter(!grepl(".*-.*", year)) %>%
  mutate(year = as.numeric(year)) %>%
  select(-serialid)
