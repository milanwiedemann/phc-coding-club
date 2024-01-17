# Solutions for session 1

## `renv`: Set-up reprodicuble project environment

* Solution 1: Update all packages to the newest version
  * Run: `renv::update()`
  * Code changes: 

## `here`: Create paths relative to the top-level directory

* Solution 2: Use the `here` package to replace `setwd()`
  * Code changes:
  
## `lintr` and `styler`: Set, check, and fix code style

* Solution 3: Check the code style using `lintr`
  * Run: `lintr::lint_dir(".")`
* Solution 4: Fix the code style using `styler`
  * Run: `styler::style_dir(".")`
  * Code changes:

## `usethis`: Add licence to repository

* Solution 5: Add MIT licence to this project repository
  * Run: `renv::install("usethis")`
  * Run: `usethis::use_mit_license()`
  * Code changes:

## Anything else?

* Solution 6: Improve anything else that suggests a sub-optimal workflow
  * Remove `rm(list = ls())` from `scripts/summarise_clinical_events.R` and make sure you follow advice in https://r4ds.had.co.nz/workflow-projects.html
  * Code changes: