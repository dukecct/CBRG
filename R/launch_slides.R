#' Launch Presentations
#'
#' This function launches the named presentation
#'
#' @param class enter the relevant class number (as an int). Launches the corresponding html file in a browser.
#' @param testing enter TRUE or FALSE (default is FALSE). Appropriate path is selected depending on what environment the package is run in. USERS CAN IGNORE.
#' @author Akshay Bareja
#' @author Pol Castellano
#' @example
#' launch_slides(class = 1)
#'
#' @export

launch_slides <- function(class = 1, testing = FALSE){

  package_path <- find.package("CBRG")
  file <- paste0("0", class, "_slides.html")

  if(testing){
    slides_path <- "/inst/slides/"
  } else {
    slides_path <- "/slides/"
  }

  rstudioapi::viewer(paste0(package_path, slides_path, file))

}

