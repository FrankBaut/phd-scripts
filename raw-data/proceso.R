# Cargar el paquete "tidyverse" para manipulación de datos
library(tidyverse)

# Cargar el archivo CSV original
datos <- read.csv("C0:D3:A1:AC:AA:EB-02-28-2023-21-04-43/acceleration-02-28-2023-21-04-45.csv",header = F)

# Extraer el string de la fila 1,1 y agregarlo al nombre del archivo
nuevo_nombre <- paste0("nuevo_", datos[1,1], ".csv")

# Seleccionar solo las filas de la 3 en adelante
datos <- datos[3:nrow(datos),]

# Renombrar las columnas
nombres_columnas <- c("datetime", "x", "y", "z")
colnames(datos) <- nombres_columnas

# Extraer los valores de las columnas x, y, z
datos <- datos %>%
  mutate(
    x = str_extract(x, "\\d+\\.?\\d*"),
    y = str_extract(y, "\\d+\\.?\\d*"),
    z = str_extract(z, "\\d+\\.?\\d*")
  )

# Escribir los datos en el nuevo archivo CSV
#write_csv(datos, nuevo_nombre)
