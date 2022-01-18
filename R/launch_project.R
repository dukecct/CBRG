#' Launch .Rmd files for in-project activities
#'
#' @description This function launches the named project .Rmd file
#'
#' @param project Integer indicating the relevant project number.
#' @param show_answers Logical (default == FALSE). If this parameter is set to TRUE, answers will be shown in the .Rmd file.
#' @param testing Logical (default == FALSE). Appropriate path is selected depending on what environment the package is runing in. USERS CAN IGNORE.
#'
#' @export
#'
#' @return Opens the corresponding .Rmd file in RStudio (with or without answers).
#' @author Akshay Bareja, Pol Castellano-Escuder
#'
#' @examples
#' # Project Number 1
#' launch_project(project = 1)
#'
#' # Project Number 1 with Answers
#' launch_project(project = 1, show_answers = TRUE)
launch_project <- function(project = 1, show_answers = FALSE, testing = FALSE){

  package_path <- find.package("CBRG")

  if(testing){
    project_path <- "/inst/projects/"
  } else {
    project_path <- "/projects/"
  }

  if(show_answers) {
    if(project <= 9){
    file <- paste0("0", project, "_project_answers.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, project_path, file))
    } else {
    file <- paste0(project, "_project_answers.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, project_path, file))
    }
    } else {
      if(project <= 9){
    file <- paste0("0", project, "_project.Rmd")
    rstudioapi::navigateToFile(paste0(package_path, project_path, file))
      } else {
      file <- paste0(project, "_project.Rmd")
      rstudioapi::navigateToFile(paste0(package_path, project_path, file))
      }
    }
}

