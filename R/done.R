#' @title clean up the code of the form deletes chars
#' @export
done <- function(){

  rody <- readr::read_file(glue::glue("./sat1.R"))
  rody1 <- stringr::str_replace_all(rody, pattern= "!E",
                                replacement = "")

  rody2 <- stringr::str_replace_all(rody1, pattern= "!S",
                                replacement = "")
  # readr::write_file(rody2, glue::glue("./sat1.R"), append = F)

  # read bobo
  bobo <- readr::read_file(glue::glue("./bobo.R"))



  ######################################## for !1 line
  # look for stars
  numb_stars <- freq_word(bobo, "\\*")

  #Extract the required elements
  manmat_elements<-   (stringr::str_extract_all(bobo, "\\*\\w{1,}"))

  ## writing the vector
  manvect_elements <- glue::glue(
    "fieldsMandatory <- ",
    "{manmat_elements[1]}", sep=",")

  # for one
  oneman_elements <- glue::glue(
    "fieldsMandatory <- ",
    "'{manmat_elements[1]}'",sep="")

  if(numb_stars==1){mody <- stringr::str_replace_all(rody2, pattern= "!1",
                                                    replacement = glue::glue ("{oneman_elements}", "\n\n") )
  readr::write_file(mody, glue::glue("./sat1.R"), append = F)}

else {if (numb_stars>1){mody <- stringr::str_replace_all(rody2, pattern= "!1",
                                         replacement = glue::glue ("{manvect_elements}", "\n\n") )
                  readr::write_file(mody, glue::glue("./sat1.R"), append = F)}

  else
{   mody <-  stringr::str_replace_all(rody2, pattern= "!1",
                             replacement = "" )
    readr::write_file(mody, glue::glue("./sat1.R"), append = F)}}

  ######################################## for !A line
  #Extract all elements names
  allmat_elements<-   (stringr::str_extract_all(bobo, "\\w+"))

  #for !A later on it is early to place here but whatever
  all_elements <- glue::glue(
    "fieldsAll <- ",
    "{allmat_elements[1]}", sep=",")

  {allaz <- stringr::str_replace_all(mody, pattern= "!A",
                                     replacement = glue::glue ("{all_elements}", "\n\n") )
    readr::write_file(allaz, glue::glue("./sat1.R"), append = F)}


}



