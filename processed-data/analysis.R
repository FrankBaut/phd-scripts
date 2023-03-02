library(tidyverse)
library(magrittr)
lab<- read.csv("Actividades-actígrafo - Hoja 1.csv")
lab <- lab %>% filter(Nombre=="Chris") %>% mutate(inicio = as.POSIXct(Inicio,format = "%d/%m/%Y %H:%M:%S"),fin = as.POSIXct(Fin,format = "%d/%m/%Y %H:%M:%S"))

data <- read.csv("chris/MD - procesados - ED:2E:ED:7A:26:3F-02-28-2023-20-14-55/nuevo_acel-ED:2E:ED:7A:26:3F.csv")
data %<>% mutate(datetime = as.POSIXct(datetime)) %>% mutate(etiqueta = "no-label")

for(i in 1:length(data$datetime)){
  for(j in 1:length(lab$Id)){
   if(data$datetime[i] >= lab$inicio[j] & data$datetime[i] <= lab$fin[j]){
     data$etiqueta[i]<-lab$Actividad.edit[j]
   }
  }
}

data <- data %>% mutate(change_etiqueta = rle(etiqueta))

caminar<- data  %>% filter(etiqueta=="caminar") %>% mutate(rms = sqrt(x^2+y^2+z^2))
