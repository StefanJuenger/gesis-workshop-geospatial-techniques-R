cologne <- 
  glue::glue("
           https://geoportal.stadt-koeln.de/arcgis/rest/services/\\
           Stadtgliederung_15/MapServer/1/query?where=objectid+is+not+null&\\
           text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&\\
           inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields\\
           =*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&\\
           geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=\\
           false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&\\
           returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&\\
           resultOffset=&resultRecordCount=&f=pjson
           ") %>% 
  sf::st_read() %>% 
  sf::st_transform(3035) %>% 
  tibble::as_tibble() %>% 
  sf::st_as_sf() %>% 
  sf::st_buffer(0)

sf::write_sf(cologne, "./data/cologne.shp")
