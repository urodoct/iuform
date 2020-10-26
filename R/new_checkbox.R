#' form element
#'
#' @param label this is the ta of the form element
#' @param must_fill tags mandatory field
#' @param section the section where the element will be placed
#'
#'
#' @export
new_checkbox <- function(label, must_fill=F, section){

  element_name <- as.factor(label)
  section_name <- as.factor(section)
  blanky <- ""

  #writing the form element code
  part1 <- glue::glue("  checkboxInput('{element_name}', {if(must_fill)return ('labelMandatory') else return ('')}('{element_name}'), '{blanky}'),",)
  contents <- paste0(part1, "\n")
  #################################################################
  #Reading what is happening in ui.R [file]
  rody <- readr::read_file(glue::glue("./sat1.R"))

  ###################################################################
  #see if the section is in the code
  #count if the word is there
  section_TF <- freq_word(rody, section )

  # test for the count =1, then add it
  #un-comment this at some point
  if (section_TF>0)
  {
    # replace the i{d = section name} by{itself, "element code"}******
    patty <- glue::glue("id = ",'"{section}"', ",")

    rody1 <- stringr::str_replace_all(rody,
                                      pattern= patty,
                                      replacement = glue::glue(patty,{contents}))
    # readr::write_file(rody1, glue::glue("./sat1.R"), append = F)
  }


  # else just add the form element to the !E place holder

  else {
    rody1 <- stringr::str_replace(rody, pattern= "!E", replacement = glue::glue(contents,"!E"))

  }

  # writing the updated file
  readr::write_file(rody1, glue::glue("./sat1.R"), append = F)
  #bobo file to save all labels
  element_name <- glue::glue("\n\n" ,' {if(must_fill)return ({glue::glue("*{label}")}) else (glue::glue("^{label}\n"))}', "\n\n" )
  readr::write_file(element_name, glue::glue("./bobo.R"), append = T)
}



