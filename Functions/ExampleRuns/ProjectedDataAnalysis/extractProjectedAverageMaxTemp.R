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
pat <- "tasmax"
attribute <- "MaxTemp"
n.cores <- floor(0.6*20) #use 75% of cores requested (20)

avgmaxtemp.reqobjs <- c("filesubset","loc.csv",
                         "extractLocationAttribute",
                         "celsius_to_fahrenheit","app.shape")

## PULASKI MAXTEMP ANALYSIS -----
location <- "Pulaski, VA"
pulaski.df <- data.frame(matrix(nrow=0,ncol=10))

# Pulaski Historical Average (CONVERT ALL TO BE LIKE THIS)
pul.tasmax.hindcast <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.tasmax.hindcast <- rbind(pul.tasmax.hindcast,vec.to.bind)
}
colnames(pul.tasmax.hindcast) <- hindcastdfcolnames

end_time <- Sys.time()
end_time-start_time


# Pulaski Midcentury 126 Average
pul.tasmax.mc126 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.tasmax.mc126 <- rbind(pul.tasmax.mc126,vec.to.bind)
}
colnames(pul.tasmax.mc126) <- mc126dfcolnames

end_time <- Sys.time()
end_time-start_time


# Pulaski Endcentury 126 Average
pul.tasmax.ec126 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.tasmax.ec126 <- rbind(pul.tasmax.ec126,vec.to.bind)
}
colnames(pul.tasmax.ec126) <- ec126dfcolnames

end_time <- Sys.time()
end_time-start_time


# Pulaski Midcentury 585 Average
pul.tasmax.mc585 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.tasmax.mc585 <- rbind(pul.tasmax.mc585,vec.to.bind)
}
colnames(pul.tasmax.mc585) <- mc585dfcolnames

end_time <- Sys.time()
end_time-start_time



# Pulaski Endcentury 585 Average
pul.tasmax.ec585 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Pulaski",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Pulaski",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  pul.tasmax.ec585 <- rbind(pul.tasmax.ec585,vec.to.bind)
}
colnames(pul.tasmax.ec585) <- ec585dfcolnames

end_time <- Sys.time()
end_time-start_time

#merge all dataframes into one
df <- merge(pul.tasmax.hindcast,pul.tasmax.mc126,by="Model")
df <- merge(df,pul.tasmax.mc585,by="Model")
df <- merge(df,pul.tasmax.ec126,by="Model")
pulaski.df <- merge(df,pul.tasmax.ec585,by="Model")

write.csv(pulaski.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/PulaskiAverageMaxTemp.csv")

## WILLIAMSBURG MAXTEMP ANALYSIS -----
location <- "Williamsburg, WV"

# Williamsburg Historical Average
wil.tasmax.hindcast <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.tasmax.hindcast <- rbind(wil.tasmax.hindcast,vec.to.bind)
}
colnames(wil.tasmax.hindcast) <- hindcastdfcolnames

end_time <- Sys.time()
end_time-start_time



# Williamsburg Midcentury 126 Average
wil.tasmax.mc126 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.tasmax.mc126 <- rbind(wil.tasmax.mc126,vec.to.bind)
}
colnames(wil.tasmax.mc126) <- mc126dfcolnames

end_time <- Sys.time()
end_time-start_time


# Williamsburg Endcentury 126 Average
wil.tasmax.ec126 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.tasmax.ec126 <- rbind(wil.tasmax.ec126,vec.to.bind)
}
colnames(wil.tasmax.ec126) <- ec126dfcolnames

end_time <- Sys.time()
end_time-start_time

# Williamsburg Midcentury 585 Average
wil.tasmax.mc585 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.tasmax.mc585 <- rbind(wil.tasmax.mc585,vec.to.bind)
}
colnames(wil.tasmax.mc585) <- mc585dfcolnames

end_time <- Sys.time()
end_time-start_time



# Williamsburg Endcentury 585 Average
wil.tasmax.ec585 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Williamsburg",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Williamsburg",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  wil.tasmax.ec585 <- rbind(wil.tasmax.ec585,vec.to.bind)
}
colnames(wil.tasmax.ec585) <- ec585dfcolnames

end_time <- Sys.time()
end_time-start_time

#merge all dataframes into one
df <- merge(wil.tasmax.hindcast,wil.tasmax.mc126,by="Model")
df <- merge(df,wil.tasmax.mc585,by="Model")
df <- merge(df,wil.tasmax.ec126,by="Model")
williamsburg.df <- merge(df,wil.tasmax.ec585,by="Model")

write.csv(williamsburg.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/WilliamsburgAverageMaxTemp.csv")


## NELSONVILLE MAXTEMP ANALYSIS -----
location <- "Nelsonville, OH"

# Nelsonville Historical Average
nel.tasmax.hindcast <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.tasmax.hindcast <- rbind(nel.tasmax.hindcast,vec.to.bind)
}
colnames(nel.tasmax.hindcast) <- hindcastdfcolnames

end_time <- Sys.time()
end_time-start_time



# Nelsonville Midcentury 126 Average
nel.tasmax.mc126 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.tasmax.mc126 <- rbind(nel.tasmax.mc126,vec.to.bind)
}
colnames(nel.tasmax.mc126) <- mc126dfcolnames
nel.tasmax.mc126

end_time <- Sys.time()
end_time-start_time



# Nelsonville Endcentury 126 Average
nel.tasmax.ec126 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.tasmax.ec126 <- rbind(nel.tasmax.ec126,vec.to.bind)
}
colnames(nel.tasmax.ec126) <- ec126dfcolnames
nel.tasmax.ec126

end_time <- Sys.time()
end_time-start_time


# Nelsonville Midcentury 585 Average
nel.tasmax.mc585 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.tasmax.mc585 <- rbind(nel.tasmax.mc585,vec.to.bind)
}
colnames(nel.tasmax.mc585) <- mc585dfcolnames
nel.tasmax.mc585

end_time <- Sys.time()
end_time-start_time



# Nelsonville Endcentury 585 Average
nel.tasmax.ec585 <- data.frame(matrix(ncol=3,nrow=0))
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
  clusterExport(cl, avgmaxtemp.reqobjs)
  
  #polygon and point extractions
  poly.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                               location="Nelsonville",shape="polygon",op=mean))
  point.value <- mean(parSapply(cl=cl,X=filesubset,FUN=extractLocationAttribute,
                                location="Nelsonville",shape="point",op=mean))
  
  #stop parallelize process to save memory
  stopCluster(cl)
  #create vector to bind to temporary data frame
  vec.to.bind <- c(goodmodelnames[c],point.value,poly.value)
  #bind
  nel.tasmax.ec585 <- rbind(nel.tasmax.ec585,vec.to.bind)
}
colnames(nel.tasmax.ec585) <- ec585dfcolnames
nel.tasmax.ec585

end_time <- Sys.time()
end_time-start_time

#merge all dataframes into one
df <- merge(nel.tasmax.hindcast,nel.tasmax.mc126,by="Model")
df <- merge(df,nel.tasmax.mc585,by="Model")
df <- merge(df,nel.tasmax.ec126,by="Model")
nelsonville.df <- merge(df,nel.tasmax.ec585,by="Model")

write.csv(nelsonville.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/NelsonvilleAverageMaxTemp.csv")
