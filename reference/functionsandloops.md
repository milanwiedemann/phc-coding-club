R workshop 2: Functions and loops
================
José Boue
2025-12-04

- [2.1: Introduction](#21-introduction)
- [2.2: Functions](#22-functions)
- [2.3: Loops](#23-loops)
- [2.4: Over to you…](#24-over-to-you)

## 2.1: Introduction

Whether you are new to R or already have some experience with it, you
have probably been frustrated by writing code. One of the most common
sources of frustration is having to write out the same thing, or slight
variations of it, multiple times. Sometimes this is simply unavoidable,
but often there is a way around it. At its core, programming is supposed
to be about getting a computer to automate tasks which are too
time-consuming and repetitive for humans to do by hand, so if you always
had to write everything out in full that would defeat the point. Two of
the simplest ways to deal with this problem are functions and loops.

The demonstration data for this session will be the caffeine data from
“The Pirate’s Guide to R” chapter 10. Here is the code to load it:

``` r
caffeine <- read.table("https://raw.githubusercontent.com/ndphillips/ThePiratesGuideToR/refs/heads/master/data/caffeinestudy.txt", header=TRUE)
```

This data frame contains the results of a (presumably fictional)
experiment where 100 participants were given either green tea or coffee
before performing a cognitive test. The variables included are which
drink each participant had, the number of cups they drank, whether they
were male or female, their age, and their test score.

## 2.2: Functions

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
You can also make functions that have default values for certain
arguments or even accept a variable number of arguments, which we will
show briefly (but this is not required for the rest of the session).

``` r
weird_function <- function(x=1, y=0, z=pi/2) x*cos(y)*sin(z)
weird_function(x=2) #If any arguments are not specified, they will take default values
```

    ## [1] 2

``` r
weird_function2 <- function(...) sum(...)/prod(...) 
#Many built-in functions take a variable number of arguments, sum() and prod() are two of them
weird_function2(1, 2, 3)
```

    ## [1] 1

The function’s body is just a block of code that determines what its
output will be. In order to make sure a function outputs only what you
want it to, use the `return()` function. Once the `return()` function is
called, the main function will terminate, and all body code below the
`return()` will be ignored. Other functions that produce output like
`print()` do not work this way, so you can print multiple objects
without terminating your function. If a `return()` is not included
inside a function, it will automatically return whatever the last
expression it evaluated was. Here are three zero-argument functions that
do the same thing, one using `return`, one using `print()`, and one
having a bare string as its body.

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
  print(summary(fit))
  print(confint(fit))
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
  print(summary(fit))
  print(confint(fit))
}
```

Let’s test these functions with the caffeine data:

``` r
with(caffeine, lm_with_ci(age, score))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -32.689 -15.845  -4.332  15.408  40.261 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)   
    ## (Intercept)  44.3525    16.4688   2.693  0.00833 **
    ## x            -0.4749     0.6604  -0.719  0.47374   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 19.68 on 98 degrees of freedom
    ## Multiple R-squared:  0.00525,    Adjusted R-squared:  -0.0049 
    ## F-statistic: 0.5172 on 1 and 98 DF,  p-value: 0.4737
    ## 
    ##                 2.5 %    97.5 %
    ## (Intercept) 11.670717 77.034293
    ## x           -1.785415  0.835552

``` r
with(caffeine, model_with_ci(age, score, model="linear"))
```

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -32.689 -15.845  -4.332  15.408  40.261 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)   
    ## (Intercept)  44.3525    16.4688   2.693  0.00833 **
    ## x            -0.4749     0.6604  -0.719  0.47374   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 19.68 on 98 degrees of freedom
    ## Multiple R-squared:  0.00525,    Adjusted R-squared:  -0.0049 
    ## F-statistic: 0.5172 on 1 and 98 DF,  p-value: 0.4737
    ## 
    ##                 2.5 %    97.5 %
    ## (Intercept) 11.670717 77.034293
    ## x           -1.785415  0.835552

``` r
with(caffeine, model_with_ci(gender, factor(drink), model="logistic"))
```

    ## 
    ## Call:
    ## glm(formula = y ~ x, family = "binomial")
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)  -0.2412     0.2849  -0.846    0.397
    ## xmale         0.4823     0.4029   1.197    0.231
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 138.63  on 99  degrees of freedom
    ## Residual deviance: 137.19  on 98  degrees of freedom
    ## AIC: 141.19
    ## 
    ## Number of Fisher Scoring iterations: 3

    ## Waiting for profiling to be done...

    ##                  2.5 %    97.5 %
    ## (Intercept) -0.8095193 0.3146091
    ## xmale       -0.3036895 1.2808776

You can see that the second function returns the same result as the
first when called with “linear” as the argument for the model, and works
just as well when called with “logistic” instead.

## 2.3: Loops

Nearly all programming languages make use of loops, and R is no
exception. A loop is just a way to evaluate the same statement multiple
times in succession, but with different values of the variables involved
each time. Different languages have various numbers of different types
of loops. Base R has three: **for**, **while**, and **repeat**, although
there are packages that can add more.

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

Using the caffeine data, here is an example of using a loop to draw
histograms of scores split by each of the first three variables in the
dataset:

``` r
vals <- list("drink"=c("greentea", "coffee"), "cups"=c(1, 5), "gender"=c("male", "female"))
tscore <- caffeine$score
for(i in 1:3){
  v <- caffeine[i]
  val1 <- vals[[i]][1]
  val2 <- vals[[i]][2]
  valname <- names(vals)[i]
  hist(tscore[v==val1], main=paste(valname, "=", val1), xlab="Test score")
  hist(tscore[v==val2], main=paste(valname, "=", val2), xlab="Test score")
}
```

![](functionsandloops_files/figure-gfm/hists-1.png)<!-- -->![](functionsandloops_files/figure-gfm/hists-2.png)<!-- -->![](functionsandloops_files/figure-gfm/hists-3.png)<!-- -->![](functionsandloops_files/figure-gfm/hists-4.png)<!-- -->![](functionsandloops_files/figure-gfm/hists-5.png)<!-- -->![](functionsandloops_files/figure-gfm/hists-6.png)<!-- -->

On the other hand, here’s an example of when a for loop might not be
necessary. In [“The R
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

## 2.4: Over to you…

If you are comfortable with the explanations shown above and in any
other resources you’ve had a look at, feel free to move on to the
exercises for this session. They are located elsewhere in the GitHub
repository, and can be found by clicking the relevant link in the README
file. Happy coding!
