# Load packages
library(dplyr)
library(purrr)
library(readr)
library(here)
library(fs)

# First run the script "scripts/load_data.R"
# Get descriptions for all clinical codes
codelists_paths <- dir_ls(
  path = "codelists/",
  glob = "*.csv$"
)

# Create data frame with all codelists
code_descriptions <- codelists_paths %>%
  map(read_csv) %>%
  map(select, c(1, 2)) %>%
  map(rename, "snomedct_code" = 1, "code_description" = 2) %>%
  bind_rows(.id = "file_name") %>%
  select(2, 3) %>%
  mutate(snomedct_code = as.character(snomedct_code))

# Summarise clinical events
clinical_events_summary <- clinical_events |>
  left_join(code_descriptions) |>
  select(snomedct_code, code_description) |>
  group_by(snomedct_code, code_description) |>
  count() |>
  arrange(-n)

# Create folder for results
dir_create(here("results"))

# Write results
write_csv(clinical_events_summary, here("results", "clinical_events_summary.csv"))
