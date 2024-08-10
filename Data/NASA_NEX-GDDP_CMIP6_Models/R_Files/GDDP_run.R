##
##
## Code to run GDDP download for given model id(s)
##

## Specify working directory and initialize files
setwd(filepathbase)
out <- "0_downloadProgress.txt"
error.track <- "0_ErrorFiles.txt"
cat("Files that generated errors:", "\n", file=error.track, append=FALSE, sep='')
cat("================================", "\n", file=error.track, append=TRUE, sep='')


## Need to specify model IDs manually before sourcing

test.ids <-c()
test.names <- c()
test.links <-c()

## Set up files and links
#if (exists("models.to.run")){
for (m in 1:length(models.to.run)){
  test.ids <- c(test.ids,grep(modelnames[models.to.run[m]], filenames, value=FALSE) )
}
test.names <- filenames[test.ids]
test.links <- filelinks[test.ids]

## Run download/crop
start_time <- Sys.time()

#parallelize

#fill in here
req.objects <- c("filenames","filelinks","filepathbase","NCfile_check_mAtl")

n.cores <- 4 #detectCores() #increase slowly over time. does not work at full time

cl <- makeCluster(n.cores)

#fill in here
clusterEvalQ(cl, {
  library(ncdf4)
  library(raster)
  library(rgdal)
  library(httr)
  library(lubridate)
  library(parallel)
})
clusterExport(cl, req.objects)

parSapply(cl, test.ids, FUN=get_files)

stopCluster(cl)

end_time <- Sys.time()
time.dif <- end_time-start_time
time.dif
cat(paste(time.dif), file="0.totaltime.txt")
#}
