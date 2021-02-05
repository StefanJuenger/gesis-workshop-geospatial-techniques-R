#' Retrieve Raster Layer from the IOER Monitor
#' Download raster layer from the Monitor of Settlement and Open Space
#' Development (IOER Monitor) and load it in your R session.
#'
#' @param indicator_key character string; indicator key as defined here:
#' \url{https://www.ioer-monitor.de/en/indicators/}
#' @param size character string; combination of size and unit, e.g.,
#' \code{"500m"}. ATTENTION: sizes below 200m are currently not working :-(
#' @param year character string; reference year for the indicator. ATTENTION:
#' not all indicators are available for any year
#' @param tmp_folder character string; path where the downloaded and temporary
#' file should be stored to reload as raster layer
#'
#' @importFrom magrittr %>%
#' @importFrom reticulate %as%

download_ioer_layer <-
  function (
    indicator_key = "S08RG",
    size = "500m",
    year = "2019",
    tmp_folder = "."
  ) {

    # create interface to python
    py <- reticulate::import_builtins()

    # build web coverage service request
    indicator_wcs <-
      paste0("http://maps.ioer.de/cgi-bin/wcs?MAP=", indicator_key, "_wcs") %>%
      reticulate::import("owslib.wcs")$WebCoverageService(., version = '1.0.0')

    # retrieve layer name
    layer_name <-
      indicator_wcs$contents %>%
      names() %>%
      grep(year, ., value = TRUE) %>%
      grep(size, ., value = TRUE)

    # identify the actual layer to download, ...
    layer_to_download <-
      layer_name %>%
      indicator_wcs[.]

    # ...its resolution, ...
    layer_resolution <-
      layer_to_download %>%
      .$grid %>%
      .$highlimits %>%
      as.numeric()

    # ...its native coordinate reference system, ...
    layer_native_crs <-
      layer_to_download %>%
      .$boundingboxes %>%
      .[2] %>%
      .[[1]] %>%
      .$nativeSrs

    # ...and its bounding box
    layer_bounding_box <-
      layer_to_download %>%
      .$boundingboxes %>%
      .[2] %>%
      .[[1]] %>%
      .$bbox %>%
      unlist()

    # download layer
    downloaded_layer <-
      indicator_wcs$getCoverage(
        identifier = layer_name,
        bbox = layer_bounding_box,
        format = "GTiff",
        crs = layer_native_crs,
        width = layer_resolution[1],
        height = layer_resolution[2]
      )  %>%
      .$read %>%
      reticulate::py_call(.)

    # store tmp file
    with(py$open(
      paste0(tmp_folder, '/layer.tif'), "wb") %as% file, {
        file$write(downloaded_layer)
      }
    )

    # load tmp file as 'native' r raster file
    raster_layer <-
      raster::raster(paste0(tmp_folder, '/layer.tif'))

    raster_layer <- raster::readAll(raster_layer)

    # delete tmp file
    unlink(paste0(tmp_folder, '/layer.tif'))

    # return raster layer
    raster_layer
  }


