#get setup data if not already there
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/analysisSetup.R")

getMaxAnnualFiveDayTotalPrecipitation <- function(file,location="Pulaski",shape="polygon") {

  point <- loc.csv[loc.csv$Location==location,]
  point$Lon <- 360 - abs(point$Lon)
  loc <- st_point(c(point$Lon,point$Lat)) #c(lon,lat)
  loc.point <- st_sf(st_sfc(geometry=loc))

  nc.raster <- stack(file)
  nc.raster <- nc.raster*(86400/25.4)
  loc.point <- st_set_crs(loc.point,crs(nc.raster))

  #vector of data
  loc.vec <- raster::extract(nc.raster,loc.point)

  loc.df <- data.frame(day=1:nlayers(nc.raster),
                       value=NA)
  loc.df$value=loc.vec[1,]

  fivedaysum <- c()
  for (i in 5:nlayers(nc.raster)) {
    fiveday <- loc.df$value[(i-4):i]
    s <- sum(fiveday)
    fivedaysum <- c(fivedaysum,s)
  }

  max_fivedaysum <- max(fivedaysum)
  return(max_fivedaysum)
}





