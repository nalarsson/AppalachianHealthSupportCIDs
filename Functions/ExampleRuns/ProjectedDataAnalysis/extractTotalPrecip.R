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

### SCRIPT BELOW (STUFF FOR ALL SCENARIOS) ----
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/extractLocationAttribute.R")
pat <- "pr"
attribute <- "Precip"
n.cores <- floor(0.6*20) #use 75% of cores requested (20)

totalprecip.reqobjs <- c("filesubset","loc.csv",
                      "extractLocationAttribute",
                      "mm_to_inches","app.shape")

## PULASKI PRECIP ANALYSIS -----
location <- "Pulaski, VA"
pulaski.df <- data.frame(matrix(nrow=0,ncol=10))

# Pulaski Historical Average (CONVERT ALL TO BE LIKE THIS)
pul.precip.hindcast <- data.frame(matrix(ncol=3,nrow=0))
hindcastdfcolnames <- c("Model","Hindcast_PointValue","Hindcast_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                 location="Pulaski",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                  location="Pulaski",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.precip.hindcast <- rbind(pul.precip.hindcast,vec.to.bind)
}
colnames(pul.precip.hindcast) <- hindcastdfcolnames

end_time <- Sys.time()
end_time-start_time


# Pulaski Midcentury 126 Average
pul.precip.mc126 <- data.frame(matrix(ncol=3,nrow=0))
mc126dfcolnames <- c("Model","MC126_PointValue","MC126_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp126",timeframe="midcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.precip.mc126 <- rbind(pul.precip.mc126,vec.to.bind)
}
colnames(pul.precip.mc126) <- mc126dfcolnames

end_time <- Sys.time()
end_time-start_time


# Pulaski Endcentury 126 Average
pul.precip.ec126 <- data.frame(matrix(ncol=3,nrow=0))
ec126dfcolnames <- c("Model","EC126_PointValue","EC126_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp126",timeframe="endcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.precip.ec126 <- rbind(pul.precip.ec126,vec.to.bind)
}
colnames(pul.precip.ec126) <- ec126dfcolnames

end_time <- Sys.time()
end_time-start_time


# Pulaski Midcentury 585 Average
pul.precip.mc585 <- data.frame(matrix(ncol=3,nrow=0))
mc585dfcolnames <- c("Model","MC585_PointValue","MC585_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp585",timeframe="midcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.precip.mc585 <- rbind(pul.precip.mc585,vec.to.bind)
}
colnames(pul.precip.mc585) <- mc585dfcolnames

end_time <- Sys.time()
end_time-start_time



# Pulaski Endcentury 585 Average
pul.precip.ec585 <- data.frame(matrix(ncol=3,nrow=0))
ec585dfcolnames <- c("Model","EC585_PointValue","EC585_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp585",timeframe="endcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.precip.ec585 <- rbind(pul.precip.ec585,vec.to.bind)
}
colnames(pul.precip.ec585) <- ec585dfcolnames

end_time <- Sys.time()
end_time-start_time

#merge all dataframes into one
df <- merge(pul.precip.hindcast,pul.precip.mc126,by="Model")
df <- merge(df,pul.precip.mc585,by="Model")
df <- merge(df,pul.precip.ec126,by="Model")
pulaski.df <- merge(df,pul.precip.ec585,by="Model")

