# add_datum_to_crs <- function (raster_file) {
#   crsInfo <- slot(raster_file, "crs")
#   slot(crsInfo, "projargs") <- paste0(slot(crsInfo, "projargs"), " +datum=GRS80")
#   slot(raster_file, "crs") <- crsInfo
#   raster_file
# }


cologne_bbox <-
  osmdata::getbb("Köln", format_out = "sf_polygon") %>% 
  sf::st_transform(3035)

immigrants_cologne <-
  z11::z11_get_100m_attribute(STAATSANGE_KURZ_2) %>% 
  raster::crop(cologne_bbox)

germans_cologne <- 
  z11::z11_get_100m_attribute(STAATSANGE_KURZ_1) %>% 
  raster::crop(cologne_bbox)

# crs(immigrants_cologne) <- 3035
# 
# crs(immigrants_cologne) <- sf::st_crs(3035)$wkt
# 
# immigrants_cologne[is.na(immigrants_cologne)] <- -9
# 
# immigrants_cologne <- add_datum_to_crs(immigrants_cologne)


inhabitants_cologne <-
  z11::z11_get_100m_attribute(Einwohner) %>% 
  raster::crop(cologne_bbox)

# inhabitants_cologne[is.na(inhabitants_cologne)] <- -9
# 
# sp::proj4string(inhabitants_cologne) <- "+init=epsg:3035"

raster::writeRaster(
  immigrants_cologne, 
  "./data/immigrants_cologne.tiff",
  overwrite = TRUE
)

raster::writeRaster(
  germans_cologne, 
  "./data/germans_cologne.tiff",
  overwrite = TRUE
)

raster::writeRaster(
  inhabitants_cologne, 
  "./data/inhabitants_cologne.tiff",
  overwrite = TRUE
)
