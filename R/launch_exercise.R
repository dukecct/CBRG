#' Launch .Rmd files for exercises
#'
#' @description This function launches the named exercise .Rmd file
#'
#' @param project Integer indicating the relevant exercise number.
#' @param show_answers Logical (default == FALSE). If this parameter is set to TRUE, answers will be shown in the .Rmd file.
#' @param testing Logical (default == FALSE). Appropriate path is selected depending on what environment the package is runing in. USERS CAN IGNORE.
#'
#' @export
#'
#' @return Opens the corresponding .Rmd file in RStudio (with or without answers).
#' @author Akshay Bareja, Pol Castellano-Escuder
#'
#' @examples
#' # Exercise Number 1
#' launch_exercise(exercise = 1)
#'
#' # Exercise Number 1 with Answers
#' launch_exercise(exercise = 1, show_answers = TRUE)
launch_exercise <- function(exercise = 1, show_answers = FALSE, testing = FALSE){

  package_path <- find.package("CBRG")

  if(testing){
    exercise_path <- "/inst/exercises/"
  } else {
    exercise_path <- "/exercises/"
  }

  if(show_answers) {
    if(exercise <= 9){
    file <- paste0("0", exercise, "_ex_answers.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, exercise_path, file))
    } else {
      file <- paste0(exercise, "_ex_answers.Rmd")
      rstudioapi::navigateToFile(paste0(package_path, exercise_path, file))
    }
  } else {
    if(exercise <= 9){
    file <- paste0("0", exercise, "_ex.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, exercise_path, file))
    } else{
      file <- paste0(exercise, "_ex.Rmd")
      rstudioapi::navigateToFile(paste0(package_path, exercise_path, file))
    }
  }

}

