Sheet 1: The Very Basics of R for Data Analysis
================
José Boue
2025-10-23

- [1.1: What is R?](#11-what-is-r)
- [1.2: What isn’t R?](#12-what-isnt-r)
- [1.3: Where does R keep your data?](#13-where-does-r-keep-your-data)
- [1.4: How do you tell R to store
  something?](#14-how-do-you-tell-r-to-store-something)
- [1.5: How do you import data from a
  file?](#15-how-do-you-import-data-from-a-file)
- [1.6: How do you manipulate your
  data?](#16-how-do-you-manipulate-your-data)
- [1.7: How do you manipulate
  vectors?](#17-how-do-you-manipulate-vectors)
- [1.8: Using mathematical operators with
  vectors](#18-using-mathematical-operators-with-vectors)
- [1.9: Working with data frames](#19-working-with-data-frames)
- [1.10: Assembling data frames from
  scratch](#110-assembling-data-frames-from-scratch)
- [1.11: Using square brackets](#111-using-square-brackets)
- [1.12: Logical operators](#112-logical-operators)
- [1.13: Basic control flow](#113-basic-control-flow)
- [1.14: Custom functions](#114-custom-functions)
- [1.15: Where should you go if you have further
  questions?](#115-where-should-you-go-if-you-have-further-questions)

## 1.1: What is R?

First and foremost, R is a piece of statistical software. R is useful
because, among other things, it’s free and open-source, which makes it
easy to install and use anywhere. It is also highly modular, which in
combination with the above makes it possible for R users to develop
their own specialised packages for it. If you are having trouble doing
something using built-in functions only, there is probably a package
available somewhere that will let you do it with minimal difficulty.

What sets R apart from other software applications with similar purposes
is that it is also a fully-fledged programming language. This can make
using it seem daunting at first, but the freedom this gives you is well
worth it.

## 1.2: What isn’t R?

R is not Excel. You can’t expect to set up your tables just by clicking
and dragging, and there is a strict separation between code and data.
You can’t edit data directly or put formulae into cells, you have to
input commands to manipulate it.

R is not SPSS. You can’t perform your analyses by navigating menus - you
have to type all the code that defines your models and graphs out
manually, although the RStudio interface will help you with autocomplete
suggestions.

R is not Stata. Every line in Stata starts with a command, and every
command has its own line. R is much less restrictive about how you can
lay out your code, although that also means it takes longer to learn how
to do it.

R is not a traditional programming language. R was designed from the
ground up to be used for statistical analysis, which means that things
which you take for granted about languages like C++ or Python
(e.g. array indices starting from 0) have no guarantee of being true
here.

R is not MATLAB. Frankly, MATLAB is awful. It’s slow to load, its syntax
is horrible, it hogs disk space, and if it doesn’t work it’s nearly
impossible to figure out what you did wrong. If, like me, you have used
MATLAB before and hated it, I can reassure you that R is superior on all
of those fronts.

## 1.3: Where does R keep your data?

R stores everything that you are currently using in the **environment**.
Unlike in Stata or SPSS, you can have more than one data set active at
the same time!

However, the environment is not just for data. It can store any R
object, including **variables** and **functions**.

## 1.4: How do you tell R to store something?

R uses very similar syntax for creating all kinds of objects. The key is
the **assignment** operator, written `<-`. In most programming
languages, you declare the value of a variable using a single equals
sign `=`. You can actually do this in R too, but it’s not considered
good practice.

The assignment operator points towards the left to help you visualise
the program flow. When you define a variable, its name goes on the left
and its value goes on the right. You are **assigning** the value to the
name, not the other way around. A common Computer Science 101 test
question is to write down the output of a piece of C-like pseudocode
that looks something like this (in this case, it’s also valid R code):

``` r
y = 1
x = 2
x = y
print(x)
```

The reason this question isn’t completely trivial is because, if you’re
unfamiliar with how assignment in programming languages works, it’s not
obvious whether it will print 1 or 2. Rewriting the code with `<-`
instead of `=` makes it much clearer that the answer will be 1:

``` r
y <- 1
x <- 2
x <- y
print(x)
```

    ## [1] 1

If you actually run this code, you will see a variable called `x` appear
in the environment (in the upper right corner of the screen), and you
can see that its value is 1. So far, so good. If you hover over it, you
will see that its type is **numeric**. We could have assigned `x` a
string as its value, in which case its type would be **character**, or a
Boolean (`TRUE` or `FALSE`) in which case its type would be **logical**.
We don’t want to overwrite `x` as we might need to use it later, so we
can assign these values to two new variables instead.

``` r
s <- "Hello World!"
b <- TRUE
```

What do you do if you decide you don’t need a variable any more and want
to get rid of it entirely, rather than overwrite its value with
something else? There is a special function for that: `rm()`, which is
short for **remove**. When it is given the name of any R object
currently in the environment, it does just that. We will see more
advanced uses of `rm()` in the appendix.

``` r
mistake <- "This variable was a mistake."
rm(mistake)
exists("mistake")
```

    ## [1] FALSE

Note the use of the `exists()` function to determine if an object of the
provided name is present in the environment.

## 1.5: How do you import data from a file?

Most of the time, you will be given data for analysis in the form of a
text (**.txt**) or comma-separated (**.csv**) file. Excel files (.xlsx)
are not good for this because Excel’s auto-formatting can introduce
errors, so if someone gives you data in an Excel file do not try to
import it. Instead, dispose of the file and kindly inform whoever gave
it to you not to do that. Excel files also have a hard limit of
1,048,576 rows, which only seems like a lot to anyone who has never
worked with big data. Big data is BIG.

There are two ways to import a data file into R. The first is by
clicking the **“import dataset”** button just above the environment
window, choosing the file type you want, and then navigating to the file
in the Explorer window. This is the most “SPSS-like” thing that R lets
you do.

The second way is by using the console. R has built-in functions for
importing files, which are called `read.table()` and `read.csv()`. These
functions have multiple arguments, but the most important ones that you
need to know about for now are the file path, and whether or not the
first row of the file should be read as a header.

When calling `read.table()` or `read.csv()`, the file path must be
written as a string (enclosed by quotes). In order to save your file in
the environment, you must assign it a name. Here is an example of what
the code could look like:

``` r
my_df <- read.table("C:/Users/me/Documents/example.txt", header=TRUE)
```

The reason I chose to name my hypothetical imported file “my_df” is
because R returns it as a type of object called a **data frame**. More
on that in the next section.

A quick note: be careful that you don’t rely too much on files which are
saved on your computer only and not a shared drive, as other people you
share your code with won’t be able to run it. This goes double if you
use `setwd()` to fix your working directory, as then it may not be
obvious to someone who reads snippets of your code that it will only
work for you. If you have to use `setwd()` in code that other people
will have to use, make sure to add a very noticeable comment (the syntax
for doing this is the hash symbol `#`) next to it that says something
like “PLEASE REPLACE THIS FOLDER PATH WITH YOUR OWN WORKING DIRECTORY OR
CODE WILL NOT RUN”.

If any arguments of an R function are not specified, they take their
default values (provided such values exist, if they don’t it gives you
an error). We needed to specify that the first row should be read as a
header (for data you work with, this will almost always be the case)
because by default it is `FALSE` for `read.table()`. For some reason,
for `read.csv()` it is `TRUE` by default, so you don’t need to include
it. Be careful not to get caught out by this!

This seems like much more of a fuss than simply using the menu, but you
will need to use these commands when importing multiple data sets in
sequence (or else you’ll get very bored of opening the menu again and
again). We’ll learn more about how you can eliminate this kind of busy
work when we look at control flow.

A word of caution: saving data in the environment is not the same as
saving it as a file on your computer. If you want to do the latter so
you can easily load it again where you left off, you need to click the
floppy disk icon above the environment and save it as an .RData file.
Unlike .csv or .txt files, .RData files can contain multiple data sets,
as well as any variables or functions you’ve created in order to
manipulate them. You can load an .RData file into your environment by
clicking the folder icon next to the save icon.

There are separate icons for saving and loading above the source window,
which is where your R scripts live. Just be sure to remember that saving
or loading an R script file (with extension .R) will not do the same for
its associated data!

## 1.6: How do you manipulate your data?

As mentioned briefly in the previous section, once you have imported
your file, it is stored in R as an object known as a **data frame**. A
data frame is basically a fancier version of a **matrix**, which itself
is a two-dimensional version of a **vector**. What is a vector, you
might ask?

A single-valued variable, such as x from before, is known as a
**scalar**. Vectors in R are formed using a special function, `c()`,
which **concatenates** (hence the name) any number of scalars of the
same type (numeric, character, or logical) into a vector. Here’s how you
might do it:

``` r
y <- 2
z <- 3
my_vector <- c(x, y, z)
my_vector
```

    ## [1] 1 2 3

Note that since x is saved in the environment, you don’t have to define
it again. We used x here to show this functionality, but we could have
just as easily used the numeric constant 1 instead; `c()` accepts
numbers, strings or logical values (`TRUE` or `FALSE`) even if they
haven’t been bound to a variable name. Let’s see some examples using the
other variables we defined earlier:

``` r
c(b, FALSE)
```

    ## [1]  TRUE FALSE

``` r
c(s, "This is a string.")
```

    ## [1] "Hello World!"      "This is a string."

In a data frame, each column is a named vector. You can manipulate any
column of a data frame using the same methods for manipulating vectors.
This leads into our next question…

## 1.7: How do you manipulate vectors?

The first thing you need to know when working with vectors is that `c()`
is not just for combining scalars. It can also combine vectors with
scalars, or even with other vectors. Try it:

``` r
c(my_vector, x)
```

    ## [1] 1 2 3 1

``` r
c(my_vector, my_vector)
```

    ## [1] 1 2 3 1 2 3

You can see that we used `c()` to duplicate our vector by typing its
name twice. This seems a bit inefficient, so you’re probably wondering
if there’s a better way to do it. Luckily, there is: the `rep()`
function. In its most basic form, this function has two arguments: the
first is a scalar or vector, and the second is a number that tells R how
many times to repeat it. See that it gives you the same result as
before:

``` r
rep(my_vector, 2)
```

    ## [1] 1 2 3 1 2 3

The second argument need not be a constant, either. This is also
allowed:

``` r
rep(my_vector, y)
```

    ## [1] 1 2 3 1 2 3

We can do some slightly more advanced things with `rep()` that we’ll
look at in the appendix.

Aside from `rep()`, there is another common method for quickly
generating vectors of arbitrary length. If you want to make a numeric
sequence rather than a simple repetition of the same few elements, you
can use the `:` operator. Simply typing `n:m`, where n and m are any
integers, makes a vector of all integers between n and m inclusive (if n
is greater than m it will output them in reverse).

There is a function that does the same thing as `:` but allows for more
options called `seq()`, which we will also look at in the appendix.

## 1.8: Using mathematical operators with vectors

Like most programming languages, R can be used as a fancy calculator. If
you type a mathematical expression into the console, it will give you
the answer. The standard mathematical operators (+, -, \*, /) are not
just usable with numbers, though. They can also be applied to vectors,
which is something that traditional languages will not let you do
(without a for loop, that is). Operators are applied **element-wise**,
which means that performing an operation on two vectors of the same
length is equivalent to applying it on each pair of values in the same
position in sequence.

``` r
rep(1, 5)+rep(2, 5)
```

    ## [1] 3 3 3 3 3

If the vectors are not the same length, it can still work. What happens
in this case is that the smaller vector is repeated to match the length
of the other before the operation is carried out. This means that you
can add a number to every element of a vector at once simply by typing
the following:

``` r
my_vector+1
```

    ## [1] 2 3 4

If the larger vector’s length is not an exact multiple of the smaller
one’s, the last repeat of it will be truncated, and you will get a
warning (but R will still return the answer).

``` r
1:2+1:3
```

    ## Warning in 1:2 + 1:3: longer object length is not a multiple of shorter object
    ## length

    ## [1] 2 4 4

Needless to say, most programming languages will throw a hissy fit if
you try to do anything like this with two objects that have different
lengths.

## 1.9: Working with data frames

A data frame is made of multiple column vectors of the same length bound
together, each of which represents a variable. Unlike in a matrix, these
columns can have different types, which is useful if you’re working with
a data set that has both numeric and character variables (for example, a
list of patient IDs with associated ICD-10 codes). Remember, however,
that you can’t put values of different types in the same column.

R has a special syntax for referencing a particular column of a data
frame. In order to do this, write the name of the data frame followed by
a dollar sign `$` and the name of the column. Any method that works on
vectors can be applied to such an object. You can add a new empty column
with your preferred name to an existing data frame simply by doing this:

``` r
my_df$new_column <- NA
```

Note that R automatically recycles the value on the right until the new
column is the same length as all the others. You can see also that R
represents a missing value with `NA`. Having a special symbol for
missing values is useful (in particular, because they are distinct from
a value of zero), but keep in mind that NAs can cause issues when trying
to compute certain functions, such as the mean of a column (including
the argument `na.rm=TRUE` causes NAs to be ignored, but it’s easy to
forget to do this).

An alternate method for adding an existing vector to a data frame as a
new variable is using the `cbind()` function. `cbind()` takes one or
more column vectors and/or data frames as arguments and binds them
together sequentially. `cbind()` also lets you name the new columns of a
data frame, if you’re adding them one at a time. It has an advantage
over using `$` to add a new column as you have more control over the
position that it will be added in, while when using `$` the new column
is always added in the rightmost position. We will cover how to use
`cbind()` to add columns in the middle of a data frame when we get to
square brackets.

``` r
cbind(my_df, "new_column"=NA) #This adds it on the right
cbind("new_column"=NA, my_df) #This adds it on the left
```

But what if you don’t want to add a new column, but a new row instead?
There is another function, naturally named `rbind()`, that does just
that. Your new row can’t be saved as a vector unless all its entries
have the same type, though: you must create it either as a **list** or
as a data frame with 1 row.

A list is to a vector as a data frame is to a matrix. While vectors are
limited to storing scalars of a single type, lists can store
**anything** as entries, including vectors, matrices, data frames or
even other lists. Many statistical models you will run return their
outputs as lists. You don’t need to know much about lists right now, but
keep them in mind for later.

## 1.10: Assembling data frames from scratch

Let’s say you have a bunch of data vectors that you want to assemble
into a data frame. Using `cbind()` on them all would produce a matrix,
not a data frame, as `cbind()` requires at least one of its arguments to
be a data frame for the final product to be one. If you mix numeric and
character vectors, R still won’t “guess” that the result you want is a
data frame; instead it will coerce the numeric vectors into characters.

Thankfully, there is a function that allows you to create your own data
frames, which is conveniently called `data.frame()`. Calling this
function with no arguments produces a data frame with zero rows and zero
columns, which seems odd but you can still add data to it later to give
it a defined size. This will be helpful when working with loops. Each
argument of `data.frame()` is a column vector, which you can assign a
name to. The syntax for doing so is the same as with `cbind()`:

``` r
my_df <- data.frame("variable_1"=vector1, "variable_2"=vector2, "variable_3"=vector3)
```

You can also use this method with the `$` operator to extract specific
columns from an existing data frame to make a new one, although the
`subset()` function (covered in the appendix) and the square brackets
can do the same thing more elegantly.

## 1.11: Using square brackets

You can also reference columns, rows, or even single entries of a data
frame using the **square brackets** `[]`.

In one dimension, the square brackets are used to reference a single
entry of a vector. Unlike in standard programming languages, the indices
of vectors start at 1 rather than 0. You also can’t use negative indices
to reference entries starting from the end (for example, in Python
`l[-1]` would return the last entry of a list `l`). In R, putting the
minus sign `-` in front of an index does something rather different: it
actually drops that entry from the vector, although it doesn’t edit the
original. It makes a copy of it without that entry, which it won’t save
unless you assign it a name. If you want to edit a vector to remove the
first entry, you can overwrite it with the new copy like this:

``` r
my_vector <- my_vector[-1]
```

You can reference multiple entries of a vector by putting a vector of
their indices inside the square brackets. If these indices are “out of
order”, the output will be too. You can define these using `c()`, the
`:` operator, or any other method you like. Both lines below produce the
same result:

``` r
my_vector[c(1, 2, 3)]
my_vector[1:3]
```

Putting a `-` in front of the vector inside the square brackets will
remove **all** the entries it references. Instead of numeric indices,
you can also use **logical** vectors as indices. Putting a logical
vector (which must be of the same length as the vector you are
referencing) inside the square brackets will return only those entries
for which the value in the same position in the logical vector is
`TRUE`. This may not look it at first, but it’s an extremely powerful
method. The reason for this is because any logical statement involving
vectors will generate a vector of logical values, which can be used as
an indexing vector. We’ll cover how to use logical statements soon.

Using square brackets to reference values in a matrix or data frame is
similar, only you now have to specify two arguments inside the brackets
separated by a comma. If you want only specific columns or rows, you
leave one argument blank, but the comma still needs to be included. This
gives you a way to reference variables without typing their full names
out, although you need to remember the column number and be careful with
moving data around. For our example data frame, these two lines output
the same values:

``` r
my_df$variable1
my_df[,1]
```

Of course, you can also use the minus sign `-` to quickly drop rows or
columns that you don’t need. If you want to insert a column into the
middle of a data frame, you can do something like this:

``` r
my_df <- cbind(my_df[,1:5], "new_column"=NA, my_df[,6:10])
```

Another thing you can use square brackets to do easily is renaming
variables. There is a function called `names()` that, when applied to a
data frame, returns a vector containing all the column names in order.
To rename, say, the 10th column, all you have to do is type the
following:

``` r
names(my_df)[10] <- "better_name"
```

A slight inconsistency: `names()` does not work how you might expect it
to when the argument is a matrix rather than a data frame - in that
case, it returns the name of each individual element. When working with
matrices, use `colnames()` instead, and its counterpart `rownames()`.
Both of these functions also work with data frames.

## 1.12: Logical operators

The basic logical operators in R (`==, !=, <, >, <=, >=, |, &, !`) are
mostly the same as in other programming languages. Testing for
membership in a set is done with the operator `%in%`, which has
percentage signs around it to differentiate it from the “in” used in
**for** loops. Like standard mathematical operators, logical operators
are applied element-wise to vectors, which means using `<` and `>` with
vectors actually makes sense. For example, the following line will
return a logical vector describing whether each entry of `my_vector` is
greater than 1:

``` r
my_vector>1
```

    ## [1] FALSE  TRUE  TRUE

This means that the following code will keep only the values of
`my_vector` that are greater than 1:

``` r
my_vector[my_vector>1]
```

    ## [1] 2 3

What if you’re not interested in the magnitude of the values that are
greater than 1, but simply want a vector of their positions? This is
done using the `which()` function. This function takes a logical vector
as its argument, and returns the positions of which elements are `TRUE`.
Let’s not use my_vector to illustrate this, because its positions and
values are the same.

``` r
my_fancy_vector <- c(3, 1, 2, 2, 1, 1)
which(my_fancy_vector>1)
```

    ## [1] 1 3 4

Other useful logical functions include `is.na()`, which tells you the
positions of any values that are missing, and `is.finite()`, which tells
you which values are numbers (`NA`, `NaN`, `Inf`, and `-Inf` all return
`FALSE`, if you don’t know what these values mean consult the appendix).
A lot of the time, `NA` values will mess up your calculations, so when
formulating your logical statements you will have to add an `is.na()`
call, like this:

``` r
with(my_df, variable_2[variable_1==x&!is.na(variable_1)])
```

Note the use of `&` (logical AND) and `!` (logical NOT) here. You can
use these as well as `|` (logical OR) to make compound logical
statements, saving you from having to pass logical functions multiple
times. The `with()` function is also very useful, as calling it with a
data frame as the first argument and an expression to be evaluated as
the second allows you to reference its columns by name in the expression
without needing the dollar sign operator. If you find yourself typing
the name of a data frame out very often, consider using `with()` to save
you some space.

## 1.13: Basic control flow

Like in standard programming languages, R’s control flow primarily uses
**if** statements and **loops**. As we have seen, loops are not needed
for simple vector operations in R even though they would be in other
languages, but that does not mean R loops are not useful. However,
experienced R coders tend to use loops quite sparingly: if you find
yourself writing a lot of them, be aware that you are “speaking R with a
strong C accent”.

The basic syntax is the same for all control flow commands. It consists
of the command, followed by a statement in brackets that determines the
conditions under which the desired effect will happen, followed by the
main definition of what that effect will actually do in **curly
brackets** `{}`, which is called the **“body”** (these brackets are
technically optional, but it’s only considered good practice to exclude
them if your statement is restricted to a single line). Let’s see what
the simplest version of this, the if statement, looks like (sans curly
brackets):

``` r
if(is.na(x)) x <- 0
```

What this code does should be easy to understand: it checks if the value
of a variable `x` is missing, and if it is, it replaces it with 0. In an
if statement, we can put any logical statement in the first pair of
brackets.

Naturally, an if statement can be accompanied by an **else** clause,
which requires no condition. Like in some other languages, the way to
make multiple-choice if statements is by chaining the else clause into
another if statement. There is no direct equivalent of Python’s `elif`.

``` r
if(x==1){
  print("The value of x is 1.")
} else if(x==0){
  print("The value of x is 0.")
} else print("x is not a binary variable.")
```

R also has a function called `ifelse()` that is designed to replace very
simple if-else statements for which writing them out in full would be
cumbersome. This function has three arguments: the first is a logical
statement, the second is what the function will output if that statement
is `TRUE`, and the third is the output if that statement is `FALSE`. In
effect, the two lines below are (almost) the same:

``` r
ifelse(condition, "Yes", "No")

if(condition) "Yes" else "No"
```

There are some very subtle differences between how these two statements
work which we will cover in the appendix.

Loops are similar to if statements, only instead of evaluating their
condition once they do it multiple times in succession. There are three
types of loops in R, **for**, **while**, and **repeat**.

The **for** loop is the most intuitive to use. Its condition is not a
logical statement, but is of the form `i in v` where `i` is a dummy
variable and `v` is a vector of your choice. For instance, if we want to
expand our if-else statement above to deal with a variable that can take
any integer value from 0 to 9 rather than just 0 or 1, we can use a for
loop:

``` r
for(i in 0:9){
  if(x==i) str_glue("The value of x is {i}.")
}
```

The `str_glue()` function is a very useful function for string
manipulation which is part of the `stringr` package. We’ll look more
closely at it and its associated package in the appendix.

Typically, when manipulating data you will only need to use for loops.
While and repeat loops are designed to be used when you don’t know in
advance how many iterations you will require, which is rare when you’re
dealing with data as you’ll always know how big your tables are. For
that reason, these have been relegated to the appendix.

## 1.14: Custom functions

R and its packages have many functions that can do almost anything, but
at some point you will need to write your own. Writing functions can
save time, as you can call a function anywhere in your code without
having to write a complicated expression in full again. Function
definitions use a similar syntax to control flow statements, but they
can be assigned a name like variables. If you’re used to a language like
C++ or Python, R’s function definitions have a syntax which is more
similar to lambda expressions than the basic function definitions in
those languages. The structure of a function definition in R looks like
this:

``` r
my_function <- function(args){
  #body
}
```

Again, if everything fits on a single line the curly brackets can be
omitted. The first pair of brackets contains all the function’s
arguments, which like in a for loop are just dummy variables that can be
used again in the function body. The function’s body determines what its
output will be. In order to make sure a function outputs only a single
value, use the `return()` function. Once the `return()` function is
called, the main function will terminate, and all body code below the
`return()` will be ignored. Other functions like `print()` do not work
this way, so you can easily make a function that prints a succession of
values using a loop. Note that unlike in some other languages, `print()`
does not automatically turn its argument into a string.

``` r
loop_function <- function(n){
  for(i in 1:n) print(i)
}
```

The above function takes an integer n as its argument, and prints all
integers from 1 to n on separate lines. This function has no error
handling, so giving it a bad input can cause problems. When writing your
own functions that will be used by other people, be sure to think about
whether any possible inputs might result in unintended behaviour and
include code to handle them.

## 1.15: Where should you go if you have further questions?

R has an inbuilt method for helping with unfamiliar code. If you ever
see a function you don’t recognise or understand, you can type `?`
followed by the function name in the console and R will automatically
open the help page for that function. Built-in functions will (usually)
have very thorough documentation, but if you are using specialised
packages you are at the mercy of how dense or sparse the author’s
explanation is. In cases where the official documentation is not enough,
you can do the classic moves of either resorting to StackOverflow or
asking an AI to explain it to you, but I believe the best course of
action is always to play around with the code until you figure it out.
If you are careful not to overwrite your existing data, messing up won’t
cost you much other than your time.

The opposite problem, when you want to do something but don’t know the
right function for it, is harder to deal with. R is strictly
case-sensitive, which wouldn’t be so bad if it wasn’t for the fact that
in base R there isn’t any consistent style for function names (some
start with capital letters, some are in camelCase, some have
underscores, some have dots, and so on). If you have a decent idea of
what the function you want is called but can’t remember the exact name,
you can type `??` followed by a search string to bring up a list of all
help pages that contain it, or just type it in the search bar and press
Enter. You can also use the `apropos()` function to get a list of all
functions that are currently loaded in your environment and contain a
certain string (or match a regular expression, which is outside the
scope of this sheet).

If you have no idea at all what the function you want is called, you are
in a real bind. Personally, I’ve found that the best way to learn about
new functions that might be useful to you is to read other people’s code
(and before you ask, ChatGPT doesn’t count as a person). Due to the
open-source and collaborative nature of R it has a large and thriving
community, so there’s no way you won’t find any. Good luck!
