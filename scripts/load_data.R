# Load packages
library(readr)

# Delete everything in current global environment
rm(list = ls())

# Set working directory
setwd("~/Code/milanwiedemann/phc-coding-club/")

# Load data
patients <- read_csv("dummy_data/patients.csv",
  col_types = list(patient_id = "c")
)

clinical_events <- read_csv("dummy_data/clinical_events.csv",
  col_types = list(patient_id = "c", snomedct_code = "c", ctv3_code = "c")
)
