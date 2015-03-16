# Cleaning and Transforming Data

## Goals:
# Know how to manipulate strings and clean categorical variables
# Subset and transform data frames
# Change the shape of a data frame from wide to long and back again
# Understand sorting and ordering

## Cleaning Strings
# Combine strings together using paste
# Extract sections of a string with substring
# Converting logical values - alpe_d_huez data
# we'll create a function:
yn_to_logical <- function(x)
{
  y <- rep.int(NA, length(x)) # Setting a default first lets us handle exceptions
  y[x == "Y"] <- TRUE
  y[x == "N"] <- FALSE
  return(y) # Need the last line to ensure the function returns the correct value
}
# calling it:
bikeData$DrugUse <- yn_to_logical(bikeData$DrugUse)

# You can do a lot with grep matching - regular expressions
# use stringr for everything
library(stringr)
data(english_monarchs, package = "learningr")
head(english_monarchs)

# we can look for kingdoms that merged based on commas in the domain column
# do it the way the book suggests, this keeps the row numbers
multipleKingdoms <- str_detect(english_monarchs$domain, fixed(","))
english_monarchs[multipleKingdoms, c("name", "domain")]
# or create your own data frame
english_monarchs$manyKingdoms <- str_detect(english_monarchs$domain, fixed(","))
multiKingdoms <- subset(english_monarchs, manyKingdoms, select = c(name, domain))
View(multiKingdoms)

# we can look for multiple rulers using either , or and
# use a regex
# book-style:
multipleRulers <- str_detect(english_monarchs$name, ",|and")
english_monarchs$name[multipleRulers & !is.na(multipleRulers)]

# Let's split out the rulers by multiples:
individualRulers <- str_split(english_monarchs$name, ", | and")
head(individualRulers[sapply(individualRulers, length) > 1]) # Now find the
# first instances of cases where there is more than one ruler

# how many times are old english characters used in each ruler's name?
th <- c("th", "ð", "þ")
sapply(
  th, function(th)
    {
    sum(str_count(english_monarchs$name, th))
  }
)

# we can use str_replace_all to fix all of them at once
english_monarchs$newName <- str_replace_all(english_monarchs$name, "[ðþ]", "th")

# this can be really useful for cleaning up categorical variables
gender <- c( "MALE", "Male", "male", "M", "FEMALE", "Female", "female", "f", NA )

cleanGender <- str_replace(gender, ignore.case("^m(ale)?$"), "Male")
(cleanGender <- str_replace(cleanGender, ignore.case("^f(emale)?$"), "Female"))

## Manipulating data frames
# We can add more columns, or replace existing ones
# We can deal with missing values
# We can convert between the wide and long forms of a data frame

## Adding and Replacing Columns
english_monarchs$length.of.reign.years <-
  english_monarchs$end.of.reign -
english_monarchs$start.of.reign

# with makes it easier
english_monarchs$length.of.reign.years <- with(
  english_monarchs, end.of.reign - start.of.reign)

# within returns the whole data frame, good for multiple columns
english_monarchs <- within(
  english_monarchs, {length.of.reign.years <-
                     end.of.reign - start.of.reign
                     reign.more.than.30.years <- length.of.reign.years > 30})

# you can also uses mutate in the plyr package - takes new and 
# revised columns as name-value pairs

## Dealing with Missing Values
# Use complete.cases to know which rows are free of missing values:
data("deer_endocranial_volume", package = "learningr")
has.all.measurements <- complete.cases(deer_endocranial_volume)
deer_endocranial_volume[has.all.measurements, ]

# na.omit is a good shortcut
na.omit(deer_endocranial_volume)

# na.fail throws an error if your data frame has missing values
na.fail(deer_endocranial_volume)

## Converting between wide and long form
deer.wide <- deer_endocranial_volume[, 1:5]


# if there are multiple measurements taken of one deer, we can put all the
# measurements into the correct column type, then a column with skull ID and
# a column with a factor identifying the measurement type. This is the long form

# Use reshape2
install.packages("reshape2")
library(reshape2)
deerLong <- melt(deer.wide, id.vars = "SkullID")
head(deerLong)

# you can do it with measure.vars alternatively, if you have more id vars than
# measure vars:

melt(deer.wide, measure.vars = c("VolCT", "VolBead", "VolLWH", "VolFinarelli"))

