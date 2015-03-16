# This file contains a set of common code functions relating to time

dayLevels <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31)
dayLabels <- c('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31')
monthLabels <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
yearLevels <- c(1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,2011, 2012, 2013, 2014)
yearLabels <- c("1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014")
weekdayLabels <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

Day <- factor(data$Day, dayLevels, dayLabels, ordered = TRUE)
Month <- factor(data$QMonth, month.name, monthLabels, ordered = TRUE)
Year <- factor(data$Year, yearLevels, yearLabels, ordered = TRUE)
