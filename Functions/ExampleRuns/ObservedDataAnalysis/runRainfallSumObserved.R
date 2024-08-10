source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/FiveDayRainfallTotalCSV.R")


## VARIABLES FOR ALL LOOPS -----
#project path
observed.path <- "~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ObservedData/"
setwd(observed.path)

## PARKERSBURG -----
setwd(paste0(observed.path,"ParkersburgWV/"))
pb.files <- list.files(paste0(observed.path,"ParkersburgWV/"))

year.max.vec <- sapply(X=pb.files,FUN=getCSVMaxAnnualFiveDayTotalPrecipitation)  
year.max.vec <- unlist(year.max.vec) #only on Parkersburg because there were NA values

write.csv(year.max.vec,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ObservedData/Parkersburg_5DayRainfallObserved.csv")


## CHARLESTON -----
setwd(paste0(observed.path,"CharlestonWV/"))
ch.files <- list.files(paste0(observed.path,"CharlestonWV/"))

year.max.vec <- sapply(X=ch.files,FUN=getCSVMaxAnnualFiveDayTotalPrecipitation)  
write.csv(year.max.vec,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ObservedData/Charleston_5DayRainfallObserved.csv")

## BLUESTONE LAKE -----
setwd(paste0(observed.path,"BluestoneLakeWV/"))
bl.files <- list.files(paste0(observed.path,"BluestoneLakeWV/"))

year.max.vec <- sapply(X=bl.files,FUN=getCSVMaxAnnualFiveDayTotalPrecipitation)  

write.csv(year.max.vec,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/hindcastData/ObservedData/BluestoneLake_5DayRainfallObserved.csv")

# 
# ## MAKE BOXPLOTS
# pb.fiveday <- read.csv()
# ch.fiveday <- read.csv()
# bl.fiveday <- read.csv()
# 
# all.fiveday <- data.frame()
# 
# bp <- ggplot(pul.rain.all.pivlon) +
#   geom_boxplot(aes(x=EmissionScenario, y=MaxRainfall.in),na.rm=TRUE) +
#   ggtitle("Maximum Five Day Rainfall Events over CMIP 6 models", subtitle="Pulaski, VA (point extraction)") +
#   xlab("Timeframe and Emission Scenario") + 
#   ylab("Maximum of Average 5 Day \n Rainfall Event (in.)")
# bp