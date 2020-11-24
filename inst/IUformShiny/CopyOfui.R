##############################################################
# Prewritten required codeblock1
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
# End of prewritten codeblock1
##############################################################
