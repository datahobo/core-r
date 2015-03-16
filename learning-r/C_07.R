# Strings and Factors ##

# Goals:
## Construct new strings from existing strings
## format how numbers are printed
## understand special characters like tab and newline
## Be able to create and manipulate factors

# text is stored in character vectors, which are strings
# most string operators are vectorized

# double quotes should be used most of the time
# But single quotes can be used when you're also trying to 
# include the quote symbol in the string

c("You should use double quotes",
  'Single quotes are better for including " inside the string')

# paste combines strings, with a space
paste(c("red", "yellow"), "lorry")

# add sep to connect them
paste(c("red", "yellow"), "lorry", sep = "-")

# collapse puts it all into one string
paste(c("red", "yellow"), "lorry", collapse = ", ")

# paste0 does it without a space
paste0(c("red", "yellow"), "lorry")

# toString prints vectors, and can be limited by width
x <- (1:15) ^ 2
toString(x)
toString(x, width = 40)

# cat is available as well, but it's usually reserved
# for print functions

# noquote makes text more readable
x <- c("I", "saw", "a", "saw", "that", "could", "out",
       "saw", "any", "other", "saw", "I", "ever", "saw")
y <- noquote(x)
x
y

## Formatting Numbers
pow <- 1:3
(powers_of_e <- exp(pow))
formatC(powers_of_e)
# set significant figures
formatC(powers_of_e, digits = 3)
# set preceding spaces
formatC(powers_of_e, digits = 3, width = 10)
# scientific formatting
formatC(powers_of_e, digits = 3, format = "e")

# sprintf formats strings with numbers
sprintf("%s %d = %f", "Euler's constant to the power",
        pow, powers_of_e)

format(powers_of_e)

# prettyNum is great for huge or tiny numbers
prettyNum(c(1e10, 1e-20), big.mark = ",",
          small.mark = " ",
          preserve.width = "individual",
          scientific = FALSE)

# special characters:
## tab: \t
## need to use cat and fill = TRUE
cat("foo\tbar", fill = TRUE)
## new line
cat("foo\nbar", fill = TRUE)
# \
cat("foo\\bar", fill = TRUE)
# "
cat("foo\"bar", fill = TRUE)
# '
cat('foo\'bar', fill = TRUE)

# you can switch single and double quotes
# to avoid using the escape backslash

cat("foo'bar")
cat('foo"bar')

# Changing case
toupper("I'm Shouting")
tolower("I'm Whispering")

# extracting substrings
# substring, the output is as long as the longest input
woodchuck <- c( "How much wood would a woodchuck chuck",
                "If a woodchuck could chuck wood?",
                "He would chuck, he would, as much as he could",
                "And chuck as much wood as a woodchuck would",
                "If a woodchuck could chuck wood." )
substring(woodchuck, 1:6, 10)
substr(woodchuck, 1:6, 10)

# splitting strings
# fixed = TRUE means you're not using a regular expression
strsplit(woodchuck, " ", fixed = TRUE)
# this returns a list
# use a regex to eliminate the commas
strsplit(woodchuck, ",? ")

# file paths
getwd()
setwd("/Users/mwakeman/Documents/Archer/github/")
getwd()
setwd("/Users/mwakeman/Documents/Archer/github/Learning R")

# Use file.path to put the slashes in between directories
file.path("", "Users", "mwakeman", "Documents", "Archer", "github")

# where is the home directory?
R.home()

# Where is the user directory?
path.expand("~")
file_name <- R.home()
# basename is the name of the file
basename(file_name)
# dirname is the name of the path
dirname(file_name)


## Factors
# R creates these automatically in data frames

(heights <- data.frame(height_cm = c(153, 181, 150, 172, 165,
                                     149, 174, 169, 198, 163),
                       gender = c( "female", "male", "female",
                                   "male", "male", "female",
                                   "female", "male", "male",
                                   "female" ) ))

