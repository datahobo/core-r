# Environments and functions

# environments are another type of variable:
## assign them
## manipulate them
## pass them into functions as arguments
# They are very much like lists, and most of the syntax applies

# They apply to variable scope and debugging (examining the call stack)

# Create a new enviroment:
an_environment <- new.env()

# Assign variables with [[]] or $
an_environment[["pythag"]] <- c (12, 15, 20, 21)
an_environment$root <- polyroot(c(6, 5, -1))

# you can use assign, the third option is for the environment
assign("moonday",
       weekdays(as.Date("1969/07/20")),
       an_environment)

# you can retreive variables the same way
an_environment[["pythag"]]

get("moonday", an_environment)

# you can use ls with envir to get the contents of environments
ls(envir = an_environment)
ls.str(envir = an_environment)

# also, exists works
exists("pythag", an_environment)

# these functions work as well
temp_list <- as.list(an_environment)
temp_environment <- as.environment(temp_list)
ls.str(temp_environment)

# exists and get look in the specified environment and all parent environments
# use inherits = FALSE to change that

nested_environment <- new.env(parent = an_environment)
exists("pythag", nested_environment)
exists("pythag", nested_environment, inherits = FALSE)

# Functions
# all variables defined by a function are stored
# in an environment belonging to that function

rt
# in r, the last value that is calculated is automatically returned by the function

# creating our own function

hypotenuse <- function(x, y)
{
  sqrt(x ^ 2 + y ^ 2)
}

# a shorter way to define it (since it's only one line of code in the function)

hypotenuse <- function(x, y) sqrt(x ^ 2 + y ^ 2)
hypotenuse(3, 4)
hypotenuse(y = 24, x = 7)

# r maps arguments based on position, unless you call them
# using the variable names defined in the function

# setting defaults
hypotenuse <- function(x = 5, y = 12) sqrt(x ^ 2 + y ^ 2)

hypotenuse
hypotenuse()

# getting information on the arguments of a function
formals(hypotenuse)
args(hypotenuse)
formalArgs(hypotenuse)

bodyOfHypotenuse <- body(hypotenuse)
# read a function as text
deparse(hypotenuse)
deparse(bodyOfHypotenuse)

# normalize scales a vector so that the mean is 0 and the SD is 1
normalize <- function(x, m = mean(x), s = sd(x))
{
  (x - m) / s
}

normalized <- normalize(c(1, 3, 6, 10, 15))
mean(normalized)
sd(normalized)
normalize(c(1, 3, 6, 10, NA))

# you can fix this with optional arguments to mean & sd
normalize <- function(x, m = mean(x, na.rm = na.rm), 
                      s = sd(x, na.rm = na.rm), na.rm = FALSE)
{
  (x - m) / s
}

# now try it
normalize(c(1, 3, 6, 10, NA))
# doesn't work. Add the additional argument
normalize(c(1, 3, 6, 10, NA), na.rm = TRUE)

# now you can make the syntax less clunky by 
# saving the space of arguments that aren't being used by the main function
# ...

normalize <- function(x, m = mean(x, ...), s = sd(x, ...), ...)
{
  (x - m) / s
}

normalize(c(1, 3, 6, 10, NA), na.rm = TRUE)
# basically the ... is a generic placeholder that allows you
# to pass any argument into subfunctions

# do.call allows you to pass arguments to other functions as a list
dfr1 <- data.frame( x = 1: 5, y = rt( 5, 1))
dfr2 <- data.frame( x = 6: 10, y = rf( 5, 1, 1))
dfr3 <- data.frame( x = 11: 15, y = rbeta( 5, 1, 1))

do.call( rbind, list( dfr1, dfr2, dfr3)) #same as rbind( dfr1, dfr2, dfr3)

# when using functions as arguments, it isn't necessary to define them first
xPlusY <- function(x, y) x + y
do.call(xPlusY, list(1:5, 5:1))
# can also do it this way:
do.call(function(x, y) x + y, list(1:5, 5:1))

## Variable Scope ##
# when you define variables inside functions, the rest of the statements
# have access to the variable
# subfunctions also have access to the variable

# variables defined in the global environment are accessible everywhere

# replicate runs a function multiple times
replicate(10, hypotenuse(1:5, 5:1))

# better to explicitly pass all needed variables into a function

# exercise 1
multiples_of_pi <- new.env()
multiples_of_pi[["two_pi"]] <- 2 * pi
multiples_of_pi$three_pi <- 3 * pi
assign("four_pi", 4 * pi, env = multiples_of_pi)
# now check the work
ls(multiples_of_pi)
ls.str(multiples_of_pi)

# exercise 2
integerTest <- function(x) (x / 2) == (x %/% 2)

integerTest(2)
integerTest(-2)
integerTest(0)
integerTest(1)
integerTest(-5)
integerTest(Inf)
integerTest(-Inf)
integerTest(NA)
integerTest(NaN)

# exercise 3
deconstructing <- function(x)
{
  argsT <- list(formalArgs(x))
  bodyT <- body(x)
  temp <- as.list(c(args = argsT, body = bodyT))
  
  return(temp)
}
deconstructing(integerTest)
deconstructing(hypotenuse)

args(hypotenuse)
formalArgs(hypotenuse)
