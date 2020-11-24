# creating a vector of mandatory fields
!1

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
!A

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

# the server code

server = function(input, output, session) {
  observe({
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })

  #getting the input from each of the fields by using sapply loop, also getting the the time
  #and transposing the matrix (data to get one obs=one user entry)

  formData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- c(data, timestamp = epochTime())
    data <- t(data)
    data
  })

  #save the data to CSV file
  saveData <- function(data) {
    fileName <- sprintf("%s_%s.csv",
                        humanTime(),
                        digest::digest(data))

    write.csv(x = data, file = file.path(responsesDir, fileName),
              row.names = FALSE, quote = TRUE)
  }

  # action to take when submit button is pressed
  observeEvent(input$submit, {
    saveData(formData())
  })

# action to take when submit button is pressed
  observeEvent(input$submit, {
    shinyjs::disable("submit")
    shinyjs::show("submit_msg")
    shinyjs::hide("error")

    tryCatch({
      saveData(formData())
      shinyjs::reset("form")
      shinyjs::hide("form")
      shinyjs::show("thankyou_msg")
    },
    error = function(err) {
      shinyjs::html("error_msg", err$message)
      shinyjs::show(id = "error", anim = TRUE, animType = "fade")
    },
    finally = {
      shinyjs::enable("submit")
      shinyjs::hide("submit_msg")
    })
  })

# observer to the click new form button
  observeEvent(input$submit_another, {
    shinyjs::show("form")
    shinyjs::hide("thankyou_msg")
  })

#loading the table that we want to display in UI in the server side
  output$responsesTable <- DT::renderDataTable(
    loadData(),
    rownames = FALSE,
    options = list(searching = FALSE, lengthChange = FALSE)
  )

#to enable the download button to download the data
  output$downloadBtn <- downloadHandler(
    filename = function() {
      sprintf("IUform_%s.csv", humanTime())
    },
    content = function(file) {
      write.csv(loadData(), file, row.names = FALSE)
    }
  )
}
