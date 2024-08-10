## SOURCE FUNCTION -----
#linux
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/FiveDayRainfallTotal.R")


## VARIABLES FOR ALL LOOPS -----
#project path
setwd(project.loc)
#precip variable

csv.colnames <- c("model","max5dayrainfall_in.day")

fiveday.reqobjs <- c("maxrain.df","filesubset","loc.csv",
                     "getMaxAnnualFiveDayTotalPrecipitation")
n.cores <- 10

## HINDCAST LOOP -----
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
                         location="Williamsburg")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/5DayRainfallWilliamsburghistorical.csv")

end_time <- Sys.time()
end_time - start_time


## MIDCENTURY SSP126 LOOP -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="ssp126",timeframe="midcentury")
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
                            location="Williamsburg")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)  
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/5DayRainfallWilliamsburgMC126.csv")

end_time <- Sys.time()
end_time - start_time

## ENDCENTURY SSP126 LOOP -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="ssp126",timeframe="endcentury")
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
                            location="Williamsburg")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)  
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/5DayRainfallWilliamsburgEC126.csv")

end_time <- Sys.time()
end_time - start_time

## MIDCENTURY SSP585 LOOP -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="ssp585",timeframe="midcentury")
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
                            location="Williamsburg")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)  
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/5DayRainfallWilliamsburgMC585.csv")

end_time <- Sys.time()
end_time - start_time


## ENDCENTURY SSP585 LOOP -----
maxrain.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(maxrain.df) <- csv.colnames
maxrain.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="pr",ssp="ssp585",timeframe="endcentury")
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
                         location="Williamsburg")  
  time.max.avg <- mean(year.max.vec)  
  stopCluster(cl)  
  
  maxrain.df$max5dayrainfall_in.day[i] <- time.max.avg
}

write.csv(maxrain.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/5DayRainfallWilliamsburgEC585.csv")

end_time <- Sys.time()
end_time - start_time

