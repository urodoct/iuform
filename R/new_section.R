#' form section
#'
#' @param label this is the tag of the section
#'
#'
#' @export
new_section <- function(label){




  #quoting the user arguments using enquo

  enlabel <- rlang::enquo(label)

  #quting them again using paste and que_name
  label <- paste(rlang::quo_name(enlabel))

  section_name <- label

  ##### END of quoting/unquoting

  part1 <- glue::glue("  \n\n,  div(\n",
                       "id = ",'"{label}"', ",",
                      " !E{label}",
                      "  )\n")
contents <- paste0(part1, "\n")
rody <- readr::read_file(glue::glue("./ui.R"))
##################################################################
# First section template or pattern looks like the following

patty <- glue::glue("div(","id = ",'"{label}"', ",", " !E{label}  )",",")

# Search if label is in the code

section_TF <- freq_word(rody, "!S" )

#if you find it then it must have !S section holder
if (section_TF>0)


{
  rody1 <- stringr::str_replace(rody, pattern= "!S",
                                replacement = glue::glue(contents,"!S"))}
# if not then just add it
else {
  # rody3 <- del_end(rody)
  rody3 <- readr::read_file(glue::glue("./ui.R"))
  rody1 <- glue::glue({del_end(rody3)},"\n",patty, ")")
  #####################
  section_name <- glue::glue("\n\n",'&"{label}"\n\n',"\n\n" )
  readr::write_file(section_name, glue::glue("./bobo.R"), append = T)
}


  readr::write_file(rody1, glue::glue("./ui.R"), append = F)

}
