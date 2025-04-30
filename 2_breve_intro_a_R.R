# R es un lenguaje y un programa vs RStudio que es una IDE - interface de usuario. Hay otra maneras de usar R. RStudio es una de las maneras más eficientes de hacerlo.

# Cuatro paneles

# 1. Scripts, archivos de texto con extensión .R

# control + enter para mandar las líneas al terminal abajo
# Si aparece > quiere decir que el terminal está listo
# Si aparece + quiere decir que se quedó esperando por ej. a que se cierre algún paréntesis
2 + 2

# 2. en el terminal de R (Consola)
# un terminal del computador

# 3. e 4. Se pueden reorganizar los paneles yendo a Tools > Global Options > Pane Layout

# Environment. Los objetos que se guardan en el environment consumen memoria.

numero <- 3
# debe aparecer número y el valor 3 en la pestaña environment.

# History

# Instalar paquetes - CRAN install.packages("xxx")

# Files
# Un navegador de archivos

# Plots
# Donde van a aparecer los plots

# Help
# Donde aparece la documentación de las funciones y paquetes
# Se puede invocar a la ayuda con ? o help()

# Cargar paquetes
library(gfwr)

# Usando help
help("get_vessel_info")

# En la pestaña de help
# La documentación de las funciones guarda una misma estructura
# Descripción
# Uso (los argumentos, el orden y cuáles son los valores predeterminados/default)
#
# Ejemplos
# Se pueden correr seleccionando el texto y ejecutando ctrl enter o copiando y pegando

# Recuerde que para crear objetos es necesario darles un nombre y usar <-


# Objetos en R

# Clases
# números, caracteres, lógicos
3
"a"
TRUE

class(3)
class("a")
class("3")
class(TRUE)

# hay otros como enteros (integer):
3L
class(3L)


# los vectores son creados concatenando elementos con la función c()
3

c(3, 2, 1)
objeto <- c(3, 2, 1)
class(objeto)
is(objeto)

# Si se mezclan en un vector caracteres, numérico y lógico, el caracter tendrá predominancia sobre el número y el lógico
mix <- c(3, "a")
class(mix)


# lo numérico tendrá predominancia sobre lo lógico, TRUE = 1 FALSE = 0
mix <- c(TRUE, 1)
mix
class(mix)

mix <- c(FALSE, 1)
mix
class(mix)

# Esto es importante porque los argumentos de las funciones esperan input en formatos específicos
# Si el help de la función dice que el argumento es lógico, se espera un TRUE o FALSE
# Si el help de la función dice que el argumento es numérico, se espera un número. Por ejemplo un 3 y no un "3"

# Por cierto, si se crea un objeto con el mismo nombre de uno que ya existe, va a reemplazar el anterior
mix <- c(3, "a", TRUE)
mix
class(mix)


#  Vectores con c()
# Dataframes (tablas) de varias maneras. }
# Usted puede crear una tabla leyendo un archivo de excel, por ejemplo
dataframe1 <- data.frame(variable1 = "a",
                         variable2 = "b",
                         variable3 = "c")
dataframe1
View(dataframe1)

dataframe2 <- data.frame(variable1 = c(1, 3, 4),
                        variable2 = c("b", "oi", 4),
                        variable3 = c(TRUE, TRUE, FALSE))
dataframe2
# las columnas no necesitan ser del mismo tipo, cada columna es un vector.
