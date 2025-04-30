library(gfwr)
library(tmap)

## Esfuerzo de pesca

# se pueden hacer búsquedas para áreas predefinidas (EEZ, areas marinas protegidas MPA e RFMOs/Orops)

?get_raster()
# region_source = "EEZ
# region = um código!

# a gente busca o código pelo get_region_id()
get_region_id(region_name = "Peru",
              region_source = "EEZ")
#código 8432
peru <- 8432
# enero marzo de 2023.
peru_fisheff <- get_raster(spatial_resolution = 'LOW',
                           temporal_resolution = 'MONTHLY',
                           start_date = '2023-01-01',
                           end_date = '2023-04-01',
                           region = peru,
                           region_source = 'EEZ')
# 524 timeout
peru_fisheff
# Qué columnas tiene cada respuesta?
# coordenadas, time range, vessel ids, apparent fishing hours

# LOW = 0.1 grau, HIGH = 0.01 grau
peru_fisheff <- get_raster(spatial_resolution = 'HIGH',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2023-01-01',
                             end_date = '2023-04-01',
                             region = peru,
                             region_source = 'EEZ')

peru_fisheff # mucha más info


# explorar cada  argumento
#resolución

# time range va a mostrar apenas el año, mes o día de ocurrencia
peru_fisheff <- get_raster(spatial_resolution = 'LOW',
                           temporal_resolution = 'DAILY',
                           start_date = '2021-01-01',
                           end_date = '2021-10-01',
                           region = peru,
                           region_source = 'EEZ')
peru_fisheff

# agrupar resultados usando parametro group_by
# group_by = "VESSEL_ID" "GEARTYPE" and "FLAGANDGEARTYPE"
#todas las opciones van a devolver diferentes columnas

peru_fisheff <- get_raster(spatial_resolution = 'LOW',
                           temporal_resolution = 'MONTHLY',
                           start_date = '2021-01-01',
                           end_date = '2021-10-01',
                           group_by = "VESSEL_ID",
                           region = peru,
                           region_source = 'EEZ'
                           )
peru_fisheff
# vessel_ID da mucha más información!

# tambien se puede filtrar y seleccionar

ECU_en_PER <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',
                             group_by = "VESSEL_ID",
                             filter_by = "flag IN ('ECU')",
                             region = peru,
                             region_source = 'EEZ',
                             key = gfw_auth())
ECU_en_PER
table(ECU_en_PER$`Gear Type`)

# para filtrar localmente
library(dplyr)
peru_fisheff %>% filter(Flag == "ARG")



# hay otras opciones para obtener códigos de áreas marinas protegidas y OROPS/RFMOs
get_region_id(region_name = "Abrolhos", region_source = "MPA")



# área de interés
# shapefile -> .shp
# paquete sf
# shapefile de ejemplo:
?gfwr
data(test_shape)

library(tmap)
tmap_mode("view")
tm_basemap() +
tm_shape(test_shape) +
tm_borders()

test_shape

# un objeto sf
#sf::read_sf()


fishing_effort <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',
                             group_by = "FLAG",
                             region_source = 'USER_SHAPEFILE',
                             region = test_shape
                             )

fishing_effort
unique(fishing_effort$flag) # varias bandeiras

