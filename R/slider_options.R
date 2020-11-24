#' Menu Element options
#'
#' @param label this is the tag of the slider element that you want to add options to
#' @param ... defines the lower number, upper number, and default number of slider
#'
#'
#' @export
slider_options<- function(label,...){
  #################################################################
  #Reading what is happening in ui.R [file]
  rody <- readr::read_file(glue::glue("./ui.R"))

  ###################################################################

  #quoting the user arguments using enquo

  enlabel <- rlang::enquo(label)
  endots<-  list(lapply(rlang::enquos(...), rlang::quo_name))
  # dots <-  rlang::parse_exprs(paste(endots, sep = " "))
  dots <-  unlist(sapply(endots, paste))
  #quting them again using paste and que_name
  label <- paste(rlang::quo_name(enlabel))

  blanky <-  glue::glue("!{label}")
  # making dots a vector of length 1 to make the replacement work
  dotsReduced <- Reduce("paste", dots)
  # Separating items with a comma
  dots<- stringr::str_replace_all(dotsReduced, pattern= "\\s",
                                     replacement = "\\,")
  dotsglue <- glue::glue("{dots}")

  #see if the label is in the code
  #count if the word is there
  section_TF <-freq_word(rody, blanky )

  # test for the count =1, then add it
  #un-comment this at some point
  if (section_TF>0)
  {

    #writing the options
    rody1 <- stringr::str_replace(rody, pattern= blanky, replacement = glue::glue("{dotsglue}"))
    # writing the updated file
    readr::write_file(rody1, glue::glue("./ui.R"), append = F)
  }


  # else just add the menu options

  else {
    paste("ERROR: No such slider item with that label was found")

  }



}
