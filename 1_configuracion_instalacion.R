# https://docs.google.com/document/d/1N1BsL778TmFtaCJDwrGIQCY8Q-T5dJhURjyWB1KKjGw/edit?usp=sharing

# todo el setup es desde este workspace (usted puede copiar y seguir estas instrucciones localmente)

## Cuenta en Global Fishing Watch
### Cree una cuenta en Global Fishing Watch y genere un token de acceso a las APIs
install.packages("usethis")

# Abra y edite el archivo .R_environ para incluir el token así:
usethis::edit_r_environ()

# El archivo .R_environ se va a abrir automáticamente, copie y pegue su token así:
#GFW_TOKEN = "eyJhb..."
# Guarde y cierre el archivo. Reinicie la sesión de R (menu: Session/Restart R)

# Instalar el paquete desde GitHub
# install.packages("remotes")

# El símbolo :: es para llamar a la función de algún paquete en específico:
 remotes::install_github("GlobalFishingWatch/gfwr",
                         dependencies = TRUE,
                         build_vignettes = TRUE)
