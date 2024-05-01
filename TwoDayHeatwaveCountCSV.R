#get setup data if not already there
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/analysisSetup.R")

getCSVCountAnnualTwoDayHeatwave <- function(file) {
  #read in file
  csv <- read.csv(file)
  print(file)
  
  if (nrow(csv)!= 0) {
    temp.vec <- csv$TMAX
    temp.vec <- temp.vec[!is.na(temp.vec)]
    
    if (length(temp.vec!=0)) {
    #vector of data
    loc.df <- data.frame(day=1:length(temp.vec),
                         value=NA)
    loc.df$value=temp.vec
    
    count_twodayheatwaves <- 0
    for (i in 2:nrow(loc.df)) {
        if(loc.df$value[i-1]>=90 & loc.df$value[i]>=90) {
        count_twodayheatwaves <- count_twodayheatwaves + 1
      }
    }
    } else {
      count_twodayheatwaves <- NA
    }
  } else {
    count_twodayheatwaves <- NA
  }
  return(count_twodayheatwaves)
}





