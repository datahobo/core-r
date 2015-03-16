# Lesson 5: working with data and functions
## two steps:
### add an R object to the UI
### Tell shiny how to build the object in server.R

# display the object in ui.R
## build the object in server.R

# reference input objects in your output script to make Shiny reactive

# file paths work differently in shiny
## all file paths begin in the same directory as server.R

# shiny runs some sections of server.R more often than others
# code outside of shinyServer is run when you call "runApp"
# code inside of shinyServer is run each time a new user visits your app
# output code is run each time a user changes a widget that output relies on

# source scripts, libraries, and data sets at the beginning of server.R
## define user-specific objects inside the unnamed function, but outside of render* calls
### only place code that shiny must rerun to build an object inside of a render* function

## the whole script is run when you call "runApp"
## shinyServer is executed, gives shiny the unnamed function in it's first argument
## shiny saves the unamed function until a new user arrives. each time a new user
## visits your app, shiny runs the unnamed function again, one time. the function
## helps shiny build a distinct set of reactive objects for each user.

## as users change widgets, shiny will re-run the R expressions assigned to each
## reactive object. If your user is very active, these expressions may be re-run 
## many, many times a second.
