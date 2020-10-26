#' to start the form, ensures only one form
#'
#' @param name the  title/name of the form
#' @param label this is the tag of the form first section of the form
#' @param chaptered if many section will be in the form
#'
#'
#' @export
new_form <- function(name, label, chaptered=FALSE){

  form_name <- as.factor(name)
  firstsection_name <- as.factor(label)
#######################################################
  #check if there is already a form name in bobo.R
  #read it
  bobo <- readr::read_file(glue::glue("./bobo.R"))
  form_exist <- freq_word(bobo, "@" )
  if(form_exist>0)(glue:: glue("\n\n\n",
            "ERROR!!\n\n",
            "Sorry but you can only do one form per project!\n\n",
            "Alternatevily, you can try to:\n",
            "1- Start a new_section() or\n",
            "2- Start new form:\n\n",
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
                      "  div(\n",
                      "id = ",'"{label}"', ",",
                      " !E",
                      " ),\n",
                      " {if (chaptered) return ('!S') else return ('')}",
                      # add here
                      "",
                      ")")


  contents <- paste0(part1)
  form_names <- glue::glue("\n\n" ,'@"{form_name}"\n','&"{label}"\n\n',"\n\n" )

  readr::write_file(contents, glue::glue("./sat1.R"), append = F)
  readr::write_file(form_names, glue::glue("./bobo.R"), append = T)}
}
