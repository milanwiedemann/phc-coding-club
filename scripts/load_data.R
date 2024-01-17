# Load packages
library(readr)
library(here)

# Load data
patients <- read_csv(here("dummy_data", "patients.csv"),
  col_types = list(patient_id = "c")
)

clinical_events <- read_csv(here("dummy_data", "clinical_events.csv"),
  col_types = list(patient_id = "c", snomedct_code = "c", ctv3_code = "c")
)
