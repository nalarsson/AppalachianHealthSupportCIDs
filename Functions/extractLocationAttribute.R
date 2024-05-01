### SCRIPT DETAILS ----
##  NUMBER OF INCLUDED FUNCTIONS: 1
##  Function to return single value per year to summarize climate aspects.
##  This function is useful for annual summaries and comparing trends over time.
##
## Required Outside Inputs: Acquired via "analysisSetup.R"
##  app.counties: shape file for Appalachian counties
##  loc.csv: table of different locations for CMIP6 project 


## INCLUDED FUNCTIONS ----
##
## Name: "extractPolygonAttribute"
## Returns: A single value representing an annual average or total for
##           a climate aspect. Ex: total annual precipitation
## Inputs: "file","location","shape","op","rastercalcmethod"
##   "file" -- the file on which to perform the operation
##   "location" -- the location at which values are extracted
##      CMIP6 accepted values: "Pulaski","Williamsburg",
##        "Nelsonville","Parkersburg"
##   "shape" -- is it a point or county extraction? 
##      County extractions come from Appalachian shapefile
##      CMIP6 accepted values: "polygon" or "point"
##   "op" -- operation to get single value: average or total?
##      default: "mean"
##      CMIP6 accepted values: "mean" (temperature, wind) or 
##        "total"(precip)
##   "rastercalcmethod" -- how the extract operation deals with
##      discrepancies over the shapefile template
##      fixed default: "mean"
##      DO NOT CHANGE! 

### FUNCTION BELOW -----
#load in libraries and inputs
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/analysisSetup.R")

#begin function
extractLocationAttribute <- function(file,
                                    location="Pulaski",shape="point",
                                    op=mean,rastercalcmethod=mean) {
  
  #read in file
  att.raster <- brick(file)
  
  #get file climate aspect
  name.split <- strsplit(file,"_")
  pat <- name.split[[1]][2]
  
  #convert units
  if (pat=="pr"){
    att.raster <- att.raster*86400
    att.raster <- mm_to_inches(att.raster)
    attname <- "pr"
    # units="in./day"
  } else if (pat=="sfcWind") {
    att.raster <- att.raster*(3600/1609.344)
    attname <- "wind"
    # units="mph"
  } else if (pat=="tasmax") {
    att.raster <- att.raster-273.15
    att.raster <- celsius_to_fahrenheit(att.raster)
    attname <- "tmax"
    # units="degrees_F"
  } else {
    att.raster <- att.raster-273.15
    att.raster <- celsius_to_fahrenheit(att.raster)
    attname <- "tmin"
    # units="degrees_F"
  }
  
  #rotate raster (required step)
  suppressWarnings(att.raster <- rotate(att.raster)) #warnings suppressed
  
  #get area of interest
  aoi <- loc.csv[loc.csv$Location==location,]
  
  #extract based on point or polygon
  if (shape=="polygon") {
    state <- app.shape[app.shape$STATEFP==aoi$StateFP,]
    county <- state[state$COUNTYFP==aoi$CountyFP,]
    
    county.reproj <- st_transform(county,crs(att.raster))
    extracted.values <- raster::extract(att.raster,county.reproj,fun=rastercalcmethod,
                                        na.rm=TRUE)
 
  } else {  #point extraction
    loc <- st_point(c(aoi$Lon,aoi$Lat)) #c(lon,lat)
    loc.point <- st_sf(st_sfc(geometry=loc))
    
    extracted.values <- raster::extract(att.raster,loc.point,na.rm=TRUE)
  }
  
  #perform operation to get single value
  extracted.value <- op(extracted.values,na.rm=TRUE)
  #return single value
  return(extracted.value)
} 

## CMIP 6 EXAMPLES -----
# setwd(project.loc)
# setwd("./ACCESS-CM2")
# testfile <- list.files()[1]
# extractPolygonAttribute(file=testfile)
# extractPolygonAttribute(file=testfile,shape="point")
