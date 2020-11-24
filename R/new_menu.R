#' form element
#'
#' @param label this is the tag of the form element
#' @param name the element name MUST be within quotes if more than one word
#' @param must_fill tags mandatory field
#' @param section the section where the element will be placed
#'
#'
#' @export
new_menu <- function(label,name, must_fill=F, section){

  #quoting the user arguments using enquo

  enlabel <- rlang::enquo(label)
  enname <- rlang::enquo(name)
  ensection <- rlang::enquo(section)
  #quting them again using paste and que_name
  label <- paste(rlang::quo_name(enlabel))
  name <- paste(rlang::quo_name(enname))
  section <- paste(rlang::quo_name(ensection))
  element_name <- name
  section_name <-section
  ##### END of quoting/unquoting

  blanky <-  glue::glue("!{label}")
  blanky2 <-glue::glue(
    "labelMandatory('",
    "{element_name}",
    "'),"

  )
  #writing the form element code
  part1 <- glue::glue("  selectInput('{label}','{element_name}', {if(must_fill)return ('{blanky2}')else return ('')} {blanky}),",)
  contents <- paste0(part1, "\n")
  #################################################################
  #Reading what is happening in ui.R [file]
  rody <- readr::read_file(glue::glue("./ui.R"))

  ###################################################################
  #see if the section is in the code
  #count if the word is there
  section_TF <- freq_word(rody, section )

  # test for the count =1, then add it
  #un-comment this at some point
  if (section_TF>0)
  {
    # replace the i{d = section name} by{itself, "element code"}******
    patty <- glue::glue("!E{section}")

    rody1 <- stringr::str_replace(rody,
                                      pattern= patty,
                                      replacement = glue::glue({contents},patty))
    # readr::write_file(rody1, glue::glue("./ui.R"), append = F)
  }


  # else just add the form element to the !E place holder

  else {
    rody1 <- stringr::str_replace(rody, pattern= "!E", replacement = glue::glue(contents,"!E"))

  }

  # writing the updated file
  readr::write_file(rody1, glue::glue("./ui.R"), append = F)
  #bobo file to save all labels
  element_name <- glue::glue("\n\n" ,' {if(must_fill)return ({glue::glue("*{label}")}) else (glue::glue("^{label}\n"))}', "\n\n" )
  readr::write_file(element_name, glue::glue("./bobo.R"), append = T)
}



