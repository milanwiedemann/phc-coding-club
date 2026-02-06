# Exercises for Session 3 (03/03/2025)

These exercises will use the built-in R dataset `Orange`. This is a grouped dataset showing the growth of five orange trees at seven different points in time. To load this dataset, type `data("Orange")` into your R console, and then click on it when it appears in the environment.

* Exercise 1: The `age` column of the dataset represents the ages of the trees when measurements were taken as a number of days since the 31st of December 1968. Use `as.Date()` to create a new column called "date" which shows the date on which each measurement was recorded.

* Exercise 2: Try to add another column with the dates in a different format, using the `format()` function. What happens to the type of the variable when you do this?

* Exercise 3: Write a command to show all measurements that were taken after the year 1971.

* Exercise 4 (harder): Write a command that shows the tree with the largest circumference for each year (from 1969 to 1973). You may find it natural to do this using a loop, or as a function.

* Exercise 5 (harder): The trees in the sample dataset were not measured at regular intervals. Create your own table with a regular sequence of dates to take measurements on using `seq()`, for any number of trees you prefer. If you like, you may generate random data to populate your table with (but be sensible, remember that trees can't shrink in size). 