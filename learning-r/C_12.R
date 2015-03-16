# Getting Data
# Chapter Goals:
## Access datasets provided with R packages
## Import data from text files
## Import data from binary files
## download data from websites
## import data from a database

# See all datasets available in loaded packages via data:
data()

# see all datasets in all installed packages:
data(package = .packages(TRUE))

# load a particular dataset
data("kidney", package = "survival")
# see the first few rows
head(kidney)

#### Reading text files
# read.table used for CSV and TSV
install.packages("learningr")
library(learningr)
data(package = "learningr")

deer_file <- system.file(
  "extdata",
  "RedDeerEndocranialVolume.dlm",
  package = "learningr"
  )

deer_data <- read.table(deer_file, header = TRUE,
                        fill = TRUE) # change the missings to NAs
str(deer_data, vec.len = 1) # vec.len alters the amount of output
str(deer_data)
head(deer_data)

# Column classes have been determined, row and column names have been assigned
# variable names are forced to be valid, and row names are added if they haven't been provided

# sep - most important argument, which determines the separator
# nrow - how many lines to read
# skip - how many lines to skip at the start

# wrappers:
## read.csv sets the default separator to a comma, assumes the data has a header row
## read.csv2 is for european data
## read.delim - tab-delimited

### Crab-data
# need the skip and nrow:

crab_file <- system.file(
  "extdata",
  "crabtag.csv",
  package = "learningr")
(crab_id_block <- read.csv(
  crab_file,
  header = FALSE,
  skip = 3,
  nrow = 2
  ))
(crab_tag_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 8,
  nrow = 5
  ))
(crab_lifetime_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 15,
  nrow = 3
  ))

# use colbycol to read part of a CSV into R
# use sqldf to read part of a csv

# scan can be used with malformed badly formatted data files

# na.strings for other languages
# for SQL exports, use na.strings = "NULL"
# for SAS or Stata, use na.strings = "."
# for Excel, use na.strings = c("", "#N/A", "#DIV/0!", "#NUM!")

## Writing files
# write.table and write.csv
# take a data frame and a file path

# Unstructured text files
# readLines - filepath or connection, max # of lines to read
text_file <- system.file(
  "extdata",
  "Shakespeare.s.The.Tempest..from.Project.Gutenberg.pg2235.txt",
  package = "learningr"
  )
the_tempest <- readLines(text_file)
the_tempest[1926:1927]

# writeLines is the reverse
writeLines(
  rev(text_file), # rev reverses a vector
  "Shakespeare's The Tempest, backwards.txt"
  )

## XML and HTML
### RSS, Simple Object Access Protocol, XHTML

install.packages("XML")
# when you import XML, you want to store things with internal nodes, not R nodes
# internal nodes allows you to use XPath
# R nodes allow you to use str and head

library(XML)
xml_file <- system.file("extdata", "options.xml", package = "learningr")
r_options <- xmlParse(xml_file)

# XPath interrogates XMl - let's you find nodes that correspond to a filter
# // - look anywhere in a document
# variable - looking for a node named this
# where [] the name attribute contains the string warn:
xpathSApply(r_options, "//variable[contains(@name, 'warn')]")

# you can use this with HTML - htmlParse

# XML is also useful for serializing/saving objects in a format
# that can be read by most other pieces of software
# serialization is available from makexml in Runiversal

install.packages("Runiversal")
library(Runiversal)
ops <- as.list(options())
cat(makexml(ops), file = "options.xml")

##### JSON and YAML Files
# XML problems - very verbose, need to explicitly specify the type of data
# (string vs number) which makes it more verbose
# YAML and JSON are intended to solve these

# rjson works well
# RJSONIO works with malformed data better
## both functions have identically-named functions

install.packages("RJSONIO")
library(RJSONIO)

jamaicanCityFile <- system.file(
  "extdata",
  "Jamaican.Cities.json",
  package = "learningr")

(jamaicanCities <- fromJSON(jamaicanCityFile))
# coordinates are currently listed as a vector
# you can turn this off with simplify = FALSE
(jamaicanCities <- fromJSON(jamaicanCityFile, simplify = FALSE))

# infinite and NaNs
# RJSONIO maps NaN and NA to null
# RJSONIO preserves positive and negative infinity

specialNumbers <- c(NaN, NA, Inf, -Inf)
toJSON(specialNumbers)

# If you have a lot of NA, NaN, or Infinite values, use YAML
install.packages("yaml")
library(yaml)

# yaml.load accepts a YAML string
# yaml.load_file accepts a filepath string for YAML

yaml.load_file(jamaicanCityFile)

# as.yaml is the reverse - converts R files to YAML strings


### Reading Binary files
# Excel files is the classic example:
# use xlsx
install.packages("xlsx")
# function xlsx2 uses Java, which is native
# Use colClasses to set data types in the data frame on import
library(xlsx)

bikeFile <- system.file(
  "extdata",
  "Alpe.d.Huez.xls",
  package = "learningr"
  )
bikeData <- read.xlsx2(
  bikeFile,
  sheetIndex = 1,
  startRow = 2,
  endRow = 38,
  colIndex = 2:8,
  colClasses = c(
    "character", "numeric", "character", "integer",
    "character", "character", "character"
    )
  )
head(bikeData)

# write.xlsx2 allows you to write excel files

