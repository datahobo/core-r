# Packages

# pass package names without quotes
library(lattice)
## if you have a character vector of packages, you can use character.only = TRUE

pkgs <- c("lattice", "utils", "rpart")
for( pkg in pkgs)
{
  library(pkg, character.only = TRUE)
}

# require allows you to test for a package's availability, returns false if not available

# see all the loaded packages:
search()

# see a list of all the installed packages:
View(installed.packages())

update.packages(ask = FALSE)

# Exercise 10-3
nrow(installed.packages())
