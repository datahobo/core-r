# Lists and Data Frames
# length, names, and other functions
# What is NULL?
# Recursive vs atomic variables

# a list is a vector, where each element can be a different type
(a_list <- list(c(1, 1, 2, 5, 14, 42), month.abb, 
                matrix(c(3, -8, 1, -3), nrow = 2),
                asin
                )
 )

# names() adds names to the list 
names(a_list) <- c("catalan", "months", "involuntary", "arcsin")
a_list

(the_same_list <- list(
  catalan      = c(1, 1, 2, 5, 14, 42),
  months       = month.abb,
  involuntary  = matrix(c(3, -8, 1, -3), nrow = 2),
  arcsin       = asin
  )
 )

# lists can be lists of lists.
# Nesting shouldn't go more than three or four levels deep
# lists are recursive variables because they can be lists of lists
# Vectors, matrices, and arrays are atomic variables 
# Functions to test atomicity:
is.recursive(a_list)
is.recursive(a_list$catalan)
is.atomic(a_list$catalan)

# Lists have length. Length is based on the top-level elements:
length(a_list)

# Lists do NOT have dimensions
# Vectors do NOT have dimensions
# Matrices HAVE dimensions
dim(a_list)
dim(a_list$involuntary)

# nrow doesn't work on a list
nrow(a_list)
# but NROW does
NROW(a_list)

# Arithmetic DOESN'T work with lists
# But you can do it with list elements, if they have the appropriate type:
l1 <- list(1:5)
l2 <- list(6:10)
l1[[1]] + l2[[1]]

# if you want to perform arithmetic on every element of a list, you need a LOOP
# See Chapter 8.

another_list <- list(first = 1, second = 2,
                     third = list(
                       alpha = 3.1,
                       beta = 3.2
                       )
                     )
# How to index lists
# Use single square brackets to access specific elements - as lists
another_list[1:2]
# use negative indices to access every element EXCEPT the negative ones
another_list[-3]
# use character vectors of names
another_list[c("first", "second")]
# use BOOLEAN by position
another_list[c(TRUE, TRUE, FALSE)]
another_list[c(TRUE, TRUE)]
another_list[c(TRUE, FALSE)]

# Use [[]] to accessing the contents of list elements
another_list[[1]]
# [[ ]] doesn't return a list
is.list(another_list[[1]])
# but single square brackets does
is.list(another_list[1])

# Use $ to access list elements too
another_list$first
# You don't need the full name, just a unique indicator
another_list$f

# Stack the square brackets to access nested elements:
another_list[["third"]][["beta"]]
another_list[[3]][[1]]

# Convert vectors to lists using as.list
busy_beaver <- c(1, 6, 21, 107)
as.list(busy_beaver)

# if every list element is scalar, we can use as.numeric to convert it to a vector
as.numeric(as.list(busy_beaver))

# unlist can convert non-rectangular lists to vectors
(prime_factors <- list(two = 2, three = 3,
                       four = c( 2, 2), five = 5, six = c( 2, 3),
                       seven = 7, eight = c( 2, 2, 2),
                       nine = c( 3, 3), ten = c( 2, 5)
                       )
 )
unlist(prime_factors)

# you can combine lists with c
c(list(a = 1, b = 2), list(3))
# when you combine lists with vectors,
# the vectors are converted to lists before combining
c(list(a = 1, b = 2), 3)

# you can use cbind and rbind on lists, but the results are strange

# NULL represents an empty variable
# NULL takes up no space, while NA is a scalar value
is.null(NULL)
is.null(NA)

# NULL can be used to remove elements from a list
(uk_bank_holidays_2013 <- list(
  Jan = "New Year's Day", Feb = NULL,
  Mar = "Good Friday",
  Apr = "Easter Monday",
  May = c("Early May Bank Holiday", "Spring Bank Holiday"),
  Jun = NULL,
  Jul = NULL,
  Aug = "Summer Bank Holiday",
  Sep = NULL,
  Oct = NULL,
  Nov = NULL,
  Dec = c("Christmas Day", "Boxing Day")
  )
 )

uk_bank_holidays_2013$Jan <- NULL
uk_bank_holidays_2013

# to bring it back, assign it to a list of NULL
uk_bank_holidays_2013["Jan"] <- list(NULL)


# Data frames can be created with data.frame:

(a_data_frame <- data.frame(
  x = letters[1:5],
  y = rnorm(5),
  z = runif(5) > 0.5
  )
 )
class(a_data_frame)

# Row names are take from the first vector that has names in the data frame
y <- rnorm(5)
names(y) <- month.name[1:5]
data.frame(
  x = letters[1:5],
  y = y,
  z = runif(5) > 0.5
  )
# row.names = NULL stops that
# or you can do it yourself
data.frame(
  x = letters[1:5],
  y = y,
  z = runif(5) > 0.5,
  row.names = c("jackie", "tito", "jermaine", "marlon", "michael")
  )
# rownames and row.names are the same
# colnames is an option
# dimnames is another option

# length returns ncol, not the number of elements
length(a_data_frame)

# you can set up repeating vectors easily
# they must be EXACT multiples

data.frame(
  x = 1,
  y = 2:3,
  z = 4:7
  )

# this won't work
data.frame(
  x = 1,
  y = 2:3,
  z = 4:6
  )

# Indexing Data Frames:
# Pairs of: positive integers, negative integers, logical values, and characters
a_data_frame[2:3, -3]
a_data_frame[c(FALSE, TRUE, TRUE, FALSE, FALSE), c("x", "y")]

# the results are either vectors (if one column) or data frames
class(a_data_frame[2:3, -3])
class(a_data_frame[2:3, 1])

# you can also select using double square brackets, but that doesn't seem useful

# subset takes up to three arguments:
## data frame
## logical vectors of rows to include
## optional vector of column names to keep
# subset uses the data frame as the reference point
# so no need to reference the frame

subset(a_data_frame, y > 0 | z, x)

# data frames can be transposed, but it has bad results:
## all columns are converted to the same type
# rbind re-orders columns for two data frames
# merge is also a good way to do it - when two data frames share columns
## by default, merge combines on ALL common columns
# use by = "" to specify a single column

# Cool data frame functions:
colSums(a_data_frame[, 2:3])
colMeans(a_data_frame[, 2:3])

# Exercise 5-2
iris
summary(iris)
type(iris)
str(iris)
irisNumeric <- iris[-5]
colMeans(irisNumeric)

# Exercise 5-3
beaver1
beaver1$Id <- 1
beaver2$Id <- 2
beavers <- rbind(beaver1, beaver2)
activeBeavers <- subset(beavers, activ > 0)
