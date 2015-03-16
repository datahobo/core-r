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

# Laying out some widgets ----
shinyUI(fluidPage(
  titlePanel("censusVis"),

  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
        information from the 2010 US Census."),
      selectInput(inputId = "var",
                  label = "Choose a variable to display",
                  choices = list("Percent White", "Percent Black",
                                 "Percent Hispanic", "Percent Asian"), 
                           selected = "Percent White"),
               sliderInput(inputId = "range",
                           label = "Range of interest",
                           min = 0, 
                           max = 100, 
                           value = c(0,100)
                           )
      ),
    mainPanel(
      )
  )
))