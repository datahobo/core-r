# Working with Maps
install.packages("maps")
library(maps)
install.packages("stringr")
library(stringr)
# plot the countries on a map
# vector of the countries I've traveled to
myCountries <- c('usa', 'canada', 'mexico',
                 'ussr', 'uk', 'italy', 'portugal',
                 'costa rica', 'colombia', 'ecuador', 'peru', 'chile',
                 'argentina', 'uruguay', 'bolivia',
                 'falkland islands', 'antarctica')
# vector of the colors to map to the countries
myColors <- c('darkgreen', 'darkgreen', 'darkgreen', 
              'darkgreen', 'darkgreen', 'darkgreen', 'darkgreen', 
              'darkgreen', 'darkgreen', 'darkgreen', 'darkgreen', 'darkgreen', 
              'darkgreen', 'darkgreen', 'darkgreen', 
              'darkgreen', 'darkgreen')
# for fun, let's create a dataframe of the two vectors
countryColors <- cbind(data.frame(myCountries), data.frame(myColors))
# now we're going to set up a place to save the files to
mapFilesLocation <- '~/Desktop/'
# Loop through all of the countries
filename <- str_c(mapFilesLocation, 'map', ".png")
png(filename, width = 1024, height = 768)
map()
dev.off()

for (i in 1:length(myCountries)) {
  # set the location where the file will be saved
  filename <- str_c(mapFilesLocation, 'map', as.character(i), ".png")
  # open the png driver
  png(filename, width = 1024, height = 768)
  # set up a new plot
  map(database = 'world', regions = '.')
  # now we need to loop through all of the countries we'll plot in this round
  for (j in 1:i) {
    map(add = TRUE, regions = myCountries[j], fill = TRUE, col = myColors[j])
  }
  # save the file
  dev.off()
  # next incremental country
}
dev.off()
southAmerica <- c('ecuador', 'peru', 'chile', 'argentina', 'uruguay', 'paraguay', 
                  'bolivia', 'colombia', 'brazil', 'easter island', 'south georgia',
                  'venezuela', 'falkland islands', 'guyana', 'suriname', 'french guiana')
map(regions = southAmerica)
northAmerica <- c('usa', 'canada', 'mexico')
map(regions = northAmerica)