##### Reading SAS, Stata, SPSS, and MATLAB
# use foreign
library(foreign)
##### Reading other file types
# Hierarchical Data Format v5 - HDF5 via h5r
# Network Common Data Format - NetCDF via ncdf
# ESRI ArcGIS spatial files - via maptools and shapefiles
# Older ArcInfo files - via RArcInfo
# Raster pictures: jpeg, png, tiff, rtiff, readbitmap
# Genomics data using Bioconductor packages
# Microarray data in GenePix GPR - via RPPanalyzer

##### Web data
# APIs -
## World Bank - World Development Indicators data
install.packages("WDI")
library(WDI)
#list all available datasets
wdiDatasets <- WDIsearch()
head(wdiDatasets)

# get one of the datasets
wdiTradeInServices <- WDI(indicator = "BG.GSR.NFSV.GD.ZS")
str(wdiTradeInServices)

# stock tickers: quantmod
install.packages("quantmod")
library(quantmod)
# If you are using a version before 0.5.0 then set this option
# or pass auto-assign = FALSE to getSymbols
options(getSymbols.auto.assign = FALSE)
microsoft <- getSymbols("MSFT")
head(microsoft)
nrow(microsoft)
length(microsoft)

# twitter - twitteR

##### Scraping Web Pages
# read.table is Internet-enabled by default
salaryURL <- "http://www.justinmrao.com/salary_data.csv"
salaryData <- read.csv(salaryURL)
str(salaryData)

# You can also download files:
localCopy <- "my local copy.csv"
download.file(salaryURL, localCopy)
salaryData <- read.csv(localCopy)

# RCurl is used for getting HTML and XML off the web
# getURL retrieves the page as a character string
install.packages("RCurl")
library(RCurl)
timeURL <- "http://tycho.usno.navy.mil/cgi-bin/timer.pl"
timePage <- getURL(timeURL)
cat(timePage)

# now you need to parse the page:
install.packages("XML")
library(XML)
timeDoc <- htmlParse(timePage)
pre <- xpathSApply(timeDoc, "//pre")[[1]]
# splitting on \n retrieves each time line
values <- strsplit(xmlValue(pre), "\n")[[1]][-1]
# splitting on \t (tabs) retrieves time/time zone pairs
strsplit(values, "\t+")

# another option is httr, which makes some things go easier:
install.packages("httr")
library(httr)
timePage <- GET(timeURL)
timeDoc <- content(page, useInternalNodes = TRUE)

##### Accessing Databases
# DBI provides a unified syntax for:
# SQLite, MySQL/MariaDB, PostgreSQL, Oracle, JDBC

install.packages("DBI")
library(DBI)
install.packages("RSQLite")
library(RSQLite)

## for SQLite
driver <- dbDriver("SQLite")
dbFile <- system.file("extdata", "crabtag.sqlite", package = "learningr")
conn <- dbConnect(driver, dbFile)

# for MySQL
# Note, this doesn't work
driver <- dbDriver("MySQL")
dbFile <- "path/to/MySQL/database"
conn <- dbConnect(driver,dbFile)

# Other libraries:
install.packages("PostgreSQL")
install.packages("ROracle")
install.packages("RJDBC")

# write queries
query <- "SELECT * FROM IdBlock"
(idBlock <- dbGetQuery(conn, query))

# when you're done, you need to disconnect and unload the driver
dbDisconnect(conn)
dbUnloadDriver(driver)

rm("conn")
rm("driver")

library(DBI)
library(RSQLite)
## Use a function to open connections, and add on.exit in the function to close and disconnect
queryCrabTagDB <- function(query)
{
  driver <- dbDriver("SQLite")
  dbFile <- system.file("extdata", "crabtag.sqlite", package = "learningr")
  conn <- dbConnect(driver, dbFile)
  on.exit(
    {
      # this code block runs at the end of the function
      # even if an error is thrown
      dbDisconnect(conn)
      dbUnloadDriver(driver)
    }
    )
  dbGetQuery(conn, query)
}

queryCrabTagDB("SELECT * FROM IdBlock")

# DBI provides some useful functions:
## dbReadTable reads a table from the connected database - SELECT *
## dbListTables(conn) lists the table names

dbReadTable(conn, "idblock")


### YOU can also do all of this via ODBC
# RODBC is the package
# you need to have an ODBC data source set up on your machine
# then:
# odbcConnect to connect to the db
# sqlQuery to run a query
# odbcClose to clean up afterward

# Mongo: 
install.packages("RMongo")
install.packages("rmongodb")

####### Exercises:
# 12-1 - import hafu.csv into a data frame

mangaFile <- system.file("extdata", "hafu.csv", package = "learningr")
mangaDF <- read.csv(mangaFile)

# 12-2 - import the first sheet of the excel file
library("xlsx")
infectionFile <- system.file("extdata",
                             "multi.drug.resistant.gonorrhoea.infection.xls",
                             package = "learningr")
infectionData <- read.xlsx2(infectionFile,
                            sheetIndex = 1,
                            startRow = 1,
                            endRow = 101,
                            colIndex = 1:4,
                            colClasses = c("numeric","character", "character", "numeric"))
str(infectionData)

# 12-3 import the Daylog table into a data frame
driver <- dbDriver("SQLite")
dbFile <- system.file("extdata", "crabtag.sqlite", package = "learningr")
conn <- dbConnect(driver, dbFile)
tempTable <- dbReadTable(conn, "Daylog")
dbDisconnect(conn)
dbUnloadDriver(driver)
