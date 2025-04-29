library(gfwr)
library(tidyr)
library(dplyr)

# Comenzamos con el help de la función
# Una búsqueda simple
# El primer parámetro es query

info_vessel <- get_vessel_info(query = 431782000, # puede ser un elemento o un vector
                               search_type = "search",
                               key = gfw_auth())

# search_type = "search" y key = gfw_auth() son valores por default
# esa búsqueda es equivalente a get_vessel_info(431782000)

# 2 vessels! por qué?


# exploremos el objeto
# nombres
names(info_vessel) # siete partes (slots) con información
# acceso al slot con $ signo de dólar
info_vessel$dataset

# o con corchete []
info_vessel["dataset"]

# mejor con $ porque autocompleta

# Explorando el output:
# 1 información de AIS en selfReportedInfo:

info_vessel$selfReportedInfo
info_vessel$selfReportedInfo$ssvid
info_vessel$selfReportedInfo$imo
names(info_vessel$selfReportedInfo)
View(info_vessel$selfReportedInfo)

# el mmsi - ssvid
info_vessel$selfReportedInfo$ssvid
# retorna el que fue pedido 431782000 y otros más.

# ver el index para entender cómo vesselid se agrupan juntos
info_vessel$selfReportedInfo[, c("index", "vesselId")]
# per el index son dos barcos, los tres primeros son uno y el cuarto es otro

# View del objeto ayuda a ver:
# diferente vesselId para cada segmento por fechas
# el primer barco tiene el mismo IMO
# no todos tienen el mismo número de posiciones
# ...

# Información de los registros en registryInfo
info_vessel$registryInfo # los dos barcos

View(info_vessel$registryInfo)

# ¡Hay información complementaria! El IMO del segundo que no estaba en AIS,
# también call sign, tonnage, tipo de pesca (geartype - si es algo general como
# "fishing" quiere decir que el algoritmo de GFW aún no logra clasificar a
# ese barco más allá de esa categoría).


# Autorizaciones
info_vessel$registryPublicAuthorizations
info_vessel$registryPublicAuthorizations %>% unnest(sourceCode)
# Cuando encuentren columnas con información anidada oculta,
# usen la función unnest del paquete tidyr


# Otros slots
names(info_vessel)
info_vessel$dataset
info_vessel$registryInfoTotalRecords
info_vessel$registryInfo

# ¿quién es el dueño del barco?
info_vessel$registryOwners
info_vessel$registryOwners %>% unnest(sourceCode)

View(info_vessel$combinedSourcesInfo)
View(info_vessel$registryInfo)
View(info_vessel$selfReportedInfo)

# podemos explorar las fechas en las que el mmsi fue utilizado en cada barco:
info_vessel$selfReportedInfo[c("transmissionDateFrom", "transmissionDateTo", "ssvid", "index", "flag")]
# vamos a organizarlos por fechas
info_vessel$selfReportedInfo[c("transmissionDateFrom", "transmissionDateTo", "ssvid", "index")] %>%
  arrange(transmissionDateFrom, transmissionDateTo)

# Otras formas de buscar embarcaciones

info_vessel$selfReportedInfo$vesselId[4] # selecciona el cuarto elemento de la columna vesselId

id_test <- info_vessel$selfReportedInfo$vesselId[4] # selecciona el cuarto elemento de la columna vesselId
id_test
get_vessel_info(search_type = "id", ids = id_test)

id_test2 <- info_vessel$selfReportedInfo$vesselId[1] # selecciona el primer elemento  de la columna vesselID
id_test2
get_vessel_info(search_type = "id", ids = id_test2)

info_vessel$registryOwners
info_vessel$selfReportedInfo
