R workshop 2: Functions and loops
================
José Boue
2025-11-11

- [1.1: Introduction](#11-introduction)
- [1.2: Functions](#12-functions)
- [1.3: Loops](#13-loops)
- [1.4 Over to you…](#14-over-to-you)

## 1.1: Introduction

Whether you are new to R or already have some experience with it, you
have probably been frustrated by writing code. One of the most common
sources of frustration is having to write out the same thing, or slight
variations of it, multiple times. Sometimes this is simply unavoidable,
but often there is a way around it. At its core, programming is supposed
to be about getting a computer to automate tasks which are too
time-consuming and repetitive for humans to do by hand, so if you always
had to write everything out in full that would defeat the point. Two of
the simplest ways to deal with this problem are functions and loops.

## 1.2: Functions

R and its packages have many functions that can do almost anything, but
at some point you will need to write your own (functions, not
packages!). Writing functions can save time, as you can call a function
anywhere in your code without having to write a complicated expression
in full again. Function definitions use a similar syntax to control flow
statements (if-else and loops), but functions use the same assignment
syntax as ordinary variables. In fact, the name of a function can be
used just like any other variable. You can even have have a function
that has another function as its output or takes a function as one of
its arguments!

The structure of a function definition in R looks like this:

``` r
my_function <- function(args){
  #body
}
```

As with all control flow statements, if everything fits on a single line
the curly brackets can be omitted. The first pair of brackets contains
all the function’s arguments (separated by commas), which are just dummy
variables that can be used again in the function body. A function can
have any number of arguments including zero, in which case the brackets
are empty and it will run exactly the same code every time it is called.
The function’s body is just a block of code that determines what its
output will be.

In order to make sure a function outputs only what you want it to, use
the `return()` function. Once the `return()` function is called, the
main function will terminate, and all body code below the `return()`
will be ignored. Other functions that produce output like `print()` do
not work this way, so you can print multiple objects without terminating
your function. If a `return()` is not included inside a function, it
will automatically return whatever the last expression it evaluated was.
Here are three zero-argument functions that do the same thing, one using
`return`, one using `print()`, and one having a bare string as its body.

``` r
sayhello <- function() return("Hello World!")
sayhello2 <- function() print("Hello World!")
sayhello3 <- function() "Hello World!"

sayhello()
```

    ## [1] "Hello World!"

``` r
sayhello2()
```

    ## [1] "Hello World!"

``` r
sayhello3()
```

    ## [1] "Hello World!"

Here is a more complex example of a function. It runs a simple linear
regression model with two variables and gives you the summary and
confidence intervals. It does its job perfectly well, but if we want to
get a similar result but with a logistic regression, this function won’t
work.

``` r
lm_with_ci <- function(x, y){
  fit <- lm(y ~ x)
  summary(fit)
  confint(fit)
}
```

We could write another function to deal with that case, but writing the
same code twice is what functions were supposed to help us avoid. The
solution is to add another argument to the function, which determines
the model that is used. That way, not only can you work with two
different types of models in one function, but if you ever need to work
with a third type of model that functionality will be easy to add.

``` r
model_with_ci <- function(x, y, model){
  if(model == "linear"){
    fit <- lm(y ~ x)
  } else if(model == "logistic"){
    fit <- glm(y ~ x, family="binomial")
  } else stop("Model not supported")
  summary(fit)
  confint(fit)
}
```

You can also make functions that have default values for certain
arguments or even accept a variable number of arguments, but this is
outside the scope of this session.

## 1.3: Loops

If you’ve used another programming language before (a real one, Stata
doesn’t count), you are sure to know what loops are. If not, we’ll
quickly recap it for you. Basically, a loop is a way to evaluate the
same statement multiple times in succession, but with different values
of the variables involved each time. Different languages have various
numbers of different types of loops. Base R has three: **for**,
**while**, and **repeat**, although there are packages that can add
more.

The **for** loop is the most intuitive to use. Its basic syntax looks
like this:

``` r
for(i in v){
  #body statement involving i
}
```

Here, `v` can be any vector and `i` is a dummy variable. Effectively,
the body is evaluated for each element of `v` in turn. A lot of R’s
functions and operators already loop element-wise over vectors
implicitly, but sometimes that won’t work and you need to write the loop
out formally. You should always check beforehand if a function you want
to use accepts vectorised inputs, because if it does it can save you a
lot of work. Experienced R coders tend to use loops very sparingly, and
sometimes not at all!

Here’s an example of when a for loop might not be necessary. In [“The R
Inferno”](https://www.burns-stat.com/documents/books/the-r-inferno/),
Patrick Burns refers to the following code as “speaking with a strong C
accent”:

``` r
lsum <- 0
for (i in 1:length(x)) {
  lsum <- lsum + log(x[i])
}
```

This code is “correct” in the sense that it does what it’s supposed to,
but it’s spectacularly wasteful. Here’s the idiomatic R way to do the
same thing:

``` r
lsum <- sum(log(x))
```

Typically, when manipulating data the for loop is the only type of loop
you’ll use. While and repeat loops are designed to be used when you
don’t know in advance how many iterations you will require, which is
rare when you’re dealing with data as you’ll always know how big your
tables are.

The syntax of a **while** loop looks like this:

``` r
while(condition){
  #body statement
}  
```

The condition of a while loop is a logical expression. Like an **if**
statement, a while loop only evaluates its body if its condition
evaluates to TRUE, but the difference is that it can do so multiple
times. After the body has been evaluated once, the while loop checks if
the condition is still TRUE, then if it is evaluates it again, and so
on. Unlike for loops, while loops can potentially run forever if the
condition never becomes FALSE, or if they are not manually terminated
using the `break` command (or `return()`, if they are within a
function). Here is an example of a while loop that uses an if statement
to decide whether to break:

``` r
while(n>0){
  if(n%%1==0){
    n <- n-1
  } else break
}
```

This code is designed to take a positive integer n and decrement it by 1
repeatedly until it reaches 0. If n is not an integer, the loop will
break instead of passing an invalid input.

A **repeat** loop is identical to a while loop, but with no condition:
the only way to terminate it is by manually breaking it. You can achieve
the same effect as a repeat loop by writing `while(TRUE)`.

## 1.4 Over to you…

If you are comfortable with the explanations shown above and in any
other resources you’ve had a look at, feel free to move on to the
exercises for this session which can be found in the GitHub repository.
Happy coding!
