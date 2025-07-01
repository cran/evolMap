## ----message=FALSE, warning=FALSE---------------------------------------------
library(evolMap)
library(sf)

## ----message=FALSE, warning=FALSE, results='hide'-----------------------------
# Source: https://github.com/scriptorivm/pompeii
domi <- st_read('https://raw.githubusercontent.com/scriptorivm/pompeii/master/geojson/domi.geojson')

domi[["info"]] <- paste0("<iframe src=\"",sub("http:","https:",domi[["N3"]]),"\"></iframe>")
domi[is.na(domi[["N3"]]),"info"] <- "Missing info"

## -----------------------------------------------------------------------------
map <- create_map(center=c(40.750556,14.489722), zoom=16)
map <- add_entities(map,domi,info="info")
plot(map, directory = "pompeii")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("pompeii.png")

## -----------------------------------------------------------------------------
# https://leaflet-extras.github.io/leaflet-providers/preview/
map <- create_map(center=c(40.750556,14.489722), zoom=16, provider="OpenStreetMap.HOT")
map <- add_entities(map,domi,info="info")
plot(map, directory = "pompeii_provider")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("pompeii_provider.png")

## -----------------------------------------------------------------------------
# Source: https://ukraine.bellingcat.com/
data <- read.csv(system.file("extdata", "ukr-civharm-2023-02-27.csv",
        package="evolMap"))
data[["date"]] <- as.Date(data[["date"]],"%m/%d/%Y")

data[["type"]] <- NA
for(i in seq_len(nrow(data))){
  if(data[i,"associations"]!=""){
    data[i,"type"] <- unlist(strsplit(unlist(strsplit(data[i,"associations"],","))[1],"="))[2]
  }
}

map <- create_map(center=c(49.3402,31.9146),zoom=6.75)
map <- add_markers(map, data, color = "type",
  latitude = "latitude", longitude = "longitude",
  start = "date")
plot(map, dir="ukraine")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("ukraine.png")

## -----------------------------------------------------------------------------
map <- create_map(center=c(49.3402,31.9146),zoom=6.75, mode=2)
map <- add_markers(map, data, color = "type",
  latitude = "latitude", longitude = "longitude",
  start = "date")
plot(map, dir="ukraineNew")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("ukraineNew.png")

