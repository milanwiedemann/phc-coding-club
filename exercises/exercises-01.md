# Exercises for session 1

## `renv`: Set-up reprodicuble project environment

* Exercise 1: Update all packages to the newest version

## `here`: Create paths relative to the top-level directory
Commonly, scripts in R start with a `set_wd()` command. R users use the command
to tell R where to find the working directory, e.g. a directory where data is 
saved that is loaded in the R script. This has the desired effect for the author 
of the script, but the chance of the `set_wd()` command having the desired 
effect for anyone besides the author is 0%. For reference, see section 'What’s 
wrong with setwd()?'
[in this blog](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/). It is 
therefore always recommended to organise each project (e.g. all analyses for a 
specific research project) into a folder on your computer. This folder is the 
top-level directory of your project. Each path used in scripts in your 
project should be relative to this working directory. To build paths relative to 
your working directory, you can use the `here` package.

* Exercise 2: Use the `here` package to replace each occurrence of `setwd()` in 
the phc-coding-club project. Use the 'Find in Files' function to find 
occurrences of `setwd()` in this project.

## `lintr` and `styler`: Set, check, and fix code style

* Exercise 3: Check the code style using `lintr`
* Exercise 4: Fix the code style using `styler`

## `usethis`: Add licence to repository

* Exercise 5: Add MIT licence to this project repository

## Anything else?

* Exercise 6: Improve anything else that suggests a sub-optimal workflow
