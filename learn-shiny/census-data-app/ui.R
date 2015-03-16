# ui.R
# widgets ----

# actionButton - simple button
# checkboxGroupInput - group of check boxes
# checkboxInput - single check box
# dateInput - calendar for date selection
# dateRangeInput - pair of calendars
# fileInput - file upload control wizard
# helpText - help text that can be added to an input form
# numericInput - field for numbers
# radioButtons - set of them
# selectInput - box with choices to select from
# sliderInput - slider bar
# submitButton - what it sounds like
# textInput - field for entering text
## all from the Twitter bootstrap project

# widgets require several arguments. All require:
## Name - used to access the value
## label - appears in the app
## other arguments are widget-dependent. Get help on the widget to list them:
# ?selectInput

## use output$ with the object name

# render function     creates
# renderImage          images (saved as a link to a source file)
# renderPlot	        plots
# renderPrint	        any printed output
# renderTable	        data frame, matrix, other table like structures
# renderText	        character strings
# renderUI	          a Shiny tag object or HTML

# ui.R ----

shinyUI(fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
        information from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    
    mainPanel(plotOutput("map"))
  )
))