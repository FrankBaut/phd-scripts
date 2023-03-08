# Cargar el paquete "tidyverse" para manipulación de datos
library(tidyverse)

# Definir la ruta de la carpeta que contiene las subcarpetas con los archivos CSV
ruta_carpeta_principal <- "~/Escritorio/datos/"

# Obtener los nombres de todas las subcarpetas en la carpeta principal
nombres_subcarpetas <- list.dirs(path = ruta_carpeta_principal, recursive = FALSE)

# Definir una función para procesar los archivos CSV
procesar_archivo_csv <- function(ruta_archivo_csv) {
  
  # Cargar el archivo CSV
  datos <- read.csv(ruta_archivo_csv,header = F)
  #colnames(datos) <- nombres_columnas
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
  return(datos)
  
}

# Iterar sobre cada subcarpeta y cada archivo CSV dentro de la subcarpeta
for (nombre_subcarpeta in nombres_subcarpetas) {
  # Obtener los nombres de todos los archivos CSV en la subcarpeta
  nombres_archivos_csv <- list.files(nombre_subcarpeta, pattern = "*.csv")
  
  # Iterar sobre cada archivo CSV en la subcarpeta
  for (nombre_archivo_csv in nombres_archivos_csv) {
    # Construir la ruta completa del archivo CSV
    ruta_archivo_csv <- file.path(nombre_subcarpeta, nombre_archivo_csv)
    
    # Verificar si el archivo corresponde a "acceleration"
    if (grepl("acceleration", nombre_archivo_csv)) {
      # Aplicar el primer script a los datos del archivo "acceleration"
     acel<-procesar_archivo_csv(ruta_archivo_csv)
    }
    
    # Verificar si el archivo corresponde a "illuminance" o "temperature"
    if (grepl("illuminance", nombre_archivo_csv) || grepl("temperature", nombre_archivo_csv)) {
      # Cargar el archivo CSV
      datos <- read.csv(ruta_archivo_csv,header = F)
      
      # Extraer el string de la fila 1,1 y agregarlo al nombre del archivo
      nuevo_nombre <- paste0("nuevo_", datos[1,1], ".csv")
      
      # Seleccionar solo las filas de la 2 en adelante
      datos <- datos[3:nrow(datos),]
      
      # Renombrar las columnas
      nombres_columnas <- c("datetime", "valor")
      colnames(datos) <- nombres_columnas
      remp_ilu<-datos
      # Escribir los datos en el nuevo archivo CSV
      #write_csv(datos, nuevo_nombre)
      return(datos)
    }
    
  }
}
