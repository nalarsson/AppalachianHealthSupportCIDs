source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/FiveDayRainfallTotal.R")


## VARIABLES FOR ALL LOOPS -----
#project path
setwd(project.loc)
#precip variable

csv.colnames <- c("model","max5dayrainfall_in.day")

fiveday.reqobjs <- c("maxrain.df","filesubset","loc.csv",
                     "getMaxAnnualFiveDayTotalPrecipitation")
n.cores <- 10


## PARKERSBURG -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[i]))
  
  
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, fiveday.reqobjs)
  
  year.max.vec <- parSapply(cl=cl,X=filesubset,FUN=getMaxAnnualFiveDayTotalPrecipitation,
                            location="Parkersburg")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/Parkersburg_5DayRainfallHindcast.csv")

end_time <- Sys.time()
end_time - start_time


## CHARLESTON -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[i]))
  
  
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, fiveday.reqobjs)
  
  year.max.vec <- parSapply(cl=cl,X=filesubset,FUN=getMaxAnnualFiveDayTotalPrecipitation,
                            location="Charleston")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/Charleston_5DayRainfallHindcast.csv")

end_time <- Sys.time()
end_time - start_time


## BLUESTONE LAKE -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[i]))
  
  
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, fiveday.reqobjs)
  
  year.max.vec <- parSapply(cl=cl,X=filesubset,FUN=getMaxAnnualFiveDayTotalPrecipitation,
                            location="BluestoneLake")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/BluestoneLake_5DayRainfallHindcast.csv")

end_time <- Sys.time()
end_time - start_time