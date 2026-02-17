R workshop 3: Working with dates
================
2026-02-17

- [3.1: Introduction](#31-introduction)
- [3.2: How does R store dates?](#32-how-does-r-store-dates)
- [3.3: Date formatting](#33-date-formatting)
- [3.4: Date arithmetic](#34-date-arithmetic)
- [3.5: Date sequences and factors](#35-date-sequences-and-factors)
- [3.6: Some technical stuff](#36-some-technical-stuff)
- [3.7: Extracting date components with `lubridate` (and other things
  that package can
  do)](#37-extracting-date-components-with-lubridate-and-other-things-that-package-can-do)
- [3.8: Over to you!](#38-over-to-you)

## 3.1: Introduction

When working with data, dates are probably the third most common type of
variable you’ll encounter behind numbers and text. Dates are
intrinsically tough to work with for computers as they are highly
irregular in behaviour and formatting: if you have ever used dates in
Microsoft Excel you will know many of the things that can go wrong with
them. If you haven’t, I’ll be referring to a couple of Excel’s issues
with dates throughout. The aim of this workshop is to cover how R
handles dates and some handy things you can do to make your life easier
when working with them.

## 3.2: How does R store dates?

Dates in R are their own type of object. They look like strings, but
under the hood they are actually numbers. R, like many other programming
languages, stores a date as a number of days since the 1st of January
1970, with earlier dates than that being negative. If 1/1/1970 sounds
like an extremely arbitrary date to use as an index, that’s because it
is. Blame the people who programmed Unix 50-odd years ago.

As an aside, Excel (of course) does not use 1/1/1970 as its index date,
but either 31/12/1899 (on Windows), or 1/1/1904 (on MacOS), with
negative dates disallowed. Therefore, Excel files need to record which
operating system they were created on to make sure they work correctly
when moved from one computer to another. The fact that so much data is
handled by that software is honestly terrifying.

If you call `as.numeric()` on a date, you’ll get the raw number of days
since that time. Equally, you can call `as.Date()` on a number and R
will convert it to a date for you. Specifying the optional “origin”
argument in this function allows you to choose a date other than
1/1/1970 to use as the index. Note that the function `Sys.Date()`
returns today’s date, according to your computer’s clock.

``` r
Sys.Date() |> as.numeric()
```

    ## [1] 20501

``` r
#What date was exactly 10000 days after American Independence Day?
as.Date(10000, origin = "1776-07-04")
```

    ## [1] "1803-11-21"

## 3.3: Date formatting

You can choose which format R displays dates in, but the preferred one
is yyyy-mm-dd. To change a date from one format to another, use the
`Date` method of the `format()` function. You can call `as.Date()` on a
character string representing a date in an arbitrary format, provided
that you pass the format as an argument to the function. The format is
provided as a string with the following basic rules:

- Time units are represented by a single lowercase or uppercase letter
  preceded by a percentage sign.
- Time units can have arbitrary characters delimiting them (or none).
- The symbol for day and month as two-digit numbers are `%d` and `%m`.
- The symbol for a two-digit year is `%y`, while a four-digit year is
  `%Y`.
- To show the month as a word (in English) instead of a number, use `%b`
  (for the abbreviated name) or `%B` (for the full name). These names
  are also stored in the built-in constants `month.abb` and
  `month.name`.
- It’s possible to use non-English month names if you specify a
  different locale using `Sys.setlocale()`.

There are other symbols representing things like day of the week, week
number of the year (from 0 or 1 to 53), and day number of the year (from
1 to 366), but these are typically not used. Type `?strptime` into the R
console to see them all.

Here are some formatting examples to show you how it works:

``` r
formats <- c("%Y-%d-%m", "%y/%m/%d", "%d%b%Y", "%d %B %y", "%m|%d (%Y)")
sapply(formats, function(s) format.Date("1776-07-04", format = s))
```

    ##       %Y-%d-%m       %y/%m/%d         %d%b%Y       %d %B %y     %m|%d (%Y) 
    ##   "1776-04-07"     "76/07/04"    "04Jul1776"   "04 July 76" "07|04 (1776)"

## 3.4: Date arithmetic

You can perform some basic mathematical operations with dates. Adding a
number to a date produces another date, which is the date that number of
days later. Similarly, subtracting a number from a date produces the
date that number of days earlier.

``` r
#An alternate way of solving the Independence Day question from earlier
as.Date("1776-07-04") + 10000
```

    ## [1] "1803-11-21"

``` r
#What if we wanted the date 10000 days before instead?
as.Date("1776-07-04") - 10000
```

    ## [1] "1749-02-16"

Because dates have an underlying numeric value, you can compare them
using the operators `> < == != >= <=` and get the result you expect. Be
careful that you are actually using dates and not just their character
representations, though, because these operators work differently for
character variables than for numbers.

``` r
as.Date("1000-01-01") > as.Date("999-12-31")
```

    ## [1] TRUE

``` r
"1000-01-01" > "999-12-31" #Optional exercise: can you explain why this happens?
```

    ## [1] FALSE

You can also subtract one date from another to produce a different kind
of object known as a **difftime**. A difftime object consists of a
number and a unit, which if two dates are subtracted will be days. A
difftime’s unit must represent a constant length of time, so months and
years are not allowed. Difftimes consider a day to be exactly 24 hours
long, and therefore ignore daylight savings time. Because difftimes have
no origin, more arithmetic is possible with them alongside everything
you can do with dates. You can add difftimes together, multiply and
divide them by numeric vectors, and use some mathematical functions such
as `sum()`, `mean()`, `abs()`, and `sign()`.

``` r
#How many days ago was the new millennium?
Sys.Date() - as.Date("2000-01-01")
```

    ## Time difference of 9544 days

``` r
#Difftimes aren't restricted to integer numbers of days
as.difftime(10, units = "days")/(1:5)
```

    ## Time differences in days
    ## [1] 10.000000  5.000000  3.333333  2.500000  2.000000

## 3.5: Date sequences and factors

The `seq()` function can create regular sequences of dates as well as
numbers. The `seq()` method for dates has the same arguments as the one
for numbers (`from`, `to`, `by`, `length.out`, and `along.with`), and
they work mostly the same way. The one exception is `by`, which can be
specified as a number (which will be assumed to be in days), or as a
string which consists of an integer followed by one of “days”, “weeks”,
“months”, “quarters” or “years” (plural is optional). Let’s say you have
a recurring meeting which happens every two weeks starting a week from
now, and you want a vector of all meeting dates from then until six
months from now. You would do it like this:

``` r
meetings <- seq(from = Sys.Date()+7, to = Sys.Date()+6*31, by = "2 weeks") |> print()
```

    ##  [1] "2026-02-24" "2026-03-10" "2026-03-24" "2026-04-07" "2026-04-21"
    ##  [6] "2026-05-05" "2026-05-19" "2026-06-02" "2026-06-16" "2026-06-30"
    ## [11] "2026-07-14" "2026-07-28" "2026-08-11"

Similarly, `cut()` can transform a vector of dates into a factor, but
you need to specify a value for `breaks` the same way as for the `by`
argument with `seq()`. To demonstrate this, we’ll randomly generate a
vector of 100 numbers, turn them into dates, and then bin them by year.

``` r
rand_dates <- sample(10000, 100) |> as.Date() 
cut(rand_dates, breaks = "year") |> head()
```

    ## [1] 1973-01-01 1989-01-01 1987-01-01 1987-01-01 1997-01-01 1995-01-01
    ## 28 Levels: 1970-01-01 1971-01-01 1972-01-01 1973-01-01 ... 1997-01-01

We can also visualise date data with a histogram. `hist()` will accept a
vector of dates as its argument, but you need to use the same values for
`breaks` as with `cut()`.

``` r
hist(rand_dates, breaks = "year")
```

![](dates_files/figure-gfm/datehist-1.png)<!-- -->

## 3.6: Some technical stuff

If you are interested in the various edge cases in the calendar we
currently use and want to understand how R deals with them, read on.
Otherwise, feel free to skip this section.

R knows about leap years, and unlike Excel does not incorrectly say that
1900 was one (the story of why exactly Excel does this is pretty
fascinating, and the short version is for backwards compatibility with
another spreadsheet program from the 1980s that no longer exists).

``` r
try(as.Date("1900-02-29"))
```

    ## Error in charToDate(x) : 
    ##   character string is not in a standard unambiguous format

``` r
as.Date("2024-02-29")
```

    ## [1] "2024-02-29"

All dates from 1 AD onwards are assumed to be according to the Gregorian
calendar, even dates before it was adopted. However, R deviates from it
in having a year zero (but a month or day value of zero is not allowed).
Negative dates are also possible, but they look a bit odd.

``` r
as.Date(-1, origin = "0000-01-01")
```

    ## [1] "-001-12-31"

If a date format is not specified when using `as.Date()` on a string, R
automatically parses it as either yyyy-mm-dd or yyyy/mm/dd. If it can’t
make the string fit either of these, it throws an error. This is not
like Excel where the default parsing format is locale-specific, so it’s
much harder to accidentally input your dates “the wrong way around” in
R. European and American collaborators can also share R files without
risk of anything going wrong. See how R handles an extremely ambiguous
date (each number could be a day, a month, or a year):

``` r
as.Date("01-02-03")
```

    ## [1] "0001-02-03"

## 3.7: Extracting date components with `lubridate` (and other things that package can do)

What if you have a date variable and want to extract only the day (of
the month), month, or year from it? There are ways to do this in base R,
but they are not particularly intuitive. It’s best to use the package
`lubridate`, which has three conveniently named functions called
`day()`, `month()`, and `year()` that do exactly that. There are also
`wday()` to extract the day of the week and `yday()` to extract the day
of the year. One thing to note is that `year()` doesn’t work with
negative years.

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
day(meetings)
```

    ##  [1] 24 10 24  7 21  5 19  2 16 30 14 28 11

The extraction functions in `lubridate` can also be used for assignment.
If you wanted to change the year in your vector of meetings from this
year (2026) to next year (2027), you could do it like this:

``` r
year(meetings) <- 2027
meetings
```

    ##  [1] "2027-02-24" "2027-03-10" "2027-03-24" "2027-04-07" "2027-04-21"
    ##  [6] "2027-05-05" "2027-05-19" "2027-06-02" "2027-06-16" "2027-06-30"
    ## [11] "2027-07-14" "2027-07-28" "2027-08-11"

`lubridate` also has its own methods for generating date variables from
strings. `ymd()` is similar to R’s ordinary behaviour for parsing dates,
but there are five other functions that cover each possible permutation
of day, month, and year. The main difference from base R date parsing is
that these functions treat years less than 100 as abbreviations by
default (choosing the most recent year in the past that fits). See how
they handle the ambiguous date from before:

``` r
as.Date(sapply(c(ymd, ydm, myd, mdy, dmy, dym), function(f) f("01-02-03")))
```

    ## [1] "2001-02-03" "2001-03-02" "2002-01-03" "2003-01-02" "2003-02-01"
    ## [6] "2002-03-01"

Another base R function that has a `lubridate` equivalent is
`Sys.Date()`, which is the slightly easier to remember `today()`.

## 3.8: Over to you!

If you are comfortable with the explanations shown above and in any
other resources you’ve had a look at, feel free to move on to the
exercises for this session. They are located elsewhere in the GitHub
repository, and can be found by clicking the relevant link in the README
file. Happy coding!
