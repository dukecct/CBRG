#' Launch Slides for each Project
#'
#' @description This function launches the named presentation
#'
#' @param project Integer indicating the relevant project number.
#' @param testing Logical (default == FALSE). Appropriate path is selected depending on what environment the package is runing in. USERS CAN IGNORE.
#'
#' @export
#'
#' @return Opens the corresponding .Rmd file in RStudio (with or without answers).
#' @author Akshay Bareja, Pol Castellano-Escuder
#'
#' @examples
#' # Slides Corresponding to the Project Number 1
#' launch_slides(project = 1)
launch_slides <- function(project = 1, testing = FALSE){

  package_path <- find.package("CBRG")
  if(project <= 9){
    file <- paste0("0", project, "_slides.html")
  } else {
    file <- paste0(project, "_slides.html")
  }
  if(testing){
    slides_path <- "/inst/slides/"
  } else {
    slides_path <- "/slides/"
  }

  rstudioapi::viewer(paste0(package_path, slides_path, file))

}

