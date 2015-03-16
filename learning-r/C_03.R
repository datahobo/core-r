# Inspecting Variables and your workspace
# This is the source file for all the examples, questions, and exercises from Chapter 3.
## Chapter Run-through: 2

# Classes define the type of variables:
class(c(TRUE, FALSE))

# Numeric classes:
## numeric
## integer
## complex

class(sqrt(1:10))
class(3i + 1L)
class(1)
class(1L)
class(0.5:4.5)
class(1:5)

# Other classes
## character
## factor
## raw

class(c("she", "sells", "seashells", "by", "the", "seashore"))

# Factors store levels as numerics but report as characters
(gender <- factor(c("male", "female", "male", "female", "male")))
levels(gender)
nlevels(gender)
as.integer(gender)
as.numeric(gender)

# factors are more efficient at storage
gender_char <- sample(c("female", "male"), 10000, replace = TRUE)
gender_fac <- as.factor(gender_char)
object.size(gender_char)
object.size(gender_fac)

# Raw can be used on integers; for characters use charToRaw
# imaginary numbers get discarded from raw
as.raw(1:17)
as.raw(c(pi, 1 + 1i, -1, 256))
(sushi <- charToRaw("Fish!"))
class(sushi)

# Other variable types:
# Vectors (above)
# Arrays
## Matrices - two-dimensional arrays
# Lists - contain multiple types of variables
# Data Frames - combination of lists (multiple data types) and matrices (rectangular)

# Changing classes:
is.character("red lorry")
is.logical(FALSE)

# Find all the is functions:
ls(pattern = "^is", baseenv())

# Assertive has a more consistent naming scheme
install.packages("assertive")

# there are is.numeric and is.double
is.numeric(1)
is.numeric(1L)
is.integer(1)
is.integer(1L)
is.double(1)
is.double(1L)

# casting changes a type
x <- "123.456"
as(x, numeric)
as(x, "numeric")
# need to use a specific cast for data frames
y <- c(2, 12, 243, 34997)
as(y, "data.frame")
as.data.frame(y)

# printing happens automatically most of the time, but not inside loops
ulams_spiral <- c(1, 8, 23, 46, 77)
for(i in ulams_spiral) i
for(i in ulams_spiral) print(i)

# summarizing variables can be useful:
summary(gender)
summary(gender_char)
summary(gender_fac)
summary(sushi)

# runif generates random numbers between 0 and 1
num <- runif(30)
summary(num)

# letters contains the lowercase letters
fac <- factor(sample(letters[1:5], 30, replace = TRUE))
summary(fac)

bool <- sample(c(TRUE, FALSE, NA), 30, replace = TRUE)
summary(bool)

# Matrices and data frames are summarized by column

dfr <- data.frame(num, fac, bool)
# head shows us just the first few rows
head(dfr)
summary(dfr)

# View opens it up in a different window
# limit to the first 10 rows:
View(head(dfr, 10))

# str shows an object's structure
str(num)
str(fac)
str(bool)
str(dfr)

# unclass can expose hidden information
unclass(fac)

# attributes are parts of variables
attributes(dfr)
attributes(fac)

# Finding variables
peach <- 1
plum <- "fruity"
pear <- TRUE

# list all the viewable variables
ls()

# subset the list
ls(pattern = "ea")

# Export the environment list/structure to HTML
browseEnv()

# Removing variables
rm(peach, plum, pear)


# Exercises:
class(Inf)
typeof(Inf)
mode(Inf)
storage.mode(Inf)

class(NA)
typeof(NA)
mode(NA)
storage.mode(NA)

class(NaN)
typeof(NaN)
mode(NaN)
storage.mode(NaN)

class(" ")
typeof(" ")
mode(" ")
storage.mode(" ")

pets <- factor(sample(c("dog", "cat", "hamster", "goldfish"), 1000, replace = TRUE))
summary(pets)
head(pets)

ls(pattern = "a")
