#' Counts keywords in code
#'
#' @param code this is code you want to  search within
#' @param pattern this is the keywords you want to find
#'
#'
#'
freq_word <- function(code, pattern){

  loci <- stringr::str_locate_all(code, pattern)
  sapply(loci, length)/2
}
