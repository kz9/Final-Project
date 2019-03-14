# modify data into a more readable version
# load needed library
library(dplyr)

# load needed data
#childbyage_adj <- read.csv("data/CHILDBYAGE_ADJ.csv", stringsAsFactors = F)
#childage_cr <- read.csv("data/CHILDBYAGE_CR.csv", stringsAsFactors = F)
#childbysite <- read.csv("data/CHILDBYSITE.csv", stringsAsFactors = F)
enigma_data <- read.csv(
  "data/97585310-df4a-4dee-940a-5c60899b965a_CancerbyArea.csv",
  stringsAsFactors = F)

# modified data set for easy data-wrangling
modified_data <- enigma_data %>%
  filter(area %in% c("District of Columbia",
                      state.name, "South", "West",
                      "Midwest", "Northeast")) %>%
  filter(!grepl(".*-.*", year)) %>%
  mutate(year = as.numeric(year)) %>%
  select(-serialid)

## Asian/Pacific Islander and American Indian/Alaska Native don't have
## All Cancer Sites Combined value needs to be fixed
## All Cancer Sites Combined value for both race
# for (i in 1:length(unique(modified_data$area))) {
#   for (k in 1:length(unique(modified_data$year))) {
#     for (j in 1:length(unique(modified_data$sex))) {
#       for (w in 1:length(unique(modified_data$event_type))){
#         x <- modified_data %>%
#           filter(event_type == unique(modified_data$event_type)[w]) %>%
#           filter(sex == unique(modified_data$sex)[j]) %>%
#           filter(year == unique(modified_data$year)[k]) %>%
#           filter(area == unique(modified_data$area)[i]) %>%
#           filter(race == c("Asian/Pacific Islander",
#                            "American Indian/Alaska Native")) %>%
#           group_by(race) %>%
#           summarise(
#             area = unique(area),
#             age_adjusted_ci_lower = sum(age_adjusted_ci_lower, na.rm = T),
#             age_adjusted_ci_upper = sum(age_adjusted_ci_upper, na.rm = T),
#             age_adjusted_rate = sum(age_adjusted_rate, na.rm = T),
#             count = sum(count, na.rm = T),
#             event_type = unique(event_type),
#             population = sum(population, na.rm = T),
#             sex = unique(sex),
#             site = "All Cancer Sites Combined",
#             year = unique(year),
#             crude_ci_lower = sum(crude_ci_lower, na.rm = T),
#             crude_ci_upper = sum(crude_ci_lower, na.rm = T),
#             crude_rate = sum(crude_rate, na.rm = T)
#           )
#         modified_data <- modified_data %>%
#           bind_rows(x)
#       }
#     }
#   }
# } 
