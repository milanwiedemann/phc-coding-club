Session 1a: Basics of R (Appendices)
================
José Boue
2025-06-23

- [Appendix 1: Extra arguments for `read.table()` and
  `read.csv()`](#appendix-1-extra-arguments-for-readtable-and-readcsv)
- [Appendix 2: Writing to a .txt or .csv
  file](#appendix-2-writing-to-a-txt-or-csv-file)
- [Appendix 3: Reading files directly from the
  internet](#appendix-3-reading-files-directly-from-the-internet)
- [Appendix 4: Extra arguments for
  `rep()`](#appendix-4-extra-arguments-for-rep)
- [Appendix 5: The `seq()` function](#appendix-5-the-seq-function)
- [Appendix 6: The `subset()` function](#appendix-6-the-subset-function)
- [Appendix 7: Lists](#appendix-7-lists)
- [Appendix 8: `Inf` and `NaN`](#appendix-8-inf-and-nan)
- [Appendix 9: The `stringr` package](#appendix-9-the-stringr-package)
- [Appendix 10: Advanced uses of
  `rm()`](#appendix-10-advanced-uses-of-rm)
- [Appendix 11: While and repeat
  loops](#appendix-11-while-and-repeat-loops)
- [Appendix 12: Unfulfilled promises](#appendix-12-unfulfilled-promises)
- [Appendix 13: Anonymous functions and the `apply()`
  family](#appendix-13-anonymous-functions-and-the-apply-family)
- [Appendix 14: Dates](#appendix-14-dates)

## Appendix 1: Extra arguments for `read.table()` and `read.csv()`

Sometimes, when working with categorical data you will want the relevant
variables to imported into R as **factors** rather than basic strings.
You can do this by setting the argument `stringsAsFactors` to `TRUE` (by
default it is `FALSE`). A factor is simply R’s name for a categorical
variable, where there are only a set number of values (levels) it can
take that may or may not be ordered. When you import a variable as a
factor, all values that R sees are turned into its levels. Be careful,
as if a particular value is not present in the table R won’t add it as a
level.

The `sep` argument is what determines the character that R reads as
separating data values in the file. By default, it is empty in
`read.table()`, which means any whitespace character (tab, space,
newline, carriage return) will be read as a separator. You can set it to
a comma in order to read .csv files without using `read.csv()`, or a tab
(“\t”) to read tab-delimited files. The `read.csv()` function naturally
has the comma as its default separator. In some European countries the
comma is used in place of the decimal point and the semicolon as a
separator, so be sure to change the sep argument accordingly if you’re
working with files from Europe.

## Appendix 2: Writing to a .txt or .csv file

Like `read.table()` and `read.csv()`, there also exist `write.table()`
and `write.csv()` functions. These functions take a data frame and write
it to a specified file path. Other arguments include whether character
columns are quoted, the separator to use (`write.table()` only), whether
row and column names are to be included in the file, and the string to
use to denote missing values.

## Appendix 3: Reading files directly from the internet

In addition to ordinary file paths, `read.table()` and `read.csv()` also
accept URLs. This allows you to import a table hosted online (as a text
file, ordinary web pages won’t work) without having to download it to
your computer. Using this trick can make it easier for other people to
run your code, although it has quite a severe restriction in that any
file you use it on has to be publicly accessible.

## Appendix 4: Extra arguments for `rep()`

The `rep()` function actually has three possible arguments that can come
after the vector you want to replicate. The first is `times`, which just
determines how many times you repeat it. By default, this is the
argument that any number coming after the vector will be fed into. If
you want to access the other two arguments, you need to spell them out.
The other two arguments are `each`, which repeats each individual
element of the vector for the specified number of times in sequence, and
`length.out`, which repeats the whole vector until a specified length is
reached (it can cut it off in order to do so). Let’s see what the code
looks like:

``` r
my_vector <- c(1,2,3)
rep(my_vector, each=2)
```

    ## [1] 1 1 2 2 3 3

``` r
rep(my_vector, length.out=7)
```

    ## [1] 1 2 3 1 2 3 1

## Appendix 5: The `seq()` function

Like the `:` operator, `seq()` defines a vector that contains a sequence
of numbers. It has four arguments: `from`, `to`, `by`, and `length.out`.
The first two determine where the sequence starts and ends, while `by`
determines the difference between successive members of the sequence and
`length.out` the length the sequence should have. Only one of the last
two arguments should be specified, as the value of one uniquely
determines the other. There are variants of `seq()` that require fewer
arguments, such as `seq_along()`, which when given a vector returns a
sequence from 1 to its length. This is not exactly the same as using
`1:length(v)`, because `1:0` produces a vector equal to `c(1,0)` instead
of a zero-length vector, so `seq_along()` is useful in this case for
avoiding unintended behaviour.

## Appendix 6: The `subset()` function

This function can be applied to vectors, matrices, or data frames. In
its simplest form, it takes as its second argument a logical expression
that indicates which elements to keep. This is mostly equivalent to
using square brackets with a logical expression inside, although unlike
that method `subset()` treats missing entries as `FALSE`. If you use
`subset()` on a matrix or data frame, you can specify another argument,
`select`, that lets you choose which columns to keep by referencing
their names. You can put a `-` in front to drop them instead.

## Appendix 7: Lists

Lists may seem intimidating, but they’re not actually that difficult to
use. They can take up a lot of space, however. The way to generate a
list is much the same as for a vector, only instead of `c()` you use the
`list()` function. You can also name each element of your list like you
would do with a data frame. Appending an object to a list is done using
the `c()` function, but you need to be careful when doing this as mixing
lists and vectors can lead to unintended behaviour. For best results,
turn the object you want to add into a length-1 list before using `c()`.

Extracting single elements from a list is done using the **double square
brackets** `[[]]`. You can use the single square brackets as well, but
this creates a list of length 1 that contains the object you want rather
than extracting the object itself. If you want to extract the first
element of a vector which is itself the first element of a list, the
syntax would look like this:

``` r
my_list[[1]][1]
```

If your list elements are named, you can also use the dollar sign
operator `$` to reference them like you would with a data frame. You can
actually use the double square brackets with data frames as well because
a data frame is essentially a two-dimensional list, but this is usually
not necessary.

## Appendix 8: `Inf` and `NaN`

If you have used another programming language before, you probably know
what `Inf` and `NaN` are and the difference between them. If not, don’t
worry. `Inf` simply means **“infinity”**, which often is not actually
infinite but shorthand for “bigger than any number R is capable of
calculating”. For example, attempting to divide a number by zero will
return `Inf`, but you also might get `(0,Inf)` as a confidence interval
if your statistical model takes too long to converge. `-Inf` is the same
but negative. `NaN` stands for **“Not a Number”**, which means that if a
calculation returns it the answer likely doesn’t even exist. For
example, attempting to divide 0 by 0 or taking the tangent of $\pi/2$
will produce `NaN`. R will give you a warning message whenever `NaN`
shows up, as when this happens something has usually gone badly wrong.

While calculations involving `NaN` are inadvisable to perform, `Inf` and
`-Inf` are relatively well-behaved and can be used in ordinary code
without causing issues. For example, the `cut()` function will convert a
numeric vector into a factor by binning, where the bins are specified
using the `breaks` argument. If you want the first or last bin to be
open-ended (or both!), which is common for certain variables such as
age, you can specify Inf as the upper limit or -Inf as the lower one.
You may not expect that to work, but it does!

## Appendix 9: The `stringr` package

Unlike traditional programming languages, base R does not have an easy
way to manipulate strings. The most basic objects that R is designed to
work with are vectors and matrices which are typically numeric, so it
makes up for its strength in dealing with these with a weakness in
dealing with strings. The `stringr` package is designed to address this
issue by introducing simple functions for manipulating strings, the most
useful of which in my opinion is `str_glue()`.

This function can concatenate multiple input strings into a new string
rather than a vector, and adding the `.sep` argument allows you to
choose a separator to place in between them. But the real magic of
`str_glue()` is its ability to insert variable values directly into
strings. If you enclose the name of a variable with curly brackets `{}`,
`str_glue()` will render it as that variable’s value. Therefore, you can
change an input or output string simply by changing a variable rather
than having to fiddle around with the string itself.

There are many other nice functions in the `stringr` package, but most
of them make use of **regular expressions**. This is a topic which is
too big and too complex to fit in this appendix, so expect to see an
entire sheet dealing with it.

## Appendix 10: Advanced uses of `rm()`

Although `rm()` was one of the earliest things you encountered in the
main document, its more advanced options have been left relatively late
here, as you will need to read the preceding appendices to understand
them. If you want to remove multiple objects at once, the most basic way
to do this is to pass a vector of their names. There are two ways to do
this:

``` r
rm(var1,var2,var3)
rm(list=c(var1, var2, var3))
```

Note that you if you’re not writing out the names of the variables in
full, you will need to use the `list` argument rather than the default.
The list argument is useful for removing a pre-defined vector of
variables to save time writing them out.

If you have a lot of variables you need to get rid of, or if their names
are quite long, any method that involves listing them all in full is
inconvenient. You can make life easier for yourself using another
special function, `ls()`. When run with no argument, this returns a
vector of the names of all objects in the environment, so the following
code will clear it completely:

``` r
rm(list=ls())
```

You can do the same thing by clicking the broom icon above the
environment, which is better because it asks you to confirm before
deleting everything. Also, putting the above line in your actual code
file is a very bad idea, as it can give anyone else who runs your code a
very nasty surprise if they’re not expecting all their data to get nuked
without warning. If you must run it, do it from the console.

However, `ls()` is very powerful when used with a bit more finesse. It
has an argument, `pattern`, which can take an ordinary string or, if
you’re feeling brave, a regular expression. To show you how it works,
the following code will remove all objects that have the substring “var”
in their names, achieving the same effect as the basic code you saw
earlier:

``` r
rm(list=ls(pattern="var"))
```

Of course, you need to be smart with naming your objects if you want to
make full use of this.

## Appendix 11: While and repeat loops

**While** loops are very close to if statements in their syntax. They
also use a logical expression as their condition, but can evaluate it
more than once. If the condition is `TRUE`, the loop will execute the
code contained in its body, then after this has finished it will check
the condition again. If it is still `TRUE`, the body will execute again,
otherwise the loop will terminate. Unlike for loops, while loops can
potentially run forever without halting, which means they require more
caution to use. In order to terminate a while loop, you will need to
either include code in the body that can set the condition to `FALSE`,
or use the `break` command. This command terminates the loop it’s in,
and passes to the next line of code below it. Here is an example of a
while loop that uses an if statement to decide whether to break:

``` r
while(n>0){
  if(is.integer(n)){
    n <- n-1
  }
  else break
}
```

This code is designed to take a positive integer n and decrement it by 1
repeatedly until it reaches 0. If n is not an integer, the loop will
break instead of passing an invalid input.

A **repeat** loop is identical to a while loop, but with no condition:
the only way to terminate it is by manually breaking it. If it is part
of a function, you can break it with a `return()` command. You can
achieve the same effect as a repeat loop by writing `while(TRUE)`.

## Appendix 12: Unfulfilled promises

So far, it has been stated that an empty data frame can easily be filled
using a loop, the `read.table()` and `read.csv()` functions can be
looped to import multiple files without much effort, and that
`str_glue()` is excellent for modifying input strings. No examples for
any of these have been given, because it is best to demonstrate them all
together. Consider a folder called big_folder containing files named
file_1.csv, file_2.csv, and so on up to file_100.csv. Importing all of
these files and combining them into a single data frame, assuming that
they all have the same number of columns, is not nearly as onerous as it
would appear. All that is needed is to create an empty data frame, then
write a loop that binds each file onto it in succession:

``` r
my_df <- data.frame()
for(i in 1:100){
  my_df <- rbind(my_df, read.csv(str_glue("C:/Users/me/Documents/big_folder/file_{i}.csv")))
}
```

## Appendix 13: Anonymous functions and the `apply()` family

If you know about lambda expressions in languages like Python, you will
remember that their main use is to allow functions to be used without
naming them, which can save a bit of space. In R, the standard method of
defining functions can be used the same way. If you have a function that
takes the name of another function as one of its arguments, you need not
define that function outside it: you can simply write the definition
inline, and it will work. The most common functions you will use this
with are the `apply()` family, which let you (depending on which
`apply()` function you use) take a vector, list or even a matrix and
apply a function element-wise to it that doesn’t normally work that way
without going to the trouble of writing a loop. For more on the
`apply()` family and anonymous functions, see the “Writing concise code”
reference sheet.

## Appendix 14: Dates

There are no references to dates in the main document, but I figure
they’re important enough to include here anyway. Under the hood, R
stores a date as a number of days since the 1st of January 1970, with
earlier dates than that being negative. You can choose which format R
displays dates in, but the preferred one is yyyy-mm-dd. You can perform
some basic mathematical operations with dates. Adding a number to a date
produces the date that number of days later, and subtracting it produces
the date that number of days earlier. You can also subtract one date
from another to produce an object known as a **difftime**. A difftime is
simply a number of days with no index date, meaning that you can now add
them together and even multiply and divide them by numeric vectors. Most
functions won’t accept difftimes or dates when they expect numbers,
though, so if you’re using time-series data you may need to convert them
to standard numeric objects before running certain models.
