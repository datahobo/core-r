# A Scientific Calculator

# Math operations on vectors:
1:5 + 6:10
c(1, 3, 6, 10, 15) + c(0, 1, 3, 6, 10)

# You can also run summary statistics on vectors
sum(1:5)
median(1:5)

# Vectorize over an argument
# Sum works
sum(1, 2, 3, 4, 5)

# median doesn't
median(1, 2, 3, 4, 5)

# subtraction works
c(2, 3, 5, 7, 9, 11, 13, 15) - 2

# multiplication works
-2:2 * -2:2

# exponents work as ^ or **
identical(2 ^ 3, 2 ** 3)

# floating point division works
1:10 / 3

# integer division also works:
1:10 %/% 3

# Division remainders work:
1:10 %% 3

# pi is a built-in constant

# trigonometry also works built-in on vectors
cos(c(0, pi / 4, pi / 2, pi))

choose(5, 0:5)

# comparisons are also vectorized
c(3, 4 - 1, 1 + 1 + 1) == 3
1:3 != 3:1
exp(1:5) > 100
(1:5) ^ 2 >= 16

# floating point rounding
sqrt(2) ^ 2 == 2
# this is the rounding error
sqrt(2) ^ 2 - 2

# there is a function for handling rounding error
all.equal(sqrt(2) ^ 2, 2)

# Getting Booleans
isTRUE(all.equal(sqrt(2) ^ 2, 3))

# Assigning variables
x <- 1:5
y <- 6:10

x + 2 * y - 3

# variables don't have declared types in R
# you just assign values to them

# Find out more about variable names
?make.names

# you can also assign variables using the assign function
assign("myTempVariable", 3 * 4 ^ 2)
# assign to the global environment
assign("myGlobalVariable", 3 * 5 ^ 7, globalenv())

# Special numerics
Inf      # positive infinity
-Inf     # negative infinity
NaN      # missing - not a number - math didn't make sense
NA       # number - not available - missing data

# troolean logic: TRUE, FALSE, NA
# ! means not
# & means and
# | means or

x <- c(TRUE, FALSE, NA)    # three logical values
xy <- expand.grid(x = y, y = x)   # make all combinations
# make the next assignments within xy
within(xy, 
       {and <- x & y
        or <- x | y
        not.y <- !y
        not.x <- !x
        })
# any groups
# all selects
none_true <- c(FALSE, FALSE, FALSE)
some_true <- c(FALSE, TRUE, FALSE)
all_true <- c(TRUE, TRUE, TRUE)
any(none_true)
all(none_true)
any(some_true)
all(some_true)
any(all_true)
all(all_true)
