#' @title sets the IUform theme
#' @param theme the theme you want to apply: Safari,
#' @export
theme <- function(theme){

  # Removing the quotes
  enlabel <- rlang::enquo(theme)
  theme <- paste(rlang::quo_name(enlabel))

  # # read bobo
  # bobo <- readr::read_file(glue::glue("./bobo.R"))
  #
  # #Extract the form Name
  # manmat_elements<-   (stringr::str_extract_all(bobo, "\\@\\w{1,}"))
  #
  # # making dots a vector of length 1 to make the replacement work
  # dots <-  unlist(sapply(manmat_elements[1], paste))
  # manmat_Reduced <- Reduce("paste", dots)
  # # Creating a form ID with #
  # formId<- stringr::str_replace_all(manmat_Reduced, pattern= "\\@",
  #                                            replacement = "\\#")
  #
  # # ## writing the vector
  # formId <- glue::glue("'{formId}'")
  #
  #
  # rody <- readr::read_file(glue::glue("./ui.R"))
  # rody <- stringr::str_replace_all(rody, pattern= "f112820id",
  #                                  replacement = "" )

  # readr::write_file(rody, glue::glue("./ui.R"), append = F)
  rody <- readr::read_file(glue::glue("./ui.R"))

  if (is.null(theme)){


    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)
    }
########################################################################
  else if (theme=="Safari") {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "Safari" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  else if (theme=="safari") {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "Safari" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
 ########################################################################

########################################################################
  else if (theme=="Maroon") {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "Maroon" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  else if (theme=="maroon") {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "Maroon" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  ########################################################################
  else if (theme=="Ocean") {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "Ocean" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  else if (theme=="ocean") {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "Ocean" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  ########################################################################
  else  {
    allaz <- stringr::str_replace_all(rody, pattern= "formCSS1",
                                      replacement = "" )
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }





}



