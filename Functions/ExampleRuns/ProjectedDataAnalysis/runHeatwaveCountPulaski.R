## HEATWAVE COUNT Pulaski

## RUN AGAIN WITH NUMBER OF DAYS ABOVE 90 INSTEAD OF THE COUNT THING

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

## HINDCAST LOOP -----
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
                              location="Pulaski")  
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
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/TwoDayHWPulaskihistorical.csv")




## MIDCENTURY SSP126 LOOP -----
hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="ssp126",timeframe="midcentury")
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
                              location="Pulaski")  
  time.max.avg <- mean(year.count.vec)    
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90PulaskiMC126.csv")
# 
write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/TwoDayHWPulaskiMC126.csv")

## ENDCENTURY SSP126 LOOP -----
hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="ssp126",timeframe="endcentury")
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
                              location="Pulaski")  
  time.max.avg <- mean(year.count.vec)    
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90PulaskiEC126.csv")

write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/TwoDayHWPulaskiEC126.csv")

## MIDCENTURY SSP585 LOOP -----
hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="ssp585",timeframe="midcentury")
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
                              location="Pulaski")  
  time.max.avg <- mean(year.count.vec)    
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90PulaskiMC585.csv")
write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/TwoDayHWPulaskiMC585.csv")

## ENDCENTURY SSP585 LOOP -----

hwcount.df <- data.frame(matrix(ncol=2,nrow=length(goodmodelnames)))
colnames(hwcount.df) <- csv.colnames
hwcount.df$model <- goodmodelnames

start_time <- Sys.time()
for (i in 1:length(goodmodelnames)) {
  
  filesubset <- getCorrectFiles(model=goodmodelnames[i],
                                pat="tasmax",ssp="ssp585",timeframe="endcentury")
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
                              location="Pulaski")  
  time.max.avg <- mean(year.count.vec)    
  stopCluster(cl)
  
  hwcount.df$countHeatwaves[i] <- time.max.avg
}
hwcount.df

end_time <- Sys.time()
end_time - start_time

# write.csv(hwcount.df,
#           file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/DaysAbove90PulaskiEC585.csv")
write.csv(hwcount.df,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/TwoDayHWPulaskiEC585.csv")

# ### MAKE BOXPLOT -----
# #setwd to get data
# csv.dir <- "~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/GeneralSummaries/"
# setwd(csv.dir)
# 
# #read in csvs
# pul.hist <- read.csv("DaysAbove90Pulaskihistorical.csv")
# pul.126MC <- read.csv("DaysAbove90PulaskiMC126.csv")
# pul.126EC <- read.csv("DaysAbove90PulaskiEC126.csv")
# pul.585MC <- read.csv("DaysAbove90PulaskiMC585.csv")
# pul.585EC <- read.csv("DaysAbove90PulaskiEC585.csv")
# # 
# # pul.hist <- read.csv("TwoDayHWPulaskihistorical.csv")
# # pul.126MC <- read.csv("TwoDayHWPulaskiMC126.csv")
# # pul.126EC <- read.csv("TwoDayHWPulaskiEC126.csv")
# # pul.585MC <- read.csv("TwoDayHWPulaskiMC585.csv")
# # pul.585EC <- read.csv("TwoDayHWPulaskiEC585.csv")
# 
# pul.rain.all <- data.frame(pul.hist$max5dayrainfall_in.day,
#                            pul.126MC$max5dayrainfall_in.day,
#                            pul.126EC$max5dayrainfall_in.day,
#                            pul.585MC$max5dayrainfall_in.day,
#                            pul.585EC$max5dayrainfall_in.day)
# colnames(pul.rain.all) <- c("Hindcast",
#                             "Mid-Century_ssp126",
#                             "End-Century_ssp126",
#                             "Mid-Century_ssp585",
#                             "End-Century_ssp585")
# 
# # #make a pretty boxplot
# library(ggplot2)
# library(tidyverse)
# library(magrittr)
# library(forcats)
# 
# pul.rain.all.pivlon <- pul.rain.all %>%  
#   pivot_longer(everything(),
#                values_to="TwoDayHeatwaves", names_to="EmissionScenario")
# 
# pul.rain.all.pivlon$EmissionScenario <- factor(pul.rain.all.pivlon$EmissionScenario,
#                                                levels=c("Hindcast",
#                                                         "Mid-Century_ssp126",
#                                                         "End-Century_ssp126",
#                                                         "Mid-Century_ssp585",
#                                                         "End-Century_ssp585"))   
# 
# pul.rain.all.pivlon$MaxRainfall.in <- pul.rain.all.pivlon$MaxRainfall
# 
# bp <- ggplot(pul.rain.all.pivlon) +
#   geom_boxplot(aes(x=EmissionScenario, y=MaxRainfall.in),na.rm=TRUE) +
#   ggtitle("Number of Two Day Heatwaes CMIP 6 models", subtitle="Pulaski, VA (point extraction)") +
#   xlab("Timeframe and Emission Scenario") + 
#   ylab("Number of Two Day Heatwaves")
# bp
# 
# ggsave("~/2023/NEX-GDDP/Code_Larsson/Analysis/summary/Boxplots/TwoDayHeatwaves/TwoDayHWBoxplot_Pulaski.png",
#        plot=bp,
#        width=7,height=4,units="in")
# 
