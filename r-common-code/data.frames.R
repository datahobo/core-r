# This function turns all NAs in a column to zeros 
na.zero <- function (x) {
    x[is.na(x)] <- 0
    return(x)
}

# This function is from : http://www.r-bloggers.com/generating-a-laglead-variables/
shift<-function(x,shift_by){
  # shift_by is the lead/lag increment
  ## positive for leading indicator
  ## negative for lagging indicator
  stopifnot(is.numeric(shift_by))
  stopifnot(is.numeric(x))
  
  if (length(shift_by)>1)
    return(sapply(shift_by,shift, x=x))
  
  out<-NULL
  abs_shift_by=abs(shift_by)
  if (shift_by > 0 )
    out<-c(tail(x,-abs_shift_by),rep(NA,abs_shift_by))
  else if (shift_by < 0 )
    out<-c(rep(NA,abs_shift_by), head(x,-abs_shift_by))
  else
    out<-x
  out
}

# I wrote this function for another project
AddSummaryVariableToDataFrame <- function(d.data.frame, grouping.variable.as.string, 
                              summarized.variable.as.string, summary.function) {
  # get column refences for the key variables
  grouping.variable <- as.numeric(which(colnames(d.data.frame) == grouping.variable.as.string))
  summarized.variable <- as.numeric(which(colnames(d.data.frame) == summarized.variable.as.string))
  # now use tapply to get a temporary data frame with the variable summarized by the grouping variable
  temp <- data.frame(tapply(d.data.frame[[summarized.variable]], 
                            d.data.frame[[grouping.variable]], summary.function))
  temp[[2]] <- row.names(temp)
  names(temp) <- c(paste(summary.function, summarized.variable.as.string, sep = "."),
                   grouping.variable.as.string)
  d.data.frame <- merge(d.data.frame, temp)
  return(d.data.frame)
}
