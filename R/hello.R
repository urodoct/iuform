#' iuform: Indiana University Form
#'
#'Developed at Indiana University- Masters in Biostatistics program to help create online data collection forms
#' @param x Please type your name
#'
#' @return the output from \code{\link{print}}
#' @export
#'
#' @examples
#' hello("Mo")
#' \dontrun{
#' hello("Indiana")
#' }
hello <- function(x) {
  print(paste0("Hello", x,"world!"))
}
