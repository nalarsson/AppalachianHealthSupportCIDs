### SCRIPT DETAILS ----
## Includes librares required for NEX-GDDP work.
## Includes any information that is repeatedly used.

## Check all file paths before running
##  especially "project.loc" variable
## Run before performing any other NEX-GDDP tasks.
## Many other functions include a "source()" of 
##  this script.

### LIBRARIES ------
#pacman library for easy library work
#run only on first time for machine
#install.packages("pacman")

#load packages
pacman::p_load("ncdf4","raster",#"lubridate",#"rdgal","forecats",
               "rgeos","utils", "stringr",
               "stats","sf","sp","parallel","ggplot2",
               "tidyverse","magrittr","tidyr","stats","tmaptools",
               "RColorBrewer") #,"ggpubr")

#ggsave specs
image.width <- 7
image.height <- 4
image.units <- "in"

### LOCATIONS -----
#filepath for csv of location information
csv <- "~/2023/NEX-GDDP/Code_Larsson/Analysis/LocationData_2024.csv"
#read in csv
loc.csv <- read.csv(csv,stringsAsFactors = FALSE)
loc.csv$CountyFP <- as.character(loc.csv$CountyFP)
loc.csv$CountyFP <- str_pad(loc.csv$CountyFP,width=3,
                            side="left",pad="0")

### YEARS -----
#the 4 different 25 year periods
#historical.years <- c(1990:2014)
historical.years <- c(1970:2014)
midcentury.years <- c(2040:2064)
endcentury.years <- c(2075:2099)
#hindcastanalysis.years <- c(1950:2014)

#all combined (mostly for file acquisition)
all.years <- c(historical.years,midcentury.years,endcentury.years)

### MODELS -----
#project path for VT ARC
project.loc <- "/projects/shortridge_nex-gddp/Downloads/"

#model names for models using (n=26)
goodmodelnames <- c("ACCESS-CM2","ACCESS-ESM1-5",
                    "BCC-CSM2-MR","CanESM5",
                    "CMCC-ESM2","CNRM-CM6-1",
                    "CNRM-ESM2-1","EC-Earth3",
                    "EC-Earth3-Veg-LR","FGOALS-g3",
                    "GFDL-ESM4","GISS-E2-1-G",
                    "INM-CM4-8","INM-CM5-0",
                    "IPSL-CM6A-LR",
                    "KIOST-ESM","MIROC-ES2L",
                    "MIROC6","MPI-ESM1-2-HR",
                    "MPI-ESM1-2-LR","MRI-ESM2-0",
                    "NESM3","NorESM2-LM",
                    "NorESM2-MM")
# "GFDL-CM4","GFDL-CM4_gr2",

filelists.loc <- "~/2023/NEX-GDDP/Code_Larsson/Analysis/filelists/"



### GET COUNTY SHAPEFILE -------
#get appalachian shape file
app.loc <- "~/2023/NEX-GDDP/Code_Larsson/cb_2016_us_county_5m/appalachia/"
setwd(app.loc)
app.shape <- sf::st_read(dsn=".",layer="appcounties")

## PULL FILELIST FUNCTION
#quick function to read in file CSVs
# pat can be "pr" or "tasmax"
# ssp can be "hindcast", "ssp126", or "ssp585"
# timeframe can be "midcentury" or "endcentury"
getCorrectFiles <- function(model,pat,ssp,timeframe) {
  if(ssp=="hindcast") {
    filelist <- read.csv(paste0(filelists.loc,model,"/",
                                model,"_",pat,"_",ssp,".csv"))
  } else {
    filelist <- read.csv(paste0(filelists.loc,model,"/",
                                model,"_",pat,"_",ssp,"_",timeframe,".csv"))
  }
  return(filelist)
}

## CONVERSION FUNCTIONS -----
#celsius to fahrenheit conversion
celsius_to_fahrenheit <- function(celsius) {
  fahrenheit <- (celsius * 9/5) + 32
  fahrenheit <- round(fahrenheit,2)
  return(fahrenheit)
}

#mm/day to inches/cay conversion
mm_to_inches <- function(mm) {
  inches <- mm / 25.4
  inches <- round(inches,5)
  return(inches)
}

### MAKE COUNTY SHAPFILE -----
# ONLY RUN ONCE
# Use code below to make a shapefile as a subset of the US shapefile
# county.loc <- "~/2023/NEX-GDDP/Code_Larsson/Analysis/cb_2016_us_county_5m/Counties"
# setwd(county.loc)
# counties.shape <- sf::st_read(dsn=".",layer="cb_2016_us_county_5m")
# 
# RUN ONCE
# st.fps <- data.frame(c("Ohio","West Virginia","Tennessee","Kentucky","North Carolina",
#                        "South Carolina","Virginia"),
#                      c("OH","WV","VA","TN","KY","NC","SC"),
#                      c(39, #ohio
#                        54, #wv
#                        51, #va
#                        47, #tn
#                        21, #ky
#                        37, #nc
#                        45) #sc
# )
# colnames(st.fps) <- c("State","Abbr","FP_Code")
# write.csv(st.fps,file="AppalachiaStateInfo.csv")
# 
# 
# app.counties <- subset(counties.shape, counties.shape$STATEFP == st.fps$FP_Code[1] |
#                          counties.shape$STATEFP == st.fps$FP_Code[2] |
#                          counties.shape$STATEFP == st.fps$FP_Code[3] |
#                          counties.shape$STATEFP == st.fps$FP_Code[4] |
#                          counties.shape$STATEFP == st.fps$FP_Code[5] |
#                          counties.shape$STATEFP == st.fps$FP_Code[6] |
#                          counties.shape$STATEFP == st.fps$FP_Code[7])
# #plot(app.counties["STATEFP"])
# 
# #sf::st_write(app.counties,"appcounties.shp",append=FALSE)

 