write.csv(pulaski.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/PulaskiTotalPrecip.csv")

## WILLIAMSBURG PRECIP ANALYSIS -----
location <- "Williamsburg, WV"

# Williamsburg Historical Average
wil.precip.hindcast <- data.frame(matrix(ncol=3,nrow=0))
hindcastdfcolnames <- c("Model","Hindcast_PointValue","Hindcast_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.precip.hindcast <- rbind(wil.precip.hindcast,vec.to.bind)
}
colnames(wil.precip.hindcast) <- hindcastdfcolnames

end_time <- Sys.time()
end_time-start_time



# Williamsburg Midcentury 126 Average
wil.precip.mc126 <- data.frame(matrix(ncol=3,nrow=0))
mc126dfcolnames <- c("Model","MC126_PointValue","MC126_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp126",timeframe="midcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.precip.mc126 <- rbind(wil.precip.mc126,vec.to.bind)
}
colnames(wil.precip.mc126) <- mc126dfcolnames

end_time <- Sys.time()
end_time-start_time


# Williamsburg Endcentury 126 Average
wil.precip.ec126 <- data.frame(matrix(ncol=3,nrow=0))
ec126dfcolnames <- c("Model","EC126_PointValue","EC126_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp126",timeframe="endcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.precip.ec126 <- rbind(wil.precip.ec126,vec.to.bind)
}
colnames(wil.precip.ec126) <- ec126dfcolnames

end_time <- Sys.time()
end_time-start_time

# Williamsburg Midcentury 585 Average
wil.precip.mc585 <- data.frame(matrix(ncol=3,nrow=0))
mc585dfcolnames <- c("Model","MC585_PointValue","MC585_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp585",timeframe="midcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.precip.mc585 <- rbind(wil.precip.mc585,vec.to.bind)
}
colnames(wil.precip.mc585) <- mc585dfcolnames

end_time <- Sys.time()
end_time-start_time



# Williamsburg Endcentury 585 Average
wil.precip.ec585 <- data.frame(matrix(ncol=3,nrow=0))
ec585dfcolnames <- c("Model","EC585_PointValue","EC585_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp585",timeframe="endcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.precip.ec585 <- rbind(wil.precip.ec585,vec.to.bind)
}
colnames(wil.precip.ec585) <- ec585dfcolnames

end_time <- Sys.time()
end_time-start_time

#merge all dataframes into one
df <- merge(wil.precip.hindcast,wil.precip.mc126,by="Model")
df <- merge(df,wil.precip.mc585,by="Model")
df <- merge(df,wil.precip.ec126,by="Model")
williamsburg.df <- merge(df,wil.precip.ec585,by="Model")

write.csv(williamsburg.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/WilliamsburgTotalPrecip.csv")


## NELSONVILLE PRECIP ANALYSIS -----
location <- "Nelsonville, OH"

# Nelsonville Historical Average
nel.precip.hindcast <- data.frame(matrix(ncol=3,nrow=0))
hindcastdfcolnames <- c("Model","Hindcast_PointValue","Hindcast_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.precip.hindcast <- rbind(nel.precip.hindcast,vec.to.bind)
}
colnames(nel.precip.hindcast) <- hindcastdfcolnames

end_time <- Sys.time()
end_time-start_time



# Nelsonville Midcentury 126 Average
nel.precip.mc126 <- data.frame(matrix(ncol=3,nrow=0))
mc126dfcolnames <- c("Model","MC126_PointValue","MC126_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp126",timeframe="midcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.precip.mc126 <- rbind(nel.precip.mc126,vec.to.bind)
}
colnames(nel.precip.mc126) <- mc126dfcolnames
nel.precip.mc126

end_time <- Sys.time()
end_time-start_time



# Nelsonville Endcentury 126 Average
nel.precip.ec126 <- data.frame(matrix(ncol=3,nrow=0))
ec126dfcolnames <- c("Model","EC126_PointValue","EC126_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp126",timeframe="endcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.precip.ec126 <- rbind(nel.precip.ec126,vec.to.bind)
}
colnames(nel.precip.ec126) <- ec126dfcolnames
nel.precip.ec126

end_time <- Sys.time()
end_time-start_time


# Nelsonville Midcentury 585 Average
nel.precip.mc585 <- data.frame(matrix(ncol=3,nrow=0))
mc585dfcolnames <- c("Model","MC585_PointValue","MC585_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp585",timeframe="midcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.precip.mc585 <- rbind(nel.precip.mc585,vec.to.bind)
}
colnames(nel.precip.mc585) <- mc585dfcolnames
nel.precip.mc585

end_time <- Sys.time()
end_time-start_time



# Nelsonville Endcentury 585 Average
nel.precip.ec585 <- data.frame(matrix(ncol=3,nrow=0))
ec585dfcolnames <- c("Model","EC585_PointValue","EC585_PolyValue")

start_time <- Sys.time()
for (c in 1:length(goodmodelnames)) {
  #setwd for model
  filesubset <- getCorrectFiles(model=goodmodelnames[c],
                                pat=pat,ssp="ssp585",timeframe="endcentury")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[c]))
  
  #parallelize process
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, totalprecip.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=sum))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=sum))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.precip.ec585 <- rbind(nel.precip.ec585,vec.to.bind)
}
colnames(nel.precip.ec585) <- ec585dfcolnames
nel.precip.ec585

end_time <- Sys.time()
end_time-start_time

#merge all dataframes into one
df <- merge(nel.precip.hindcast,nel.precip.mc126,by="Model")
df <- merge(df,nel.precip.mc585,by="Model")
df <- merge(df,nel.precip.ec126,by="Model")
nelsonville.df <- merge(df,nel.precip.ec585,by="Model")

write.csv(nelsonville.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/NelsonvilleTotalPrecip.csv")
