csvLocationAttribute <- function(file,att="PRCP",
                                   op=mean) {
    #read in file
    csv <- read.csv(file)
  
    #get column of interest (coi)
    if(att == "PRCP") {
      coi <- csv$PRCP
    } else {
      coi <- csv$TMAX
    }
  
    #perform operation to get single value
    extracted.value <- op(coi)
    #return single value
    return(extracted.value)
} 




