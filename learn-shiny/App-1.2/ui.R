# ui.R

# Shiny HTML Support ----
## p  <p>	A paragraph of text
## h1	<h1>	A first level header
## h2	<h2>	A second level header
## h3	<h3>	A third level header
## h4	<h4>	A fourth level header
## h5	<h5>	A fifth level header
## h6	<h6>	A sixth level header
## a	<a>	A hyper link
## br	<br>	A line break (e.g. a blank line)
## div	<div>	A division of text with a uniform style
## span	<span>	An in-line division of text with a uniform style
## pre	<pre>	Text ‘as is’ in a fixed width font
## code	<code>	A formatted block of code
## img	<img>	An image
## strong	<strong>	Bold text
## em	<em>	Italicized text
## HTML	 	Directly passes a character string as HTML code

# titlePanel and sidebarLayout are the most popular elements
## sidebarLayout takes two arguments:
### sidebarPanel - function
### mainPanel - function
## by default the sidebar is on the left side
### sidebarLayout(position = "right" moves it to the right side)

# You can add content with HTML5 tags
h1("My Title")

# Laying out a UI ----
shinyUI(fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(
      h1("Installation"),
      p("Shiny is available on CRAN, so you can install it in the usual way 
        from your R console:"),
      code('install.packages("shiny")'),
      br(),
      br(),
      br(),
      br(),
      img(src="bigorb.png", height = 40, width = 40, align = "left"),
      span("shiny is a product of "),
      a("RStudio", href = "http://www.rstudio.com/")
      ),
    mainPanel(
      h1("Introducing Shiny"),
      p("Shiny is a new package from RStudio that makes it ", 
        em("incredibly easy"),
        (" to build interactive web applications with R.")),
      h2("Features"),
      p("* Build useful web applications with only a few lines of code - no
         JavaScript required."),
      p("* Shiny applications are automatically ")
    )
  )
))