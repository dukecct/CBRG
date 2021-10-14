#' Launch Rmd files for in-class activities
#'
#' This function launches the named class Rmd file
#'
#' @param class enter the relevant class number (as an int)
#' @return opens the corresponding Rmd file in RStudio
#' @param show_answers enter TRUE or FALSE (default is FALSE)
#' @return opens the corresponding Rmd file WITH ANSWERS in RStudio
#' @param testing enter TRUE or FALSE (default is FALSE)
#' @return appropriate path is selected depending on what environment the package is run in. USERS CAN IGNORE
#' @author Akshay Bareja
#' @example
#' launch_class(class = 1)
#'
#' @export


launch_class <- function(class = 1, show_answers = FALSE, testing = FALSE){
  package_path <- find.package("CBRG")
  classes <- c("01_class.Rmd", "02_class.Rmd", "03_class.Rmd", "04_class.Rmd", "05_class.Rmd")
  answers <- c("01_class_answers.Rmd", "02_class_answers.Rmd", "03_class_answers.Rmd",
               "04_class_answers.Rmd", "05_class_answers.Rmd")

  if(testing == TRUE){
    if(show_answers == TRUE){
      file <- answers[class]
      rstudioapi::navigateToFile(paste0(package_path, "/inst/class/", file))
    } else {

      file <- classes[class]
      rstudioapi::navigateToFile(paste0(package_path, "/inst/class/", file))
    }
  } else {
    if(show_answers == TRUE){
      file <- answers[class]
      rstudioapi::navigateToFile(paste0(package_path, "/class/", file))
    } else {
      file <- classes[class]
      rstudioapi::navigateToFile(paste0(package_path, "/class/", file))
    }
  }
}
