#' Starting a new IUform Shiny aplication
#'
#' @param file this is the file
#' @param pattern gives pattern
#' @param replace gives replacement
#'
replace_word <- function(file, pattern, replace) {
  suppressWarnings(tx <- readLines(file))
  tx2 <- gsub(pattern = pattern, replacement = replace, x = tx)
  writeLines(tx2, con = file)
}
