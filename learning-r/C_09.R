# Advanced Looping

### Goals:
#### apply a function to every element of a list or vector
#### apply a function to every row or column of a matrix
#### solve split-apply-combine problems
#### use the plyr package

# replication
# rep repeats its input several times
# replicate calls an expression several times
# Difference is in random numbers
## rep repeats the same random number several times
## replicate gives a different number each time

rep(runif(1), 5)
replicate(5, runif(1))

# replicate is really useful in Monte Carlo simulations

# example of estimating time to work for different transport methods

time_for_commute <- function()
{
  # Choose a mode of transport for the day
  mode_of_transport <- sample(
    c("car", "bus", "train", "bike"),
    size = 1,
    prob = c(0.1, 0.2, 0.3, 0.4)
    )
  # Find the time to travel, depending on mode of transport
  time <- switch(
    mode_of_transport,
    car = rlnorm(1, log(30), 0.5),
    bus = rlnorm(1, log(40), 0.5),
    train = rnorm(1, 30, 10),
    bike = rnorm(1, 60, 5)
    )
  names(time) <- mode_of_transport
  time
}

# now we use replicate to get data for each day:

replicate(5, time_for_commute())

# vectorization is available in most cases
# it's much faster and more efficient
# apply series of functions gives you pretend vectorization
## lapply - short for list apply
# takes a list and function as inputs
# applies the function to each element of the list
# returns a list of results

prime_factors <- list(
  two   = 2,
  three = 3,
  four  = c(2, 2),
  five  = 5,
  six   = c(2, 3),
  seven = 7,
  eight = c(2, 2, 2),
  nine  = c(3, 3),
  ten   = c(2, 5)
  )
head(prime_factors)

# how to find the uniques?
# we could use a for loop:
unique_primes <- vector("list", length(prime_factors))
for(i in seq_along(prime_factors))
{
  unique_primes[[i]] <- unique(prime_factors[[i]])
}
names(unique_primes) <- names(prime_factors)
unique_primes

# but in lapply:
lapply(prime_factors, unique)

# you can also use a variant called vapply, which returns vectors.
# it takes three arguments:
## list, function, template for return values

vapply(prime_factors, length, numeric(1))
# if the output doesn't fit the template, it will throw an error.

# there's a third variant sapply
## sapply takes a list and a function
## it tries to simplify the output to an appropriate vector or array if it can

sapply(prime_factors, unique)
sapply(prime_factors, length)
sapply(prime_factors, summary)
sapply(prime_factors, mean)

# but there can be problems if you don't know what you're passing it
sapply(list(), length)
# if the input has length zero, then sapply always returns a list
# if your data could be empty, and you know the return value, use vapply

# let's run all of the scripts in the working directory
# first we need a list of all the matching filetypes
(r_files <- dir(pattern = "\\.R$"))
# lapply(r_files, source)

# You can only pass ONE VECTORIZED argument to a function using lapply, etc
# You can pass other SCALAR arguments to the functions though
# Pass them as named arguments

complemented <- c(2, 3, 6, 18)
lapply(complemented, rep.int, times = 4)

# if the vector argument isn't the first argument called in the function,
# you have to create your own function wrapper for it
rep4x <- function(x) rep.int(4, times = x)
lapply(complemented, rep4x)

# in recent versions of R you can use lapply to loop through every variable in an environment

# apply is a recent version of the function
## it takes a matrix, a dimension number, and a function as arguments
## for applying functions on rows of the matrix, dimension = 1
## for applying functions on columns of the matrix, dimension = 2
## when applied to a data.frame by column, it works exactly the same as sapply

# lapply can only be applied to one vector at a time
# also, you don't have access to the name of the element upon which the function is being run
## mapply allows you to pass in as many vectors as you'd like
## you can pass in a list in one argument, and the names in another
## mapply(function, parameters)
msg <- function(name, factors)
{
  ifelse(
    length(factors) == 1,
    paste(name, "is prime"),
    paste(name, "has factors of", toString(factors))
    )
}
mapply(msg, names(prime_factors), prime_factors)

