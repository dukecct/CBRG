#' Launch Rmd files for in-class activities
#'
#' This function launches the named class Rmd file
#'
#' @param class enter the relevant class number (as an int). Opens the corresponding Rmd file in RStudio.
#' @param show_answers enter TRUE or FALSE (default is FALSE). Opens the corresponding Rmd file WITH ANSWERS in RStudio.
#' @param testing enter TRUE or FALSE (default is FALSE). Appropriate path is selected depending on what environment the package is run in. USERS CAN IGNORE.
#' @author Akshay Bareja
#' @example
#' launch_class(class = 1)
#'
#' @export

launch_class <- function(class = 1, show_answers = FALSE, testing = FALSE){

  package_path <- find.package("CBRG")

  if(testing){
    class_path <- "/inst/class/"
  } else {
    class_path <- "/class/"
  }

  if(show_answers) {

    file <- paste0("0", class, "_class_answers.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, class_path, file))

    } else {

    file <- paste0("0", class, "_class.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, class_path, file))
    }
}

