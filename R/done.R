#' @title clean up the code of the form deletes chars
#' @export
done <- function(){

  rody <- readr::read_file(glue::glue("./ui.R"))



  # read bobo
  bobo <- readr::read_file(glue::glue("./bobo.R"))



  ######################################## Replacing the place holder !1 with mandotory filds
  # look for stars
  numb_stars <- freq_word(bobo, "\\*")
  numb_expo <- freq_word(bobo, "\\^")

  #Extract the required elements
  manmat_elements<-   (stringr::str_extract_all(bobo, "\\*\\w{1,}"))
  ## corecing line
  # manmat_elements<- stringr::str_replace_all(manmat_elements[1], pattern= "\\*",
  #                                 replacement = "")
  # making dots a vector of length 1 to make the replacement work
  dots <-  unlist(sapply(manmat_elements[1], paste))
  manmat_Reduced <- Reduce("paste", dots)
  # Separating items with a comma
  manmat_elements<- stringr::str_replace_all(manmat_Reduced, pattern= "\\s",
                                  replacement = "\\'\\,\\'")
  manmat_elements<- stringr::str_replace_all(manmat_elements, pattern= "\\*",
                                             replacement = "")
  ## writing the vector
  manvect_elements <- glue::glue(
    "fieldsMandatory <- c(","'",
    "{manmat_elements}","')")
  manvect_elementsN <- glue::glue(
    "fieldsMandatory <-","'sumbit'")
  # # for one
  # oneman_elements <- glue::glue(
  #   "fieldsMandatory <- ",
  #   "'{manmat_elements}'")

  # if(numb_stars==1){
  #   mody <- stringr::str_replace_all(rody, pattern= "!1",
  #                                                   replacement = glue::glue ("{oneman_elements}", "\n\n") )
  # readr::write_file(mody, glue::glue("./ui.R"), append = F)
  # }

if (numb_stars>0){
  mody <- stringr::str_replace_all(
            rody, pattern= "!1",
            replacement = glue::glue ("{manvect_elements}", "\n\n") )
  readr::write_file(mody, glue::glue("./ui.R"), append = F)
    }

  else{

    mody <-  stringr::str_replace_all(rody, pattern= "!1",
                             replacement = glue::glue ("{manvect_elementsN}", "\n\n"))
    readr::write_file(mody, glue::glue("./ui.R"), append = F)

    }

  ######################################## Replacing the place holder !A line with all fields
  #Extract all elements names
  manmat_elements2<-   (stringr::str_extract_all(bobo, "\\^\\w{1,}"))
  dots2 <-  unlist(sapply(manmat_elements2[1], paste))
  manmat_Reduced2 <- Reduce("paste", dots2)
  manmat_elements2<- stringr::str_replace_all(manmat_Reduced2, pattern= "\\s",
                                              replacement = "\\'\\,\\'")
  manmat_elements2<- stringr::str_replace_all(manmat_elements2, pattern= "\\^",
                                              replacement = "")
  all_elements <- glue::glue(
    "fieldsAll <- c(","'",
    "{manmat_elements2}","'",",","'{manmat_elements}","')")
  all_elements1 <- glue::glue(
    "fieldsAll <- c(","'",
    "{manmat_elements2}","'",")")
  all_elements2 <- glue::glue(
    "fieldsAll <- c(","'",
    "{manmat_elements}","'",")")
  all_elements0 <- glue::glue(
    "fieldsAll <- c(","'","')")

  if (numb_expo>0 & numb_stars>0){
  allaz <- stringr::str_replace_all(mody, pattern= "!A",
                                     replacement = glue::glue ("{all_elements}", "\n\n") )}

  else if (numb_expo>0 & numb_stars<1) {
    allaz <-  stringr::str_replace_all(mody, pattern= "!A",
                                      replacement = glue::glue ("{all_elements1}", "\n\n"))
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  else if (numb_expo<1 & numb_stars>0) {
    allaz <-  stringr::str_replace_all(mody, pattern= "!A",
                                       replacement = glue::glue ("{all_elements2}", "\n\n"))
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }
  else  {
    allaz <-  stringr::str_replace_all(mody, pattern= "!A",
                                       replacement = glue::glue ("{all_elements0}", "\n\n"))
    readr::write_file(allaz, glue::glue("./ui.R"), append = F)

  }

  ########################################################################
  rody1 <- stringr::str_replace_all(allaz, pattern= "\\!\\w{1,}\\,?",
                                      replacement = "")
    rody11 <- stringr::str_replace_all(rody1, pattern= "\\!.",
                                       replacement = "")

    rody2 <- stringr::str_replace_all(rody11, pattern= "!S",
                                      replacement = "")

    readr::write_file(rody2, glue::glue("./ui.R"), append = F)

  ###############################################################################
  ### Start of writing into the server.R file
  #read the server.R file
  serverFile <- readr::read_file(glue::glue("./server.R"))

  #replacing the !1 place holder with mandotory files
  serverMan <- stringr::str_replace_all(
    serverFile, pattern= "!1",
    replacement = glue::glue ("{manvect_elements}", "\n") )

  #writing the fieldsmanadotory to the file
  if (numb_stars>0){
  readr::write_file(serverMan, glue::glue("./server.R"), append = F)}
  else{
    serverMan <- stringr::str_replace_all(
      serverFile, pattern= "!1",
      replacement =glue::glue ("{manvect_elementsN}", "\n") )
    readr::write_file(serverMan, glue::glue("./server.R"), append = F)}
  ################################################################################
  #replacing the !A place holder with all files
  serverFinal <- stringr::str_replace_all(
    serverMan, pattern= "!A",
    replacement = glue::glue ("{all_elements}", "\n") )
  #writing the fieldsAll to the server.R file
  if (numb_expo>0 & numb_stars>0 ){
  readr::write_file(serverFinal, glue::glue("./server.R"), append = F)}
  else if (numb_expo>0 & numb_stars<1){
    serverFinal <- stringr::str_replace_all(
      serverMan, pattern= "!A",
      replacement =glue::glue ("{all_elements1}", "\n") )
    readr::write_file(serverFinal, glue::glue("./server.R"), append = F)
  }
  else if (numb_expo<1 & numb_stars>0){
    serverFinal <- stringr::str_replace_all(
      serverMan, pattern= "!A",
      replacement =glue::glue ("{all_elements2}", "\n") )
    readr::write_file(serverFinal, glue::glue("./server.R"), append = F)
  }
  else {
    serverFinal <- stringr::str_replace_all(
      serverMan, pattern= "!A",
      replacement =glue::glue(
        "fieldsAll <- c(","'downloadBtn","'",")") )
    readr::write_file(serverFinal, glue::glue("./server.R"), append = F)
  }
##############################################################################
## End of server file update




}



