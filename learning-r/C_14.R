## Exploring and Visualizing Data
# Goals:
# Calculate a range of summary statistics on numeric data
# Draw standard plots in R's three plotting systems
# Manipulate those plots in simple ways

## Summary statistics
# recap
# mean median
# use table to get counts for mode

# using obama vs mccain 2008
data(obama_vs_mccain, package = "learningr")
obama <- obama_vs_mccain$Obama
mean(obama)

# we can use cut to generate a histogram of the numeric variable:
table(cut(obama, seq.int(0, 100, 10)))

# var calculates the variance
# sd calculates the standard deviation
var(obama)
sd(obama)
sd(obama) ^ 2
# mad is mean absolute deviation
mad(obama)
# min and max
# pmin and pmax calculate the smallest and largest
# values at each point across several vectors of the same length
pmin(obama_vs_mccain$Obama, obama_vs_mccain$McCain)
obama
View(obama_vs_mccain)
# range gives min and max in a single call
range(obama)
# cummin and cummax provide the smallest and largest values
# so far in a vector
# these are useful when the vectors are ordered
cummin(obama)

# quantile provides quantiles
# median
# minimum
# maximum
# lower quartile
# upper quartile

# IQR gives the interquartile range
IQR(obama)
length(obama)
fivenum(obama)
summary(obama_vs_mccain)

## ggplot2 graphics
install.packages("ggplot2")
library(ggplot2)
# takes a data frame as its first argument
# and an aesthetic as its second
ggplot(obama_vs_mccain, aes(Income, Turnout)) + 
  geom_point() 
# geom_point tells it to display points
ggplot(obama_vs_mccain, aes(Income, Turnout)) + 
  geom_point(color = "violet", shape = 20) 

# add scales with the scale argument
# can specify them using scientific notation
# specify as a series of breakpoints - min, max, breaks
ggplot(obama_vs_mccain, aes(Income, Turnout)) + 
  geom_point(color = "violet", shape = 20) + 
  scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) + 
  scale_y_log10(breaks = seq(50, 75, 5))

# split the plot into individual panels with a facet:
ggplot(obama_vs_mccain, aes(Income, Turnout)) + 
  geom_point(color = "violet", shape = 20) + 
  scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) + 
  scale_y_log10(breaks = seq(50, 75, 5)) + 
  facet_wrap(~ Region, ncol = 4) + 
  theme(axis.text.x = element_text(angle = 30))

# store it as a variable
(gg1 <- ggplot(obama_vs_mccain, aes(Income, Turnout)) + 
   geom_point()
 )

# Now ad the theme:
(gg2 <- gg1 + 
   facet_wrap(~ Region, ncol = 5) + 
   theme(axis.text.x = element_text(angle = 30, hjust = 1))
 )

# Line plot
data(crab_tag, package = "learningr")
# Easy to draw one line
ggplot(crab_tag$daylog, aes(Date, -Min.Depth)) + 
  geom_line()

# multiple lines is more complicated
# aesthetics calls are actually global calls
# one way to solve this is to call each depth in a separate line call
ggplot(crab_tag$daylog, aes(Date)) + 
  geom_line(aes(y = -Max.Depth)) + 
  geom_line(aes(y = -Min.Depth))

# this is clunky
# the proper way is to melt the data to long form, then group the lines:
library(reshape2)
crab_long <- melt(
  crab_tag$daylog,
  id.vars = "Date",
  measure.vars = c("Min.Depth", "Max.Depth")
  )
ggplot(crab_long, aes(Date, -value, group = variable)) + 
  geom_line()

# For two lines specifically, we can use geom_ribbon
ggplot(crab_tag$daylog, aes(Date, ymin = -Min.Depth, ymax = -Max.Depth)) + 
  geom_ribbon(color = "black", fill = "white")

## Histograms
# use geom_histogram, pass a numeric binwidth
ggplot(obama_vs_mccain, aes(Obama)) + 
  geom_histogram(binwidth = 2)
# choose between counts and densities
ggplot(obama_vs_mccain, aes(Obama, ..density..)) + 
  geom_histogram(binwidth = 5)

ovm <- within(obama_vs_mccain, Region <- reorder(Region, Obama, median))

# BoxPlots
ggplot(ovm, aes(Region, Obama)) + 
  geom_boxplot()

# Bar Charts
# remove alaska and hawaii from the data set
ovm <- ovm[!(ovm$State %in% c("Alaska", "Hawaii")),]

# we need the data in long form:
religions_long <- melt(ovm,
                       id.vars = "State",
                       measure.vars = c("Catholic", "Protestant",
                                        "Non.religious", "Other")
                       )

# use coord_flip for horizontal bars, not columns
# since the dataset has bar lengths already, use stat = "identity"
ggplot(religions_long, aes(State, value, fill = variable)) + 
  geom_bar(stat = "identity") + 
  coord_flip()

# To setup a clustered bar chart, use position = "dodge"
ggplot(religions_long, aes(State, value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip()

# To create stacked 100% bars, use position = "fill"
ggplot(religions_long, aes(State, value, fill = variable)) +
  geom_bar(stat = "identity", position = "fill") +
  coord_flip()

# GGally extends ggplot2
# interactive plots:


# Exercises
# 14-1 - Find the pearson correlation between the percentage of unemployed people and the
# percentage of people that voted for obama
names(obama_vs_mccain)
cor(obama_vs_mccain$Obama, obama_vs_mccain$Unemployment)
# Draw a scatterplot of the two variables
ggplot(obama_vs_mccain, aes(Obama, Unemployment)) + 
  geom_point()

# 14-2
names(bikeData)
tempBikeData <- melt(bikeData,
                     id.vars = "DrugUse",
                     measure.vars = "NumericTime")
names(tempBikeData)
ggplot(bikeData, aes(DrugUse, NumericTime)) + 
  geom_histogram(stat = "identity", binwidth = 5)
ggplot(bikeData, aes(DrugUse, NumericTime)) +
  geom_boxplot()
ggplot(bikeData, aes(NumericTime)) + 
  geom_histogram(binwidth = 2) + 
  facet_wrap(~ DrugUse)

data(gonorrhoea, package = "learningr")
names(gonorrhoea)
ggplot(gonorrhoea, aes(Age.Group, Rate)) +
  geom_boxplot()
ggplot(gonorrhoea, aes(Year, Rate / length(Rate))) +
  geom_histogram(stat = "identity", binwidth = 1)
ggplot(gonorrhoea, aes(Ethnicity, Rate)) +
  geom_histogram(stat = "identity", binwidth = 1)
ggplot(gonorrhoea, aes(Ethnicity, Rate / length(Rate))) +
  geom_histogram(stat = "identity", binwidth = 1)

# From the book
# group - which values belong in the same bar
# fill to give each bar a different fill color
# position = "dodge" to put the bars next to each other

ggplot(gonorrhoea, aes(Age.Group, Rate, group = Year, fill = 
                         Year)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  facet_wrap(~ Ethnicity + Gender)

# use facet_grid to organize them, since we have a dichotomous variable

ggplot(gonorrhoea, aes(Age.Group, Rate, group = Year, color = Year)) + 
  geom_line() + 
  facet_grid(Ethnicity ~ Gender)
# give each row a different y scale
ggplot(gonorrhoea, aes(Age.Group, Rate, group = Year, color = Year)) + 
  geom_line() + 
  facet_grid(Ethnicity ~ Gender, scales = "free_y")
