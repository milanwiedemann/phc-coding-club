data("Orange")
force(Orange)

#Exercise 1
Orange$date <- as.Date(Orange$age, origin = "1968-12-31")

#Exercise 2
#For example...
Orange$date2 <- format.Date(Orange$date, format = "%Y/%m/%d")
#The new variable is just a character variable and not a date variable

#Exercise 3
#Lubridate version
library(lubridate)
subset(Orange, year(date) > 1971)
#Base R version
subset(Orange, date > as.Date("1971-12-31"))

#Exercise 4
#Looping version
for (y in 1969:1973) {
  cat(y, "\n")
  Orange |>
    subset(year(date) == y) |>
    subset(circumference == max(circumference)) |>
    subset(select = "Tree") |>
    print(row.names = FALSE)
}

#Functional version
maxperyear <- function(y) {
  Orange |>
    subset(year(date) == y) |>
    subset(circumference == max(circumference)) |>
    subset(select = "Tree") |>
    setNames(y) |>
    unlist()
}
sapply(1969:1973, maxperyear)

#Exercise 5
measuredates <- seq(from = today(), by = "year", length.out = 7)
trees_custom <- data.frame("tree" = rep(1:5, each = 7),
                           "date" = rep(measuredates, times = 5))

#Optional random data generation
gen_circumferences <- function(ndates) {
  #Assume yearly growth has a uniform distribution between 10 and 50cm
  cumsum(runif(ndates, 10, 50))
}

trees_custom$circumference <- as.vector(replicate(5, gen_circumferences(7)))