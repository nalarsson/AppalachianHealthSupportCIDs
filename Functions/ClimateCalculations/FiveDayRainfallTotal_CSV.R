#get setup data if not already there
source("~/2023/NEX-GDDP/Code_Larsson/Analysis/functions/analysisSetup.R")

getCSVMaxAnnualFiveDayTotalPrecipitation <- function(file) {

  csv <- read.csv(file)
  
  if (nrow(csv)!= 0) {
    precip.vec <- csv$PRCP
    precip.vec <- precip.vec[!is.na(precip.vec)]
    #vector of data
    loc.df <- data.frame(day=1:length(precip.vec),
                       value=NA)
    loc.df$value=precip.vec

    fivedaysum <- c()
    for (i in 5:length(precip.vec)) {
      fiveday <- loc.df$value[(i-4):i]
      s <- sum(fiveday,na.rm=TRUE)
      fivedaysum <- c(fivedaysum,s)
    }

    max_fivedaysum <- max(fivedaysum)
    return(max_fivedaysum)
  }
}





