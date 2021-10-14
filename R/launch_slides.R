#' Launch Presentations
#'
#' This function launches the named presentation
#'
#' @param class enter the relevant class number (as an int)
#' @return launches the corresponding html file in a browser
#' @param testing enter TRUE or FALSE (default is FALSE)
#' @return appropriate path is selected depending on what environment the package is run in. USERS CAN IGNORE
#' @author Akshay Bareja
#' @example
#' launch_slides(class = 1)
#'
#' @export


launch_slides <- function(class = 1, testing = FALSE){
  package_path <- find.package("CBRG")
  slides <- c("01_slides.html", "02_slides.html", "03_slides.html", "04_slides.html", "05_slides.html")

  if(testing == TRUE){
    file <- slides[class]
    rstudioapi::viewer(paste0(package_path, "/inst/slides/", file))
  } else {
    file <- slides[class]
    rstudioapi::viewer(paste0(package_path, "/slides/", file))
  }
}
