#' Launch Rmd files for homework
#'
#' This function launches the named class Rmd file
#'
#' @param class enter the relevant class number (as an int). Opens the corresponding Rmd file in RStudio.
#' @param show_answers enter TRUE or FALSE (default is FALSE). Opens the corresponding Rmd file WITH ANSWERS in RStudio.
#' @param testing enter TRUE or FALSE (default is FALSE). Appropriate path is selected depending on what environment the package is run in. USERS CAN IGNORE.
#' @author Akshay Bareja
#' @author Pol Castellano
#' @example
#' launch_exercise(class = 1)
#'
#' @export

launch_exercise <- function(class = 1, show_answers = FALSE, testing = FALSE){

  package_path <- find.package("CBRG")

  if(testing){
    homework_path <- "/inst/exercises/"
  } else {
    homework_path <- "/exercises/"
  }

  if(show_answers) {

    file <- paste0("0", class, "_ex_answers.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, homework_path, file))

  } else {

    file <- paste0("0", class, "_ex.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, homework_path, file))
  }

}

