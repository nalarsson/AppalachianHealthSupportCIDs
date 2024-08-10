## SOURCE FUNCTION -----
#linux
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/TwoDayHeatwaveCount.R")


## VARIABLES FOR ALL LOOPS -----
#project path
setwd(project.loc)
#precip variable

csv.colnames <- c("model","countHeatwaves")

hw.reqobjs <- c("hwcount.df","filesubset","loc.csv",
                "getCountAnnualTwoDayHeatwave",
                "celsius_to_fahrenheit")
n.cores <- 15

## PARKERSBURG -----
hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[i]))
  
  
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, hw.reqobjs)
  
  year.count.vec <- parSapply(cl=cl,X=filesubset,FUN=getCountAnnualTwoDayHeatwave,
                              location="Parkersburg")  
  time.max.avg <- mean(year.count.vec)  
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90Pulaskihistorical.csv")

write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/Parkersburg_2DayHeatwavesHindcast.csv")

## CHARLESTON -----
hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[i]))
  
  
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, hw.reqobjs)
  
  year.count.vec <- parSapply(cl=cl,X=filesubset,FUN=getCountAnnualTwoDayHeatwave,
                              location="Charleston")  
  time.max.avg <- mean(year.count.vec)  
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90Pulaskihistorical.csv")

write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/Charleston_2DayHeatwavesHindcast.csv")

## BLUESTONE LAKE -----
hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="hindcast")
  filesubset <- filesubset$x
  setwd(paste0(project.loc,goodmodelnames[i]))
  
  
  cl <- makeCluster(n.cores)
  clusterEvalQ(cl, {
    pacman::p_load("ncdf4","raster",#"rdgal","forecats",
                   "rgeos","utils", "stringr",
                   "stats","sf","sp","parallel","ggplot2",
                   "tidyverse","magrittr","lubridate","tidyr")
  })
  clusterExport(cl, hw.reqobjs)
  
  year.count.vec <- parSapply(cl=cl,X=filesubset,FUN=getCountAnnualTwoDayHeatwave,
                              location="BluestoneLake")  
  time.max.avg <- mean(year.count.vec)  
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90Pulaskihistorical.csv")

write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ModelOutputs/BluestoneLake_2DayHeatwavesHindcast.csv")
