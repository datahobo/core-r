# Server file
### The object will be reactive if the code that builds it calls a widget value ----

# Output function       creates
# htmlOutput            raw HTML
# imageOutput	          image
# plotOutput	          plot
# tableOutput	          table
# textOutput	          text
# uiOutput	            raw HTML
# verbatimTextOutput	  text

## all file paths begin in the same directory as server.R
# server.R -----
source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)

shinyServer(
  function(input, output) {
    output$map <- renderPlot({

      args <- switch(input$var, 
                     "Percent White" = list(counties$white, "darkgreen", "% White"),
                     "Percent Black" = list(counties$black, "black", "% Black"),
                     "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
                     "Percent Asian" = list(counties$asian, "darkviolet", "% Asian"))
      
      args$min <- input$range[1]
      args$max <- input$range[2]
      do.call(percent_map, args)
    })
  }
)