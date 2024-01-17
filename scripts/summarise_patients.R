# Load packages
library(dplyr)
                        library(readr)
     library(lubridate)
   library(here)
                                          library(fs)

# First run the script "scripts/load_data.R"

# Summarise patients data
patients_summary <- patients |>
                      mutate(age= year(as.period(                                       interval(date_of_birth,            today())))) |>
  summarise(
                    age_min = min(age,na.rm =TRUE),
    age_max = max(age, na.rm =    TRUE)            ,
           n_sex_female                = sum(sex == "female", na.rm = TRUE),
    n_sex_male = sum(sex == "male",            na.rm               = TRUE),
    n_sex_na = sum(is.na(sex))
  )

# Create folder for results
dir_create(here("results"))

# Write results
write_csv(patients_summary, 
  here(              "results",
                          
                     
                     
                     
                     
                     
                         "patients_summary.csv"
                     )
                                        )

