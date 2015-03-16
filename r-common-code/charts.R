HistPercent <- function(x, b = 50, xl = c(1,100), ...) {
  H <- hist(x, plot = FALSE, breaks = b)
  H$density <- with(H, 100 * density* diff(breaks)[1])
  labs <- paste(round(H$density), "%", sep="")
  plot(H, freq = FALSE, labels = labs, xlim = xl, ylim=c(0, 1.08*max(H$density)),...)
}
