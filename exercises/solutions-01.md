# Solutions for session 1

## `renv`: Set-up reprodicuble project environment

* Solution 1: Update all packages to the newest version
  * Run: `renv::update()`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/86ff3a599483a6715fbbfc7d8710e7197365161b

## `here`: Create paths relative to the top-level directory

* Solution 2: Use the `here` package to replace `setwd()`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/5ed9ec77b5372f616c1878419a066e9c66d4981c
  
## `lintr` and `styler`: Set, check, and fix code style

* Solution 3: Check the code style using `lintr`
  * Run: `lintr::lint_dir(".")`
* Solution 4: Fix the code style using `styler`
  * Run: `styler::style_dir(".")`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/abd1ec3f65c40114383266e5403ac838f15a03e5

## `usethis`: Add licence to repository

* Solution 5: Add MIT licence to this project repository
  * Run: `renv::install("usethis")`
  * Run: `usethis::use_mit_license()`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/d76511fe7caacf648218baf56bcba3e0c441b319

## Anything else?

* Solution 6: Improve anything else that suggests a sub-optimal workflow
  * Remove `rm(list = ls())` from `scripts/load_data.R` and make sure you follow advice in https://r4ds.had.co.nz/workflow-projects.html
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/06f1be00579ad4ecec71f2ebdbcf37bed26a5f9a