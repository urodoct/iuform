#' delete the last char from some thing after counting its length
#'
#' @param code this is code you want to trim its last char
#'
#'
#'
del_end <- function(code){
  #first count the total number of chars including whitespace

  widthy <-  stringr::str_count(code, pattern = ".|[:space:]")

  #turncate the last char
  stringr::str_trunc(code, widthy-1,
                     ellipsis = "")

}
