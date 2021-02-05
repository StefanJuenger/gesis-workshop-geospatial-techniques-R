#' Rotate simple features for 3D layers
#' Rotates a simple features layer using a shear matrix transformation on the
#' \code{geometry} column. This can get nice for visualisation and works with
#' points, lines and polygons.
#'
#' @param data an object of class \code{sf}
#' @param x_add integer; x value to move geometry in space
#' @param y_add integer; x value to move geometry in space
#'
#' #' @importFrom magrittr %>%

rotate_sf <- function(data, x_add = 0, y_add = 0) {

  shear_matrix <- function (x) {
    matrix(c(2, 1.2, 0, 1), 2, 2)
  }

  rotate_matrix <- function(x) {
    matrix(c(cos(x), sin(x), -sin(x), cos(x)), 2, 2)
  }

  data %>%
    dplyr::mutate(
      geometry =
        .$geometry * shear_matrix() * rotate_matrix(pi / 20) + c(x_add, y_add)
    )
}
