source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/analysisSetup.R")

#PRIMARY FUNCTION
hindcastData <- function(file,model="ACCESS-CM2",
                         location="Parkersburg") {
  
  #generate point object for location of interest
  point <- loc.csv[loc.csv$Location==location,]
  point$Lon <- 360 - abs(point$Lon)
  loc <- st_point(c(point$Lon,point$Lat)) #c(lon,lat)
  loc.point <- st_sf(st_sfc(geometry=loc))
  
  #open file via raster package
  nc.raster <- brick(file)
  
  #set up data frame to be exported to csv
  desired.cols <- c("Filename","Location","State","Latitude","Longitude",
                    "Year","Date","Attribute","Value","Units",
                    "ImperialValue","ImperialUnits")
  yr.data <- data.frame(matrix(nrow=nlayers(nc.raster),ncol=length(desired.cols)))
  colnames(yr.data) <- desired.cols
  
  #split file name and get years
  filesplit <- strsplit(file,"_")
  pat <- filesplit[[1]][2]
  yr <- gsub(".nc","",filesplit[[1]][8])
  yr.data$Filename <- rep(file)
  yr.data$Location <- rep(location)
  yr.data$State <- rep(point$State)
  yr.data$Latitude <- rep(point$Latitude)
  yr.data$Longitude <- rep(point$Longitude)
  yr.data$Attribute <- rep(pat)
  yr.data$Year <- rep(yr)

  #convert based on pattern and add units
  #temp -- 1 decimal place
  #pr -- 2 decimal places
  if (pat=="pr"){
    nc.raster <- nc.raster*86400
    units="mm/day"
    i.units="in./day"
  } else if (pat=="sfcWind") {
    nc.raster <- nc.raster*(3600/1609.344)
    units="mph"
  } else {
    nc.raster <- nc.raster-273.15
    units="degrees_Celsius"
    i.units="degrees_Fahrenheit"
  }
  #put units into dataframe
  yr.data$Units <- rep(units)
  yr.data$ImperialUnits <- rep(i.units)
  
  #generate time vector
  origin <- as.Date(paste0(yr,"-01-01"))
  
  layers <- seq(1:nlayers(nc.raster))
  dates <- as.Date(layers,origin=origin-1,format="%Y%m%d")
  yr.data$Date <- dates
  
  #extract data
  att.values <- raster::extract(nc.raster,loc.point)
  yr.data$Value <- att.values[1:length(att.values)]
  if(pat=="tasmax"|pat=="tasmin"){
    yr.data$Value <- round(yr.data$Value, 2)
  } else {
    yr.data$Value <- round(yr.data$Value, 1)
  }
  
  #convert to imperial
  if (pat=="pr") {
    yr.data$ImperialValue <- mm_to_inches(yr.data$Value)
  } else if (pat=="tasmax"|pat=="tasmin") {
    yr.data$ImperialValue <- celsius_to_fahrenheit(yr.data$Value)
  }
  
  
  #write to csv
  fn <- paste0(location,"_hindcastdata_",pat,"_",yr,".csv")
  csv.dir <- paste0("~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/rawfiles/",
                    location,point$State,"_",model,"_hindcast/")
  suppressWarnings(dir.create(csv.dir))
  write.csv(yr.data,
    file=paste0(csv.dir,fn))
  
  #my cat added this
  #````logohb 
  
  #show that it is working
  return(fn)
}