class(heights$gender)
heights$gender
# factors store their information in levels
levels(heights$gender)
# how many levels in a factor?
nlevels(heights$gender)

# can also create them via factor function

gender_char <- heights$gender
levels(gender_char)
# Change the order of factor levels using the same function
factor(gender_char, levels = c("male", "female"))

#### DON"T CHANGE THE LEVELS DIRECTLY VIA THE LEVELS FUNCTION

# how to change levels:
relevel(gender_char, "female")

# DROPPING FACTOR LEVELS
getting_to_work <- data.frame(
  mode = c( "bike", "car", "bus", "car", "walk", "bike",
            "car", "bike", "car", "car" ),
  time_mins = c( 25, 13, NA, 22, 65, 28, 15, 24, NA, 14) )

# Remove the NAs
(getting_to_work <- subset(getting_to_work, !is.na(time_mins)))

unique(getting_to_work$mode)
# Now there are three levels used, but four in the factor

getting_to_work$mode <- droplevels(getting_to_work$mode)
levels(getting_to_work$mode)


#### Ordered Factors

happy_choices <- c("depressed", "grumpy", "so-so", "cheery", "ecstatic")
happy_values <- sample(happy_choices, 10000, replace = TRUE)
happy_fac <- factor(happy_values, happy_choices)
head(happy_fac)
# now let's make it ordered
happy_ord <- ordered(happy_values, happy_choices)
head(happy_ord)

# Ordered factors are factors, but factors aren't ordered

#### Creating categorical variables from continuous variables
# cut splits groups by intervals in the continuous variable
ages <- 16 + 50 * rbeta(10000, 2, 3)
grouped_ages <- cut(ages, seq.int(16, 66, 10))
head(grouped_ages)
table(grouped_ages)
# the numeric is a numeric and the grouped variable is a factor
class(ages)
class(grouped_ages)

# Converting factors to numeric

dirty <- data.frame( x = c("1.23", "4..56", "7.89") )
as.numeric(dirty$x)
# this shows the underlying levels
# you can reconstruct a factor f:
# levels(f)[as.integer(f)]

as.numeric(as.character(dirty$x))
# best to convert the factor levels to be numeric, then reconstruct the fact
as.numeric(levels(dirty$x))[as.integer(dirty$x)]

factorToNumeric <- function(f) as.numeric(levels(f))[as.integer(f)]

# you can combine factors using gl
treatment <- gl(3, 2, labels = c("placebo", "drug A", "drug B"))
gender <- gl(2, 1, 6, labels = c("female", "male"))
interaction(treatment, gender)

# exercises
# Display the value of pi to 16 significant digits
formatC(pi, 16)

# split these strings into words, removing commas and hyphens
x <- c( "Swan swam over the pond, Swim swan swim!",
        "Swan swam back again - Well swum swan!" )

(newString <- strsplit(x, "(,|-)? "))

# Look up the scores for a set of 1,000 random dice throws
three_d6 <- function(n)
  #n specifies the number of scores to generate.
  #It should be a natural number.
{
  random_numbers <- matrix(
    sample(6, 3 * n, replace = TRUE), nrow = 3)
  colSums(random_numbers)
}

# this is one way to do it. A little awkward, but it works.
# create the lookup table
scoreLookup <- 1:18
scoreLookup <- data.frame(scoreLookup)
scoreLookup$score[3] <- '-3'
scoreLookup$score[4:5] <- '-2'
scoreLookup$score[6:8] <- '-1'
scoreLookup$score[9:12] <- '0'
scoreLookup$score[13:15] <- '1'
scoreLookup$score[16:17] <- '2'
scoreLookup$score[18] <- '3'

# now create a data frame
diceRolls <- data.frame(three_d6(1000))
# check the output
table(diceRolls)
# now add the lookups as a merge
diceRolls <- merge(diceRolls, scoreLookup$score, by.x = 'three_d6.1000.', by.y = 'row.names')
# check the output
table(diceRolls)
