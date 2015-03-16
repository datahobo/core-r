# Flow Control and Loops
## Goals: branch the flow of execution
## repeatedly execute code with loops

# if and else
# simplest form of control
# if doesn't work with missing values:

if(TRUE) message("It was true!")
if(FALSE) message("It was false!")
if(NA) message("Who knows if it was true?")

# so if statements should test for NA:
if(is.na(NA)) message("It was missing!")

if(runif(1) > 0.5) message("This is a 50% message.")

# use curly braces for several statements

# if-else statements
if(FALSE)
{
  message("This won't execute")
} else # these MUST BE ON THE SAME LINE
{
  message("But this will execute")
}

# you can combine multiple if else conditions
(r <- round(rnorm(2), 1))
(x <- r[1] - r[2])
if(is.nan(x))
{
  message("x is missing")
} else if(is.infinite(x))
{
  message("x is infinite")
} else if(x > 0)
{
  message("x is positive")
} else if(x < 0)
{
  message("x is negative")
} else
{
  message("x is zero")
}

# r allows you to re-order the code and do conditional assignment
(x <- sqrt(-1 + 0i))
(reality <- if(Re(x) == 0) "real" else "imaginary")
# Re returns the real component of a complex number

# if can be vectorized to handle vector conditions:
## use ifelse(logicalVectorOfConditions, vectorOfValuesReturnedWhenTRUE,
##            vectorOfValuesReturnedWhenFALSE)

# rbinom simulates a coin flip
ifelse(rbinom(10, 1, 0.5), "Head", "Tail")
# Vectors for True & False:
# They should be the same size as the first vector, or they will be recycled/ignored
(yn <- rep.int(c(TRUE, FALSE), 6))
ifelse(yn, 1:3, -1:-12)

# if there are missing values in the conditional, then the values in the results will be missing
yn[c(3, 6, 9, 12)] <- NA
ifelse(yn, 1:3, -1:-12)

# R has a switch function!!!
# the first argument returns a string
# the following arguments are the results when they match exactly the string returned
(greek <- switch("gamma",
                 alpha = 1,
                 beta = sqrt(4),
                 gamma = 
                   {
                     a <- sin(pi / 3)
                     4 * a ^ 2
                   }
                 ))
# if no names match, then switch returns NULL
(greek <- switch("delta",
                 alpha = 1,
                 beta = sqrt(4),
                 gamma = 
                  {
                    a <- sin(pi / 3)
                    4 * a ^ 2
                  }
))
# you can provide an unnamed argument which is the default
(greek <- switch("delta",
                 alpha = 1,
                 beta = sqrt(4),
                 gamma = 
                  {
                    a <- sin(pi / 3)
                    4 * a ^ 2
                  },
                  4
))

# switch also works with integer returns - then you don't need names.
# when switch uses an integer, the arguments are returned based on placement
# e.g., the first argument after switch is returned when switch evaluates to 1,
# the second when switch evaluates to 2, and so on

switch(3,
       "first",
       "second",
       "third",
       "fourth")
# there's no default argument in this case. It also works poorly for large values
# so if you're going to be returning large values, convert it to a string


##### Loops
## repeat
## while
## for

# vectorization means that you don't need them much in R
# you need an exit plan
# use break to exist a repeat loop
repeat
{
  message("Happy Groundhog Day!")
  action <- sample(c( "Learn French",
                      "Make an ice statue",
                      "Rob a bank",
                      "Win heart of Andie McDowell"),
                   1
  )
  message("action = ", action)
  if(action == "Win heart of Andie McDowell") break
}

# you can also have a next iteration plan
# use next to skip to the next iteration
repeat
{
  message("Happy Groundhog Day!")
  action <- sample(c( "Learn French",
                      "Make an ice statue",
                      "Rob a bank",
                      "Win heart of Andie McDowell"),
                   1
  )
  if(action == "Rob a bank")
  {
    message("Quietly skipping to the next iteration")
    next
  }
  message("action = ", action)
  if(action == "Win heart of Andie McDowell") break
}

# while loops are the reverse of a repeat loop
# while loops check at the beginning of the loop, repeat loops check at the end of the loop

action <- sample(c( "Learn French",
                    "Make an ice statue",
                    "Rob a bank",
                    "Win heart of Andie McDowell"),
                 1
)
while(action != "Win heart of Andie McDowell")
{
  message("Happy Groundhog Day!")
  action <- sample(c( "Learn French",
                      "Make an ice statue",
                      "Rob a bank",
                      "Win heart of Andie McDowell"),
                   1
  )
  message("action = ", action)
}

#### For loops
# uses an iterator variable and a vector of values
for(i in 1:5) message("i = ", i)

for(i in 1:5)
{
  i <- i ^ 2
  message("i = ", i)
}

# we can use characters and character vectors in loops too!!!!
for(month in month.name) message("The month of ", month, " is next.")

# Booleans
for(yn in c(TRUE, FALSE, NA))
{
  message("This message is ", yn)
}
# Lists...
l <- list(pi,
          LETTERS[1: 5],
          charToRaw("not as complicated as it looks"),
          list(TRUE)
)
for(i in l)
{
  print(i)
}

# in R, for loops run much more slowly than their vectorized equivalents

# Exercises
# 8-1 - Craps
two_d6 <- function(n)
{
  random_numbers <- matrix(
    sample(6, 2 * n, replace = TRUE),
    nrow = 2)
  colSums(random_numbers)
}
# write the craps score function based on the table of scores in the book
craps_score <- function(score)
{
  if(any(score == 2, score == 3, score == 12))
  {
    g <- FALSE
    p <- NA
  } else if(any(score == 7, score == 11))
  {
    g <- TRUE
    p <- NA
  } else if(any(score == 4, score == 5, score == 6,
                score == 8, score == 9, score == 10))
  {
    g <- NA
    p <- score    
  }
  craps <- as.list(c(game_status = g, point = p))
}

(temp <- craps_score(two_d6(1)))
temp$game_status
temp$point

# Exercise 8-2
# write a loop that follows the rules:
# if the shooter doesn't immediately win or lose, 
# he must keep rolling the dice until:
## he scores the point value and wins
## or scores a 7 and loses

(dice <- two_d6(1))
(game <- craps_score(dice))
if(is.na(game$game_status))
{
  finalPoint <- game$point
  i <- 0
  repeat
  {
    p <- two_d6(1)
    i <- i + 1
    if(p == finalPoint) break
  }
  message("You won with ", p, " points, in ", i, " throws of the dice.")
} else message("You ", ifelse(game$game_status, "won", "lost"), " the game.")


# Exercise 8-3
# count the number of letters in each word, using nchar
# then loop over possible word lengths, messaging which words have that length
sea_shells <- c("She", "sells", "sea", "shells", "by", "the", "seashore", "The",
                "shells", "she", "sells", "are", "surely", "seashells", "So",
                "if", "she", "sells", "shells", "on", "the", "seashore", "I'm",
                "sure", "she", "sells", "seashore", "shells" )

sea_shell_characters <- nchar(sea_shells)
max(sea_shell_characters)
for(i in min(sea_shell_characters):max(sea_shell_characters)) {
  matchingWords <- sea_shell_characters == i
  print(toString(unique(sea_shells[sea_shell_characters == i])))
}
