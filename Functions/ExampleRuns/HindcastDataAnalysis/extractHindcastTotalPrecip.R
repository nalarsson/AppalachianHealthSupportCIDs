### SCRIPT DETAILS ----
## 
## 
##  
## 
## Required Outside Inputs:
##
##
##
##

## INCLUDED FUNCTIONS ----
##
## Name: 
## Returns: 
## Inputs: "var1","var2","var3","var4"
##   "var1" -- explanation
##   "var2" -- explanation
##      CMIP6 accepted values: 
##   "var3" -- explanation
##      CMIP6 accepted values: 
##   "var4" -- explanation
##      default: 
##      CMIP6 accepted values:
##

### SCRIPT BELOW
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/extractLocationAttribute.R")
pat <- "pr"
attribute <- "Precip"


## PARKERSBURG PRECIP ANALYSIS -----
location <- "Parkersburg, WV"

# Parkersburg Historical Total
pb.tasmax.hindcast <- data.frame(matrix(ncol=3,nrow=0))
hindcastdfcolnames <- c("Model","Hindcast_PointValue","Hindcast_PolyValue")
time <- "hindcast"

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  modelfilepath <- paste0(project.loc,goodmodelnames[c],"/")
  setwd(modelfilepath)
  modelfilelistpath <- paste0(filelists.loc,goodmodelnames[c],"/")
  
  allfilelists <- list.files(modelfilelistpath)
  desired.filelist <- grep(paste0(pat,"_",time),allfilelists,value=TRUE)
  filelist.vec <- read.csv(paste0(modelfilelistpath,desired.filelist))
  filelist.vec <- filelist.vec$x
  
  #polygon and point extractions
  hindcast.precip.poly <- mean(sapply(filelist.vec,extractLocationAttribute,
                                       location="Parkersburg",shape="polygon",op=sum))
  hindcast.precip.point <- mean(sapply(filelist.vec,extractLocationAttribute,
                                        location="Parkersburg",shape="point",op=sum))
  
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],hindcast.precip.point,hindcast.precip.poly)
  #bind
  pb.tasmax.hindcast <- rbind(pb.tasmax.hindcast,vec.to.bind)
}
colnames(pb.tasmax.hindcast) <- hindcastdfcolnames
pb.tasmax.hindcast

end_time <- Sys.time()
end_time-start_time


write.csv(pb.tasmax.hindcast,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/ParkersburgTotalPrecip.csv")


## CHARLESTON PRECIP ANALYSIS -----
location <- "Charleston, WV"


# Charleston Historical Average
ch.tasmax.hindcast <- data.frame(matrix(ncol=3,nrow=0))
hindcastdfcolnames <- c("Model","Hindcast_PointValue","Hindcast_PolyValue")
time <- "hindcast"

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  modelfilepath <- paste0(project.loc,goodmodelnames[c],"/")
  setwd(modelfilepath)
  modelfilelistpath <- paste0(filelists.loc,goodmodelnames[c],"/")
  
  allfilelists <- list.files(modelfilelistpath)
  desired.filelist <- grep(paste0(pat,"_",time),allfilelists,value=TRUE)
  filelist.vec <- read.csv(paste0(modelfilelistpath,desired.filelist))
  filelist.vec <- filelist.vec$x
  
  #polygon and point extractions
  hindcast.precip.poly <- mean(sapply(filelist.vec,extractLocationAttribute,
                                       location="Charleston",shape="polygon",op=sum))
  hindcast.precip.point <- mean(sapply(filelist.vec,extractLocationAttribute,
                                        location="Charleston",shape="point",op=sum))
  
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],hindcast.precip.point,hindcast.precip.poly)
  #bind
  ch.tasmax.hindcast <- rbind(ch.tasmax.hindcast,vec.to.bind)
}
colnames(ch.tasmax.hindcast) <- hindcastdfcolnames
ch.tasmax.hindcast

end_time <- Sys.time()
end_time-start_time


write.csv(ch.tasmax.hindcast,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/CharlestonTotalPrecip.csv")


## BLUESTONELAKE PRECIP ANALYSIS -----
location <- "BluestoneLake, WV"

# Bluestone Lake Historical Average
bl.tasmax.hindcast <- data.frame(matrix(ncol=3,nrow=0))
hindcastdfcolnames <- c("Model","Hindcast_PointValue","Hindcast_PolyValue")
time <- "hindcast"

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  modelfilepath <- paste0(project.loc,goodmodelnames[c],"/")
  setwd(modelfilepath)
  modelfilelistpath <- paste0(filelists.loc,goodmodelnames[c],"/")
  
  allfilelists <- list.files(modelfilelistpath)
  desired.filelist <- grep(paste0(pat,"_",time),allfilelists,value=TRUE)
  filelist.vec <- read.csv(paste0(modelfilelistpath,desired.filelist))
  filelist.vec <- filelist.vec$x
  
  #polygon and point extractions
  hindcast.precip.poly <- mean(sapply(filelist.vec,extractLocationAttribute,
                                       location="BluestoneLake",shape="polygon",op=sum))
  hindcast.precip.point <- mean(sapply(filelist.vec,extractLocationAttribute,
                                        location="BluestoneLake",shape="point",op=sum))
  
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],hindcast.precip.point,hindcast.precip.poly)
  #bind
  bl.tasmax.hindcast <- rbind(bl.tasmax.hindcast,vec.to.bind)
}
colnames(bl.tasmax.hindcast) <- hindcastdfcolnames
bl.tasmax.hindcast

end_time <- Sys.time()
end_time-start_time


write.csv(bl.tasmax.hindcast,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/BluestoneLakeTotalPrecip.csv")

