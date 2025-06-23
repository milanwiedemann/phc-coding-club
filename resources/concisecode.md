R workshop 1: Writing concise code
================
José Boue
2025-06-23

- [1.1: What is this workshop about?](#11-what-is-this-workshop-about)
- [1.2: Copy-paste and
  find-and-replace](#12-copy-paste-and-find-and-replace)
- [1.3: Loops](#13-loops)
- [1.4: Functional programming](#14-functional-programming)
- [1.5: Defining custom operators](#15-defining-custom-operators)
- [1.6: Examples](#16-examples)
  - [1.6.1: Basic vector indexing](#161-basic-vector-indexing)
  - [1.6.2: With a loop](#162-with-a-loop)
  - [1.6.3: With `sapply()` and an inline
    function](#163-with-sapply-and-an-inline-function)
  - [1.6.4: With custom operators](#164-with-custom-operators)
- [1.7: Exercises (optional)](#17-exercises-optional)

## 1.1: What is this workshop about?

Whether you are new to R or already have some experience with it, you
have probably been frustrated by writing code. One of the most common
sources of frustration is having to write out the same thing, or slight
variations of it, multiple times. Sometimes this is simply unavoidable,
but often there is a way around it. At its core, programming is supposed
to be about getting a computer to automate tasks which are too
time-consuming and repetitive for humans to do by hand, so if you always
had to write everything out in full that would defeat the point. In this
workshop, we will cover various methods, in increasing order of
difficulty and abstraction, for reducing the amount of busy work you
have to do when coding. You can stop at wherever you feel comfortable.

## 1.2: Copy-paste and find-and-replace

If you are using RStudio (who am I kidding, of course you are), you can
use Ctrl+C, Ctrl+V, and Ctrl+F in your code just like you would in a
Word document. You can type out the same piece of code with minor
variations quite quickly with this method, but the result is an R file
which is very long and difficult for humans to read. Assuming you are a
human and not some sort of rogue AI, this means editing your code after
you have finished writing it (you will definitely need to do this,
nobody writes perfect code the first time around) can be very tedious.
Thankfully, there’s a simple way to deal with this…

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
out formally.

Typically, when manipulating data you will only need to use for loops.
While and repeat loops are designed to be used when you don’t know in
advance how many iterations you will require, which is rare when you’re
dealing with data as you’ll always know how big your tables are.

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
function).

A **repeat** loop is identical to a while loop, but with no condition:
the only way to terminate it is by manually breaking it. You can achieve
the same effect as a repeat loop by writing `while(TRUE)`.

## 1.4: Functional programming

Loops are useful, but can still look a bit ugly. I said earlier that a
common use case for a loop is iterating a non-vector-valued function
over a vector element-wise, but there is actually a cleaner way to do
this. R has a group of functions known as the `apply()` family
(`apply()`, `lapply()`, `sapply()`, `vapply()`, `tapply()`, and
`mapply()`), all of which are designed to save you from having to write
loops. Fair warning, we are now outside of generic programming concepts
and into things which are unique to R. Here be dragons.

`lapply()` is mechanically the simplest of these functions. Its first
argument is a vector or list, and the second is usually a
single-argument (unary) function. The values of additional arguments for
the function can be supplied, but it’s best to stick to unary functions
to make sure that everything works exactly as you intend it to.
Functions that take other functions as arguments are more common in R
than you might think. `lapply()` returns the result of its second
argument applied to every element of its first argument, in list format
(hence the l at the start of its name). `sapply()` is a minor variant of
`lapply()` that attempts to turn its output into a vector or matrix
rather than a list if possible (hence the s, for “simplify”), as those
are easier to work with. The original `apply()` takes a general array
(typically a matrix or data frame) as its first argument, and then
applies a function to it row-wise, column-wise, or both depending on
what its second argument is. Explaining how all of the rest of the
`apply()` functions differ from each other would take too much space
here, so figuring that out is left as an exercise for the reader.

The obvious downside of the `apply()` functions as compared to loops is
that they work best with unary functions, of which there aren’t that
many built in to R. In order to get around this constraint, you will
have to introduce yourself to a dark art known as **functional
programming**. If you already know a bit about programming languages,
R’s C-like syntax may have misled you into believing it to be a standard
imperative language, but that is untrue. R is not a purely functional
language like Haskell, but under the hood it is far more functional than
it appears. All of R’s infix operators are actually coded as
two-argument (binary) functions, for example.

It’s possible to take a multi-argument function and define a unary
version of it using a standard functional programming technique known as
partial application (not to be confused with currying), but that can add
clutter to our code that we are trying to eliminate.

``` r
f <- function(x,y,z,w) #some function
f_unary <- function(x) f(x,Y,Z,W) #Y, Z, W are pre-defined variables
sapply(v, f_unary) #This will work now
```

In order to keep everything as neat as possible we will need to use
another key concept of functional programming: anonymous functions, in
other words functions that don’t need to be bound to a name. In
languages like Python, functions like this can be defined using lambda
expressions. Lambda expressions are not necessary in R, because R’s
ordinary syntax for defining functions actually works perfectly well for
this purpose. Looking at the previous example, we can simply do this:

``` r
sapply(v, function(x) f(x,Y,Z,W))
```

This is not nearly the limit of R’s functional features. `Reduce()` is
another space-saving function borrowed from Lisp, which takes a binary
function and a vector (or list) as arguments, then combines the vector’s
elements by applying that function recursively. Explicitly,
`Reduce(f, c(x,y,z))` is the same as `f(f(x,y),z)`, and this generalises
to longer vectors.

`do.call()` is yet another function that can make your code neater. This
function takes a function and a list as arguments like `lapply()`, but
rather than than calling the function once on each element of the list
it passes the whole list as arguments to a single call of the function.
This means that you don’t need to write all the arguments out in full
when calling the function, as you can do it in another part of the code
where it’ll be easier to read.

## 1.5: Defining custom operators

Defining custom functions is all well and good, but the nested brackets
using them tends to produce are quite an eye-sore. The pipe operator
`|>` helps a bit with this, but what if you wanted to take it further?
Remember when I said that all of R’s infix operators are actually
functions in disguise? You might have already understood the implication
that, just as you can define your own functions, you can define your own
operators.

To start with, notice that quite a few R operators are enclosed in
percentage signs `%`, for example matrix multiplication `%*%`, integer
division `%/%`, and even `%in%`, which tests for membership in a set. If
you want to make your own operator, you’ll have to enclose it in
percentage signs too. When an operator is treated as a function,
including in its definition, it also has to be in **backquotes \`\`**,
which may be hard to find on certain keyboards (on mine, the \` key is
above the Tab key). Putting all that together, the syntax for defining a
custom operator for matrix exponentiation looks like this:

``` r
`%^%` <- function(mat, n) Reduce(`%*%`, rep(list(mat),n))
test_matrix <- matrix(data=c(1,1,1,0), nrow=2, ncol=2)
test_matrix%^%3
```

    ##      [,1] [,2]
    ## [1,]    3    2
    ## [2,]    2    1

Custom operators are useful because they take up very little space and
are more intuitive than functions (everyone knows how +, -, \*, and /
work), but you have to be careful when using them that you don’t go
overboard and make your code too abstract for humans to understand. Some
languages, like APL and Uiua, consist almost entirely of operators that
each have their own very specific symbol (in APL’s early days, a special
display and keyboard were required to program in it), and code written
in these languages is completely unreadable to non-aficionados. It’s a
nice property of C-like languages that if you are familiar with any one
of them you can read code written in a completely different one and get
the gist of what it does, but that is emphatically untrue of symbolic
languages.

## 1.6: Examples

To finish off, let’s look at how you would perform the same task using
each of the techniques outlined above. The task is a classic entry-level
programming challenge, FizzBuzz. The assignment is simple: print the
numbers 1 to 100, but replace every multiple of 3 with “Fizz” and every
multiple of 5 with “Buzz”. If a number is both, it should be replaced by
“FizzBuzz” (with no space). This task was deliberately designed to be
easy to code, while also being extremely inconvenient to do by hand, so
it is an excellent example to showcase different methods of writing
code.

### 1.6.1: Basic vector indexing

The magic of R’s vector operations allows you to do this task relatively
concisely without any loops or user-defined functions (which would be
quite difficult in most other languages), but the inability to put
strings into a numeric vector requires some work to get around.

``` r
v <- 1:100
vc <- as.character(v)
vc[v%%3==0] <- "Fizz"
vc[v%%5==0] <- "Buzz"
vc[v%%15==0] <- "FizzBuzz"
cat(vc)
```

    ## 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz Fizz 22 23 Fizz Buzz 26 Fizz 28 29 FizzBuzz 31 32 Fizz 34 Buzz Fizz 37 38 Fizz Buzz 41 Fizz 43 44 FizzBuzz 46 47 Fizz 49 Buzz Fizz 52 53 Fizz Buzz 56 Fizz 58 59 FizzBuzz 61 62 Fizz 64 Buzz Fizz 67 68 Fizz Buzz 71 Fizz 73 74 FizzBuzz 76 77 Fizz 79 Buzz Fizz 82 83 Fizz Buzz 86 Fizz 88 89 FizzBuzz 91 92 Fizz 94 Buzz Fizz 97 98 Fizz Buzz

### 1.6.2: With a loop

It’s best practice when programming this task not to have a special case
for multiples of 15, which wasn’t possible in the last version but is
now. R doesn’t allow strings to be multiplied by integers like most
other programming languages, so we have to use `rep()` or `strrep()`
instead. Luckily both accept zero as a valid number of times to repeat!

``` r
for(i in 1:100){
  if(i%%3==0|i%%5==0){
    cat(strrep(c("Fizz", "Buzz"), c(i%%3==0, i%%5==0)), " ", sep="")
  }
  else cat(i,"")
}
```

    ## 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz Fizz 22 23 Fizz Buzz 26 Fizz 28 29 FizzBuzz 31 32 Fizz 34 Buzz Fizz 37 38 Fizz Buzz 41 Fizz 43 44 FizzBuzz 46 47 Fizz 49 Buzz Fizz 52 53 Fizz Buzz 56 Fizz 58 59 FizzBuzz 61 62 Fizz 64 Buzz Fizz 67 68 Fizz Buzz 71 Fizz 73 74 FizzBuzz 76 77 Fizz 79 Buzz Fizz 82 83 Fizz Buzz 86 Fizz 88 89 FizzBuzz 91 92 Fizz 94 Buzz Fizz 97 98 Fizz Buzz

### 1.6.3: With `sapply()` and an inline function

This approach often lets you do a task in one line of code, although
said line will be quite long.

``` r
cat(sapply(1:100, function(n) paste0(rep("Fizz", n%%3==0), rep("Buzz", n%%5==0), rep(n, !(n%%3==0|n%%5==0)))))
```

    ## 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz Fizz 22 23 Fizz Buzz 26 Fizz 28 29 FizzBuzz 31 32 Fizz 34 Buzz Fizz 37 38 Fizz Buzz 41 Fizz 43 44 FizzBuzz 46 47 Fizz 49 Buzz Fizz 52 53 Fizz Buzz 56 Fizz 58 59 FizzBuzz 61 62 Fizz 64 Buzz Fizz 67 68 Fizz Buzz 71 Fizz 73 74 FizzBuzz 76 77 Fizz 79 Buzz Fizz 82 83 Fizz Buzz 86 Fizz 88 89 FizzBuzz 91 92 Fizz 94 Buzz Fizz 97 98 Fizz Buzz

### 1.6.4: With custom operators

Remember when I said that you can’t multiply strings by integers in R?
Well, there’s no rule against creating a custom operator that replicates
that functionality as it exists in other languages! Why not create a
custom operator that lets you concatenate strings by adding them too?
Actually, you know what, having to write `n%%m==0` so many times is
rather inconvenient. That calls for a divisor operator! With these new
operators our FizzBuzz program will look much more like a corresponding
program in a more “standard” C-like language, although whether that
makes it more readable is doubtful.

``` r
`%s*%` <- function(s, n) strrep(s, n)
`%s+%` <- function(s1, s2) paste0(s1, s2)
`%|%` <- function(m, n) n%%m==0

for(i in 1:100) cat(("Fizz"%s*%(3%|%i)%s+%("Buzz"%s*%(5%|%i))%s+%(i%s*%!(3%|%i|5%|%i))), "")
```

    ## 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz Fizz 22 23 Fizz Buzz 26 Fizz 28 29 FizzBuzz 31 32 Fizz 34 Buzz Fizz 37 38 Fizz Buzz 41 Fizz 43 44 FizzBuzz 46 47 Fizz 49 Buzz Fizz 52 53 Fizz Buzz 56 Fizz 58 59 FizzBuzz 61 62 Fizz 64 Buzz Fizz 67 68 Fizz Buzz 71 Fizz 73 74 FizzBuzz 76 77 Fizz 79 Buzz Fizz 82 83 Fizz Buzz 86 Fizz 88 89 FizzBuzz 91 92 Fizz 94 Buzz Fizz 97 98 Fizz Buzz

## 1.7: Exercises (optional)

If reading about all the ways to make your code more concise has
inspired you to give it a go yourself, here are some basic tasks you can
apply it to, in no particular order of difficulty:

* Use a for loop to import multiple data files into R in one go. Hint:
use `paste0()` to generate the file paths.

* Use a while loop to simulate throwing two six-sided dice, and stop when
you roll a double six. If you want an extra challenge, record how many
throws it took. Hint: use the `sample()` function.

* Use a repeat loop to find the smallest integer obeying a logical
condition of your choice.

* Use `sapply()` to apply a different function to each column of a matrix
or data frame. Hint: you can call `sapply()` as a function inside
itself!

* Use `Reduce()` to compute an approximation to the golden ratio or the
square root of two using addition and division only. Hint: look up
continued fractions.

* Use `do.call()` to run a statistical model with two slightly different
sets of arguments.

* Have you written any custom functions before? See if you can rewrite
them as operators, and test them out in your code. If another language
has an operator you like, see if you can recreate it.
