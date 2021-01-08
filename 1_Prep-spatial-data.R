
library(mapDK)
library(sp)
library(stringr)

#########################################################################################
# Prepare Municipality and Region spatial data file

# Convert fortify map data.frame to individual Polygon and then Polygons objects.
# Save names in a separate list

data_shape = mapDK::rural
#data_shape = mapDK::municipality
sel <- names(table(data_shape$group))
list_pol <- list()
list_names <- c()

for (i in 1:length(sel)) {
  x <- subset(data_shape, group == sel[i])
  xx = Polygon(cbind(x$long, x$lat), hole = unique(x$hole))
  dat_name <- paste0("pol_", i)
  list_pol[i] <- dat_name
  list_names <- paste0(list_names, list_pol[i], ",")
  eval(parse(text = paste0(
    dat_name, "<-Polygons(list(xx), sel[i])"
  )))
  rm(dat_name, x, xx)
  print(sel[i])
}

#########################################################################################
# Convert to SpatialPolygons class and SpatialPolygonsDataFrame

list_names <- str_sub(list_names, 1, nchar(list_names) - 1)
eval(parse(
  text = paste0(
    "DATA_POL = SpatialPolygons(",
    "list(",
    list_names,
    "),1:",
    length(list_pol),
    ")"
  )
))

centroids <- coordinates(DATA_POL)
x <- centroids[, 1]
y <- centroids[, 2]
z <- 1.4 + 0.1 * x + 0.2 * y + 0.002 * x * x
DATA_POL_dataframe <-
  SpatialPolygonsDataFrame(DATA_POL,
                           data = data.frame(
                             x = x,
                             y = y,
                             z = z,
                             row.names = row.names(DATA_POL)
                           ))

# Convert to geojson and add names

nc_geojson <- geojsonio::geojson_json(DATA_POL_dataframe)
geoj <- rjson::fromJSON(nc_geojson)

for (i in 1:length(sel)) {
  geoj$features[[i]]$id <- sel[i]
}

# Create municipality name table.

sel_short <- gsub("(\\.).*", "", sel)
REZ <- data.frame(sel, sel_short)
colnames(REZ) <- c("subreg", "reg")


#########################################################################################
# Save data

dir.create("Data")

#save(REZ, geoj, file = "Data/data_geo_rural.RData")
save(REZ, geoj, file = "Data/data_geo_municipality.RData")
