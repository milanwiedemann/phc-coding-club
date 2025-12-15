#Exercise 1
add_1 <- function(x) x+1

#Exercise 2
add_y <- function(x, y) x+y

#Exercise 3
add_y <- function(x, y){
  stopifnot(is.numeric(x)&is.numeric(y))
  x+y
}

#Exercise 4
add_y <- function(x, y){
  x_ischar <- is.character(x)
  y_ischar <- is.character(y)
  if(xor(x_ischar, y_ischar)){
    stop("Can't add a character to a number")
  } else if(x_ischar&y_ischar){
    stop("Can't add two character variables")
  }
  x+y
}

#Exercise 5
add_y(2, 2)

add_y(-2, 2)

add_y("2", 2)

add_y("2", "2")

add_y(pi, 0)

add_y(Inf, 1)

add_y(NA, 1)

add_y(NULL, 1)

add_y(TRUE, FALSE)

add_y(NaN, 1)

#Many more examples are possible...

#Exercise 6
for(i in 1:5) print(i)

#Exercise 7
conc_1to5 <- function(s, position){
  if(position=="prefix"){
    for(i in 1:5) cat(s, i, " ", sep="")
  } else if(position=="suffix"){
    for(i in 1:5) cat(i, s, " ", sep="")
  }
}

#Exercise 7.5 (harder)
conc_1to5 <- function(s, position){
  switch(position, 
         "prefix"=cat(paste0(s, 1:5)),
         "suffix"=cat(paste0(1:5, s)))
}

#Exercise 8 (harder)
dieroll <- c(0, 0)
throws <- 0
while(!all(dieroll==c(6, 6))){
  dieroll <- sample(6, 2, replace=TRUE)
  throws <- throws+1
}
cat(dieroll, throws)

#Exercise 8.5 (harder)
dieroll <- c(0, 0)
throws <- 0
repeat{
  dieroll <- sample(6, 2, replace=TRUE)
  throws <- throws+1
  if(all(dieroll==c(6, 6))) break
}
cat(dieroll, throws)