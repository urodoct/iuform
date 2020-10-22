#' Creates a Shiny Form 1st template
#'
#' @param x The name of the form
#'
#' @return
#'
#'
#' @examples
#' create_form("my form")
library(shiny)
create_iuform <- function(path, ...) {
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # generate header for file
  header <- c(
    "# This file was generated IUform Package",
    "# The following inputs were received:",
    ""
  )

  # collect inputs and paste together as 'Parameter: Value'
  dots <- list(...)
  text <- lapply(seq_along(dots), function(i) {
    key <- names(dots)[[i]]
    val <- dots[[i]]
    paste0(key, ": ", val)
  })

  # collect into single text string
  contents <- paste(
    paste(header, collapse = "\n"),
    paste(text, collapse = "\n"),
    sep = "\n"
  )
# Generatign ui.R
uifile <- shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

#generative server.R

serverfile <- shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})



  # write to index file
  writeLines(serverfile, con = file.path(path, "server"))
  writeLines(uifile, con = file.path(path, "ui"))
}
