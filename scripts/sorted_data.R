# modify data into a more readable version
# load needed library
library(dplyr)

# load needed data
#brainbysite <- read.csv("data/BRAINBYSITE.csv", stringsAsFactors = F)
#byage <- read.csv("data/BYAGE.csv", stringsAsFactors = F)
#byarea <- read.csv("data/BYAREA.csv", stringsAsFactors = F)
#byarea_county <- read.csv("data/BYAREA_COUNTY.csv", stringsAsFactors = F)
#bysite <- read.csv("data/BYSITE.csv", stringsAsFactors = F)
childbyage_adj <- read.csv("data/CHILDBYAGE_ADJ.csv", stringsAsFactors = F)
childage_cr <- read.csv("data/CHILDBYAGE_CR.csv", stringsAsFactors = F)
childbysite <- read.csv("data/CHILDBYSITE.csv", stringsAsFactors = F)
enigma_data <- read.csv(
  "data/97585310-df4a-4dee-940a-5c60899b965a_CancerbyArea.csv",
  stringsAsFactors = F)

# modified data set for easy data-wrangling
modified_data <- enigma_data %>%
  filter(area %in% c("District of Columbia",
                      state.name, "South", "West",
                      "Midwest", "Northeast")) %>%
  filter(!grepl(".*-.*", year)) %>%
  mutate(year = as.numeric(year))
