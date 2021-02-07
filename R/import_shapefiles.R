# load all shapefiles Germany
german_districts <- st_read(dsn = "../../data",
                            layer = "GER_DISTRICTS",
                            quiet = T) %>% 
  rename(., district_id = id)

attributes_districts <-  read.csv("../../data/attributes_districts.csv", 
                                  header = T, fill = T, sep = ",") 

german_districts_enhanced <- 
  german_districts %>% 
  left_join(., attributes_districts, by = "district_id") %>% 
  st_transform(., crs = 3035)

german_states <- st_read(dsn = "../../data",
                         layer = "GER_STATES",
                         quiet = T) %>%
                  st_transform(.,3035) %>%  
                  rename(state_id = AGS,
                         population = EWZ) %>% 
                  filter(GF == 4) %>% 
                  dplyr::select(., state_id, population)

germany <- st_read(dsn = "../../data",
                   layer = "GER_COUNTRY",
                   quiet = T) %>%
            st_transform(.,3035)


hospitals <- read.csv("../../data/hospital_points.csv", 
                      header = T, fill = T, sep = ",") %>%
  st_as_sf(., coords = c("X", "Y"),
           crs = 3035)
