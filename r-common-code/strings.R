FindOffendingCharacter <- function(x, maxStringLength = 256){  
  print(x)
  for (c in 1:maxStringLength) {
    offendingChar <- substr(x,c,c)
    #print(offendingChar) #uncomment if you want the indiv characters printed
    #the next character is the offending multibyte Character
  }    
}

# Examples
string_vector <- c("test", "Se\x96ora", "works fine")
lapply(string_vector, findOffendingCharacter)

FactorToNumeric <- function(f) as.numeric(levels(f))[as.integer(f)]
