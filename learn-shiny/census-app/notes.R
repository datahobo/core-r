# Lesson 4: Reactive output
## two steps:
### add an R object to the UI
### Tell shiny how to build the object in server.R
### The object will be reactive if the code that builds it calls a widget value

# Output function       creates
# htmlOutput	          raw HTML
# imageOutput	          image
# plotOutput	          plot
# tableOutput	          table
# textOutput	          text
# uiOutput	            raw HTML
# verbatimTextOutput	  text

# display the object in ui.R
## build the object in server.R
## use output$ with the object name

# render function     creates
# renderImage	        images (saved as a link to a source file)
# renderPlot	        plots
# renderPrint	        any printed output
# renderTable	        data frame, matrix, other table like structures
# renderText	        character strings
# renderUI	          a Shiny tag object or HTML

# reference input objects in your output script to make Shiny reactive

