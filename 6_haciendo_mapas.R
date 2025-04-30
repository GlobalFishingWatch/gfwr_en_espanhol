# Haciendo mapas con gfwr
# Hay una viñeta del paquete
# https://globalfishingwatch.github.io/gfwr/articles/making-maps.html

# Carga paquetes
library(dplyr)
library(tidyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(glue)
library(ggplot2)

# Crea un tema de ggplot2 para los mapas

map_theme <- ggplot2::theme_minimal() +
  ggplot2::theme(
    panel.border = element_blank(),
    legend.position = "bottom", legend.box = "vertical",
    legend.key.height = unit(3, "mm"),
    legend.key.width = unit(20, "mm"),
    legend.text = element_text(color = "#848b9b", size = 8),
    legend.title = element_text(face = "bold", color = "#363c4c", size = 8, hjust = 0.5),
    plot.title = element_text(face = "bold", color = "#363c4c", size = 10),
    plot.subtitle = element_text(color = "#363c4c", size = 10),
    axis.title = element_blank(),
    axis.text = element_text(color = "#848b9b", size = 6)
  )

# Paleta para la actividad pesquera
map_effort_light <- c("#ffffff", "#eeff00", "#3b9088","#0c276c")


start_date <- '2021-01-01'
end_date <- '2021-04-01'

# La EEZ de Peru es 8432
get_region_id(region_name = "Peru", region_source = "EEZ")


peru_fisheff <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'MONTHLY',
                             start_date = '2021-01-01',
                             end_date = '2021-10-01',

                             region_source = "EEZ",
                             region = 8432)
#(sin agrupar pero se puede agrupar para hacer otros mapas)

peru_fisheff %>%
  filter(`Apparent Fishing Hours` > 0) %>%
  ggplot() +
  geom_tile(aes(x = Lon,
                  y = Lat,
                  fill = `Apparent Fishing Hours`)) +
  geom_sf(data = ne_countries(returnclass = "sf", scale = "medium")) +
  coord_sf(xlim = c(-90, -70),
           ylim = c(-20, -0)) +
  scale_fill_gradientn(
    trans = 'log10',
    colors = map_effort_light,
    na.value = NA,
    labels = scales::comma) +
  labs(title = "Esfuerzo pesquero aparente en la ZEE de Perú",
       subtitle = glue("{start_date} a {end_date}"),
       fill = "Fishing hours") +
  map_theme



# un ejemplo en otra región, com un shapefile proprio

# mi_shape <- sf::read_sf("data/")
# region_source = 'USER_SHAPEFILE',
# region = mi_shape

mi_shape <- sf::read_sf("data/HC_Galapagos_HighSeas.shp")

fishing_effort <- get_raster(spatial_resolution = 'LOW',
                             temporal_resolution = 'DAILY',
                             start_date = '2023-01-01',
                             end_date = '2024-01-01',
                             group_by = "VESSEL_ID",
                             region_source = 'USER_SHAPEFILE',
                             region = mi_shape)

# Si la request devuelve 524
# usar
# fishing_effort <- get_last_report()


fishing_effort %>%
  filter(`Apparent Fishing Hours` > 0) %>%
  ggplot() +
  geom_tile(aes(x = Lon,
                y = Lat,
                fill = `Apparent Fishing Hours`)) +
  geom_sf(data = ne_countries(returnclass = "sf", scale = "medium")) +
  coord_sf(xlim = c(min(fishing_effort$Lon),max(fishing_effort$Lon)),
           ylim = c(min(fishing_effort$Lat),max(fishing_effort$Lat))) +
  scale_fill_gradientn(
    trans = 'log10',
    colors = map_effort_light,
    na.value = NA,
    labels = scales::comma) +
  labs(title = "Esfuerzo pesquero aparente en la Corriente de Humboldt",
       fill = "Fishing hours") +
  map_theme
