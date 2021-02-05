if (!require(easypackages)) { install.packages("easypackages")}

library(easypackages)

easypackages::packages(
  "dplyr",
  "emo",
  "ggplot2",
  "mitchelloharawild/icon",
  "kableExtra",
  "knitr",
  "maptools",
  "osmdata",
  "OpenStreetMap",
  "raster",
  "reticulate",
  "sf",
  "spatstat",
  "tibble",
  "tmap",
  "tmaptools",
  "gadenbuie/tweetrmd",
  "gadenbuie/xaringanExtra"
)