# dcast converts back from long to wide and returns the result as a data frame
deer.wide.again <- dcast(deerLong, SkullID ~ variable)
View(deer.wide.again)

# Using SQL
## sqldf allows you to manipulate data frames using SQL:
install.packages("sqldf")
library(sqldf)

# Subsets:
# R:
subset(deer_endocranial_volume, VolCT > 400 | VolCT2 > 400, c(VolCT, VolCT2))
# SQL:
query <- "SELECT VolCT, VolCT2 FROM deer_endocranial_volume
WHERE VolCT > 400 OR VolCT2 > 400"
sqldf(query)

## Sorting
# use sort

x <- c(2, 32, 4, 16, 8)
sort(x)
sort(x, decreasing = TRUE)

# Strings can be sorted, but the order depends on locale
# Use ?Comparison to know what the differences are
sort(c("I", "shot", "the", "city", "sheriff"))

# order is an inverse to sort - it refers to the index instead of the element
# x[order(x)]
# returns the same value as
# sort(x)

order(x)
x[order(x)]
identical(sort(x), x[order(x)])

# order is useful for sorting data frames
year.order <- order(english_monarchs$start.of.reign)
english_monarchs[year.order, ]

# plyr makes sorting data frames really easy
library(plyr)
arrange(english_monarchs, start.of.reign)

# rank gives the rank of each element in a dataset
(x <- sample(3, 7, replace = TRUE))
rank(x)
rank(x, ties.method = "first")

# functional programming
# negate takes a predicate (logical function), and returns the opposite
ct2 <- deer_endocranial_volume$VolCT2 # for convenience
isnt.na <- Negate(is.na)
identical(isnt.na(ct2), !is.na(ct2))

# Filter takes a function that returns a logical vector and an input vector,
# and returns only those values where the function returns TRUE
Filter(isnt.na, ct2)

# Position is kind of like which - returns the first index where applying 
# a predicate to a vector returns TRUE:
Position(isnt.na, ct2)

# Find is similar to Position, but returns the first value rather than index
Find(isnt.na, ct2)

# Map applies a function element-wise to its inputs.
# first we need a function to pass to Map
get_volume <- function(ct, bead, lwh, finarelli, ct2, bead2, lwh2) {
  # If there is a second measurement, take the average
  if (!is.na(ct2)) {
    ct <- (ct + ct2) / 2
    bead <- (bead + bead2) / 2
    lwh <- (lwh + lwh2) / 2
  }
  # Divide lwh by 4 to bring it line with the other measurements
  c(ct = ct, bead = bead, lwh.4 = lwh / 4, finarelli = finarelli)
}

measurements.by.deer <- with(deer_endocranial_volume,
                             Map(get_volume, VolCT, VolBead, VolLWH, 
                                 VolFinarelli, VolCT2, VolBead2, VolLWH2))
head(measurements.by.deer)

# Reduce turns a binary function into one that accepts multiple inputs
# Example: sum is equivalent of:
# Reduce("+", list(a, b, c, d, e))

# define a simple binary function that calculates the (parallel)
# maximum of two inputs:
pmax2 <- function(x, y) ifelse(x >= y, x, y)
Reduce(pmax2, measurements.by.deer)

# Reduce repeatedly calls the binary function on pairs of inputs, so it can only
# be used in those cases (e.g., not for calculating means)

### Exercises
# 13-1
data("hafu", package = "learningr")
head(hafu)
hafu$FatherQuestion <- str_detect(hafu$Father, fixed("?"))
head(hafu)
hafu$MotherQUestion <- str_detect(hafu$Mother, fixed("?"))
hafu <- within(hafu, {Father <- str_replace(Father, fixed("?"), "")
                      Mother <- str_replace(Mother, fixed("?"), "")})
head(hafu)

# 13-2
hafu.long <- melt(hafu, measure.vars = c("Father", "Mother"))

# 13-3
# Write a function that returns the 10 most common values in a vector,
# along with their counts. Test it on hafu

x <- c(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 6, 6, 6, 6)

GetMostCommonValues <- function(x) {
  counts <- table(x, useNA = "always")
  head(sort(counts, decreasing = TRUE), 10)
}
GetMostCommonValues(x)
GetMostCommonValues(hafu$Mother)
