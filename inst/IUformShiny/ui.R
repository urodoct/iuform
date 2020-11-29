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

Ocean <- "
@import url('https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,900&display=swap');
body{
font-family: 'Lato', sans-serif;
margin: auto;
background: linear-gradient(0deg, rgba(1,19,97,0.7) 0%, rgba(3,208,202,0.4) 68%);
color: white;
}

#submit, #downloadBtn{
color:white;
background-color: rgb(16,122,162);

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
  background-color: rgba(255,255,255,.9);
  border: solid 1.3px #ccc;
  border-radius: 17px;
  min-width: 200px;
  filter: blur(0.0001px);
  margin-top:0px;
  color: black;
  border-top-left-radius: 0px;
  border-top-right-radius: 0px;
}

fieldset{
margin:5px auto;
background-color: rgb(16,122,162);
width: 50%;
text-align: center;
font-weight:bold;
color: white;
font-size: 1.99em;
border: solid 1.3px 1.3px 0px 1.3px #ccc;
border-top-left-radius: 17px;
border-top-right-radius: 17px;
margin-bottom:0;
}

#responsesTable{
margin:0 auto;
margin-top:1.5em;
margin-bottom:1.5em;
color:black;
background-color: rgba(82, 30, 0, 0.1);

}

"
Maroon <- "
@import url('https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,900&display=swap');
body{
font-family: 'Lato', sans-serif;
margin: auto;
color: white;
background-color: #f6f0c4;
background-image: linear-gradient(315deg, #f6f0c4 0%, #d99ec9 74%);
}

#submit, #downloadBtn{
color:white;
background-color: rgb(128,0,0);

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
  background-color: rgba(255,255,255,.9);
  border: solid 1.3px #ccc;
  border-radius: 17px;
  min-width: 200px;
  filter: blur(0.0001px);
  margin-top:0px;
  color: black;
  border-top-left-radius: 0px;
  border-top-right-radius: 0px;
}

fieldset{
margin:5px auto;
background-color: rgb(128,0,0);
width: 50%;
text-align: center;
font-weight:bold;
color: white;
font-size: 1.99em;
border: solid 1.3px 1.3px 0px 1.3px #ccc;
border-top-left-radius: 17px;
border-top-right-radius: 17px;
margin-bottom:0;
}

#responsesTable{
margin:0 auto;
margin-top:1.5em;
margin-bottom:1.5em;
color:black;
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
