# Solutions for session 1

## `here`: Create paths relative to the top-level directory

> Using the `setwd()` command in your R scripts helps you to set the working directory. This makes it easier for you to refer to describe where your files (e.g., another R script or a CSV data file) are located on your computer. But it also comes with many disadvantages, mainly that it has the side effect that this makes the code only work on your computer because it depends on the folder structure and names on your computer.  A more detailed summary of the problems are described in the section 'What’s wrong with `setwd()`?' in [this blog post](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/). A better alternative is to organise each project (e.g., all analyses for a specific research project) into a folder on your computer. This folder is the top-level directory of your project, for example the folder `phc-coding-club` is the name of top-level directory of this project. Each path used in scripts in your project should be relative to this working directory – the `here` package will help you with that.

* Solution 1: Use the `here` package to replace `setwd()`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/5ed9ec77b5372f616c1878419a066e9c66d4981c
  
## `lintr` and `styler`: Set, check, and fix code style

> "Good coding style is like correct punctuation: you can manage without it, butitsuremakesthingseasiertoread." This quote comes from [The tidyverse style guide](https://style.tidyverse.org/) and describes the main motivation behind code style.

* Solution 2: Check the code style using `lintr`
  * Run: `lintr::lint_dir(".")`
* Solution 3: Fix the code style using `styler`
  * Run: `styler::style_dir(".")`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/abd1ec3f65c40114383266e5403ac838f15a03e5

## `usethis`: Add licence to repository

> If you intend to make your code publicly available (e.g., on GitHub) it is a good idea to add a licence that specifies how you want your code to be used by someone else. More on this can be found in the book [R Packages (2e) - Licensing](https://r-pkgs.org/license.html).

* Solution 4: Add MIT licence to this project repository
  * Run: `install.packages("usethis")`
  * Run: `usethis::use_mit_license()`
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/d76511fe7caacf648218baf56bcba3e0c441b319

## Anything else?

> There is at least one more problematic coding practice in this project. More details of the problem can be found in the section 'What’s wrong with `rm(list = ls())`?' in [this blog post](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/).

* Solution 5: Improve anything else that suggests a sub-optimal workflow
  * Remove `rm(list = ls())` from `scripts/load_data.R` and make sure you follow advice in https://r4ds.had.co.nz/workflow-projects.html
  * Code changes: https://github.com/milanwiedemann/phc-coding-club/pull/2/commits/06f1be00579ad4ecec71f2ebdbcf37bed26a5f9a