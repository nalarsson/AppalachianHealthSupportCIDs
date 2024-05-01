#get setup data if not already there
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/analysisSetup.R")

getDaysAbove90 <- function(file,location="Pulaski") {
  
  point <- loc.csv[loc.csv$Location==location,]
  point$Lon <- 360 - abs(point$Lon)
  loc <- st_point(c(point$Lon,point$Lat)) #c(lon,lat)
  loc.point <- st_sf(st_sfc(geometry=loc))
  
  nc.raster <- stack(file)
  nc.raster <- nc.raster - 273.15
  nc.raster <- celsius_to_fahrenheit(nc.raster)
  loc.point <- st_set_crs(loc.point,crs(nc.raster))
  
  #vector of data
  loc.vec <- raster::extract(nc.raster,loc.point)
  
  loc.df <- data.frame(day=1:nlayers(nc.raster),
                       value=NA)
  loc.df$value=loc.vec[1,]
  
  loc.df <- loc.df[loc.df$value>=90,]
  
  return(nrow(loc.df))
}


getCountAnnualTwoDayHeatwave <- function(file,location="Pulaski") {
  
  point <- loc.csv[loc.csv$Location==location,]
  point$Lon <- 360 - abs(point$Lon)
  loc <- st_point(c(point$Lon,point$Lat)) #c(lon,lat)
  loc.point <- st_sf(st_sfc(geometry=loc))
  
  nc.raster <- stack(file)
  nc.raster <- nc.raster - 273.15
  nc.raster <- celsius_to_fahrenheit(nc.raster)
  loc.point <- st_set_crs(loc.point,crs(nc.raster))
  
  #vector of data
  loc.vec <- raster::extract(nc.raster,loc.point)
  
  loc.df <- data.frame(day=1:nlayers(nc.raster),
                       value=NA)
  loc.df$value=loc.vec[1,]
  
  count_twodayheatwaves <- 0
  for (i in 2:nlayers(nc.raster)) {
    if(loc.df$value[i-1]>=90 & loc.df$value[i]>=90) {
      count_twodayheatwaves <- count_twodayheatwaves + 1
    }
  }
  
  return(count_twodayheatwaves)
}





