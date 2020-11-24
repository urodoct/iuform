#' to start the form, ensures only one form
#'
#' @param name the  title/name of the form
#' @param chaptered if many section will be in the form
#'
#'
#' @export
new_form <- function(name,chaptered=F){


  #quoting the user arguments using enquo

  # enlabel <- rlang::enquo(label)
  enname <- rlang::enquo(name)
  #quting them again using paste and que_name
  # label <- paste(rlang::quo_name(enlabel))
  name <- paste(rlang::quo_name(enname))
  form_name <- name
  # firstsection_name <-label
  ##### END of quoting/unquoting
#######################################################
  #check if there is already a form name in bobo.R
  #read it
  bobo <- readr::read_file(glue::glue("./bobo.R"))
  # @ is unique for new form
  form_exist <- freq_word(bobo, "@" )
  if(form_exist>0)(glue:: glue("\n\n\n",
            "ERROR!!\n\n",
            "Sorry but you can only do one form per project!\n\n",
            "Alternatevily, you can try to:\n",
            "1- Start a new_section() or\n",
            "2- Start new project:\n\n",
            "File => New Project => New directory => Start new IUform\n\n"))
else
{

  part1 <- glue::glue(# add here
                      "!1\n\n",
                      "!A\n\n",
                      "ui <- fluidPage(\n",
                      "  shinyjs::useShinyjs(),\n",
                      "  shinyjs::inlineCSS(appCSS),\n",
                      "  titlePanel('{form_name}'),\n\n",
                      ######Start of the main div
                      "  div(\n",
                      "id = ","'form'", ",",
                      " !E",",\n\n",
                      "  actionButton(","'submit'",",","'Submit'",",","class=", "'btn-primary')",",\n\n",
                      "  shinyjs::hidden(\n",
                      "  span(id =","'submit_msg'",",","'Submitting...')",",\n\n",
                      "  div(id=","'error'",",\n",
                      "  div(br(), tags$b(","'Error: ')",",","  span(id =","'error_msg'))\n",
                      "  )\n",
                      "  )\n",
                      " ),\n",
                      ##### End of the main div

                      #####Adding JAVASCRIPT CODE
                      "  shinyjs::hidden(\n",
                      "  div(\n",
                      "  id =","'thankyou_msg'",",\n\n",
                      "  h3(","'Thanks, your response was submitted successfully')",",\n\n",
                      "  actionLink(","'submit_another'",",","'Submit another response')\n",
                      "  )\n",
                      " ),\n",
                      ##### END of JAVASCRIPT CODE

                      ##### Adding place holder for the table of the data
                      "  DT::dataTableOutput(","'responsesTable'),\n\n",

                      ##### Download data place holder
                      "  downloadButton(","'downloadBtn'",",","'Download responses')\n\n",

                      #adding a section holder !S
                      " {if (chaptered) return ('!S') else return ('')}\n\n",
                      # add more here if needed
                      "",
                      ")")


  contents <- paste0(part1)
  form_names <- glue::glue("\n\n" ,'@"{form_name}"\n','&"form"\n\n',"\n\n" )

  readr::write_file(contents, glue::glue("./ui.R"), append = T)
  readr::write_file(form_names, glue::glue("./bobo.R"), append = T)}
}
