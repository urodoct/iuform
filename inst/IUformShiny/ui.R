##############################################################
# Prewritten required codeblock1
# define the mandatory fileds with red asterisk
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}
#Themes
#adding a red color
appCSS <- ".mandatory_star { color: red; }
#error { color: red; }"
#############################################
# Safari theme
Safari <- "
body{
background-color: rgba(7, 33, 8, 0.9);
filter: blur(0.0001px);
color: darkgoldenrod;
}

#submit, #downloadBtn{
color:yellow;
background-color: rgba(52, 130, 10, 0.3)

}

#submit{
margin-right:32%;
}

#submit::after{
background-color: rgba(82, 30, 10, 0.3);
color: rgba(82, 30, 10, 0.3);
}

#downloadBtn{
margin-bottom: 50px;
}

/* Here should go the main form styling passed to the main form id and/or to the section pid */
#form{

  padding: 2.5% 2.5% 2.5% 4.5%;
  width: 50%;
  margin: 0 auto;
  background-color: rgba(82, 30, 10, 0.3);
  border: solid 1.3px #ccc;
  border-radius: 17px;
  min-width: 200px;
  filter: blur(0.0001px);
}

fieldset{
margin:5px auto;
text-align: center;
font-weight:bold;
color: darkgoldenrod;
font-size: 1.99em;
}

#responsesTable{
margin:0 auto;
margin-top:1.5em;
margin-bottom:1.5em;
color:darkgoldenrod;
background-color: rgba(82, 30, 0, 0.1);

}

"
formCSS <- formCSS1


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
