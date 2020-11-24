
# creating a vector of mandatory fields
fieldsMandatory <- c("name", "favourite_pkg")

# define the mandatory fileds with red asterisk
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}
#adding a red color
appCSS <- ".mandatory_star { color: red; }
#error { color: red; }"

# getting all the elements names
fieldsAll <- c("name", "favourite_pkg", "used_shiny", "r_num_years", "os_type")

#building responses directory
responsesDir <- file.path("responses")

#getting the submission time
epochTime <- function() {
  as.integer(Sys.time())
}

# human time function
humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")

# reading and joining all responses
loadData <- function() {
  files <- list.files(file.path(responsesDir), full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE)
  data <- dplyr::bind_rows(data)
  data
}
###############################################################################

# the ui code
ui = fluidPage(
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  titlePanel("My first IUform"),


# the form with its elements
  div(
    id = "form",

    textInput("name", labelMandatory("Name"), ""),
    textInput("favourite_pkg", labelMandatory("Favourite food")),
    checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
    sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
    selectInput("os_type", "Operating system used most frequently",
                c("",  "Windows", "Mac", "Linux")),
    actionButton("submit", "Submit", class = "btn-primary"),
    shinyjs::hidden(
      span(id = "submit_msg", "Submitting..."),
      div(id = "error",
          div(br(), tags$b("Error: "), span(id = "error_msg"))
      )
    )
  ),

#Thank you letter after submission ui side
  shinyjs::hidden(
    div(
      id = "thankyou_msg",
      h3("Thanks, your response was submitted successfully!"),
      actionLink("submit_another", "Submit another response")
    )
  ),

# Placeholder for the datatable
DT::dataTableOutput("responsesTable"),

# download the data
downloadButton("downloadBtn", "Download responses")
)