### VECTORIZE gives you instant vectorization
baby_gender_report <- function(gender)
{
  switch(
    gender,
    male = "It's a boy!",
    female = "It's a girl!",
    "hmmm....."
    )
}
# if we pass a vector in, it will give us an error
genders <- c("male", "female", "other")
baby_gender_report(genders)
# interesting. You have to create a vectorized version of the function
# BEFORE you use it. You can't Vectorize the function in-line
Vectorize(baby_gender_report(genders))
vectorized_baby_gender_report <- Vectorize(baby_gender_report)
vectorized_baby_gender_report(genders)

# Split-Apply-Combine
## Or, how to do an anova (means by)
(frogger_scores <- data.frame(
  player = rep(c("Tom", "Dick", "Harry"),
  times = c(2, 5, 3)),
  score = round(rlnorm( 10, 8), -1)
  )
 )
# calculating the mean score by player - split, apply, combine
# split the dataset
(scores_by_player <- with(frogger_scores, split(score, player) ))
# apply the mean
(list_of_means_by_player <- lapply(scores_by_player, mean))
(means_by_player <- unlist(list_of_means_by_player))

# tapply does all three of these at once!
with(frogger_scores, tapply(score, player, mean))

# the apply functions are nice, but hard to understand
# the arguments aren't consistent across functions

## plyr is much better here, because it contains a set of functions
## that are named based on their inputs and outputs
## llply takes a list input, applies a function to each element, and returns a list
library(plyr)
llply(prime_factors, unique)
## laply takes a list and returns an array
laply(prime_factors, length)

## raply replaces replicate
## rlply returns a list
## rdply returns a data frame
raply(5, runif(1))
rlply(5, runif(1))
rdply(5, runif(1))
## r_ply discards the output - useful for drawing plots
r_ply(5, runif(1))

## The most commonly used function is ddply, which takes data frames as inputs and outputs
## it's a replacement for tapply
## makes it easy to make calculations on several columns at once
frogger_scores$level <- floor(log(frogger_scores$score))
## use colwise to call the function on every column except the splitting factor
ddply(
  frogger_scores,
  .(player),
  colwise(mean)
  )
# use summarize to call specific functions on specific columns
ddply(
  frogger_scores,
  .(player),
  summarize,
  mean_score = mean(score),
  max_level = max(level)
  )

ddply(
  frogger_scores,
  .(player),
  summarize,
  max_score = max(score),
  max_level = max(level)
  )

ddply(
  frogger_scores,
  .(player),
  summarize,
  max_score = max(score),
  mean_level = mean(level)
  )

# Exercises
# Exercise 9-1: loop over the list of children in the wayans family. How many children
# does each of the first generation of wayans have?
wayans <- list("Dwayne Kim" = list(),
               "Keenen Ivory" = list("Jolie Ivory Imani",
                                     "Nala",
                                     "Keenen Ivory Jr",
                                     "Bella",
                                     "Daphne Ivory"),
               Damon = list("Damon Jr",
                            "Michael",
                            "Cara Mia",
                            "Kyla"),
               Kim = list(),
               Shawn = list("Laila",
                            "Illia",
                            "Marlon"),
               Marlon = list("Shawn Howell",
                             "Arnai Zachary"),
               Nadia = list(),
               Elvira = list("Damien",
                             "Chaunté"),
               Diedre = list("Craig",
                             "Gregg",
                             "Summer",
                             "Justin",
                             "Jamel"),
               Vonnie = list()
)
# Exploring
length(wayans)
str(wayans)
# Getting the number of kids
lapply(wayans, length)

# Exercise 9-2
state.x77
str(state.x77)
# get the mean and sd for each column in state.x77
apply(state.x77, 2, mean)
apply(state.x77, 2, sd)

# Exercise 9-3
commute_times <- replicate(1000, time_for_commute())
commute_data <- data.frame(
  time = commute_times,
  mode = names(commute_times)
  )
summary(commute_data)
ddply(
  commute_data,
  .(mode),
  summary)
