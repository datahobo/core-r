# Dates and Times in Learning R

rm(list = ls())

## Goals
# Understand the built-in functions POSIXct, POSIXlt, Date
# convert a string to a date
# Display dates in a variety of formats
# Specify and manipulate time zones
# use the lubridate package

# ct is short for calendar time
# POSIXct stores dates as the number of seconds since the start of 1970 in UTC
## best for storing dates and calculating with them
# POSIXlt stores dates as a list, with components for seconds, minutes, hours, day of month, etc
## best for extracting specific parts of a date

# Sys.time
(now_ct <- Sys.time())
class(now_ct)
## unclass shows how the date is stored - as a number
unclass(now_ct)
(now_lt <- as.POSIXlt(now_ct))
class(now_lt)
unclass(now_lt)

# Date - stores as the number of days since the start of 1970
(now_date <- as.Date(now_ct))
class(now_date)
unclass(now_date)

# other classes:
## date
## dates
## chron
## yearmon
## yearqtr
## timeDate
## ti
## jul

# Parsing dates from strings, especially when importing
# strptime returns POSIXlt dates
# specify the format as a string, with symbols for each position
# fixed characters are the delimiters

moon_landings_str <- c("20:17:40 20/07/1969",
                       "06:54:35 19/11/1969",
                       "09:18:11 05/02/1971",
                       "22:16:29 30/07/1971",
                       "02:23:35 21/04/1972",
                       "19:54:57 11/12/1972"
                       )

(moon_landings_lt <- strptime(
  moon_landings_str,
  "%H:%M:%S %d/%m/%Y",
  tz = "UTC"
  ))
# if a string doesn't match the format, it returns NA.

## Formatting dates
# use strftime to format a date to a string
# %I - hour (12-hour system)
# %M - minute
# %p - AM/PM indicator
# %A - name of the day of week
# %d - date
# %B - full name of the month
strftime(now_ct, "It's %I:%M%p on %A %d %B, %Y")

# Time Zones
# see the OS date-time settings:
Sys.getlocale("LC_TIME")
### best way: Olson form of time zones - Continent/City
##### listed in the following file:
timeZoneFile <- file.path(R.home("share"), "zoneinfo", "zone.tab")
read.table(timeZoneFile)
### next best - manual offset from UTC
strftime(now_ct, tz = "UTC-5")
### worst case - use an abbreviation. But these are not unique, hard to read, and different in different operating systems

# Arithmetic with dates and times
# can do it with all 3 base classes
# adding to POSIX dates shifts them by seconds
# adding to Date dates shifts them by days
now_ct + 86400
now_lt + 86400
now_date + 1

# you can't add two dates together
# subtraction between dates works, and is the same for all types
# the units of difference are automatically chosen
# based on the difference between the times
the_start_of_time <- as.Date("1970-01-01")
the_end_of_time <- as.Date("2012-12-21")
(all_time <- the_end_of_time - the_start_of_time)
# what class is it?
class(all_time)
unclass(all_time)
# you can change the units
difftime(the_end_of_time, the_start_of_time, units = "weeks")

# use seq.Date or seq.POSIXt to generate dates
seq(the_start_of_time, the_end_of_time, by = "1 year")
seq(the_start_of_time, the_end_of_time, by = "500 days")

# You can use other functions too:
## repeat
## round
## cut
## mean
## summary

### Lubridate
# ymd figures out dates as long as they're in the correct order
library(lubridate)
johnHarrisonBirthDate <- c("1693-03 24", "1693/03\\24", "Tuesday+1693.03*24")
ymd(johnHarrisonBirthDate)
# there are other variants for other orders
## ydm
## mdy
## myd
## dmy
## dym

# you can add time to those as well
## ymd_h
## ymd_hm
## ymd_hms

# these all return POSIXct dates, and have a default time zone of UTC
# stamp lets you specify a format in a more human-readable manner.
# Use an example date, and it returns a function that you can call to format your dates
dateFormatFunction <- stamp("A moon landing occurred on Monday 01 January 1900 at 18:00:00")
dateFormatFunction(moon_landings_lt)

# for time ranges, there are three different variable types:
### Durations (as seconds)
(durationOneToTenYears <- dyears(1:10))
today() + durationOneToTenYears
##### dyears
##### dseconds
##### dminutes, etc

### Periods specify time spans according to clock time
##### their exact length isn't apparent until you add them to an instant
(periodOneToTenYears <- years(1:10))
today() + periodOneToTenYears

### Intervals are defined by the instants at their beginning and end.
##### If we know the start or end date of the duration, we can use an interval and an intermediary
##### to convert exactly from the duration to the period:

# Exercises
## Exercise 11-1
beatlesBirthDates <- ymd(c("1940-07-07", "1940-10-09", "1942-06-18", "1943-02-25"))
names(beatlesBirthDates) <- c("Ringo Starr",
                              "John Lennon",
                              "Paul McCartney",
                              "George Harrison")
beatlesBirthDates
strftime(beatlesBirthDates, "%a %d %b %y", tz = "UTC")

# Exercise 11-2
(timeZones <- data.frame(OlsonNames()))
names(timeZones)
names(timeZones) <- "OlsonNames"
library(stringr)
possibleTimeZones <- subset(timeZones, str_detect(OlsonNames, "America"))
possibleTimeZones <- subset(timeZones, str_detect(OlsonNames, "York"))

# Exercise 11-3
# function that takes a date and returns an astrological sign
whatsMySign <- function(date) {
  signsDates <- c("Aries",
                 "Taurus",
                             "Gemini",
                             "Cancer",
                             "Leo",
                             "Virgo",
                             "Libra",
                             "Scorpio",
                             "Sagittarius",
                             "Capricorn",
                             "Aquarius",
                             "Pisces")
                           )
  names(signsDates) <- c("ZodiacSigns")
  startDates <- data.frame(ymd(c("14-03-21",
                                 "14-04-20",
                                 "14-05-21",
                                 "14-06-21",
                                 "14-07-23",
                                 "14-08-23",
                                 "14-09-23",
                                 "14-10-23",
                                 "14-11-22",
                                 "14-12-22",
                                 "14-01-20",
                                 "14-02-19")
                               )
                           )
  names(startDates) <- c("startDate")
  endDates <- data.frame(ymd(c("14-04-19",
                               "14-05-20",
                               "14-06-20",
                               "14-07-22",
                               "14-08-22",
                               "14-09-22",
                               "14-10-22",
                               "14-11-21",
                               "14-12-21",
                               "14-01-19",
                               "14-02-18",
                               "14-03-20")
                             )
                         )
  names(endDates) <- c("endDate")
  signsDates <- merge(signsDates, startDates)
}