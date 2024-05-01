### FUNCTION ----
makeLocationVector <- function(name,state,lon,lat,cfp,sfp) {
  vec <- c(name,state,lon,lat,cfp,sfp)
  return(vec)
}


### THREE PRIMARY LOCATIONS ----
## VIRGINIA
# Pulaski
pul.name <- "Pulaski"
pul.state <- "VA"
pul.lon <- -80.769043
pul.lat <- 37.059166
pul.countyFP <- 155
pul.stateFP <- 51

pul.vec <- makeLocationVector(pul.name,pul.state,pul.lon,pul.lat,pul.countyFP,pul.stateFP)


## WEST VIRGINIA
# Williamsburg
wil.name <- "Williamsburg"
wil.state <- "WV"
wil.lon <- -80.491970
wil.lat <- 37.969785
wil.countyFP <- 025
wil.stateFP <- 54

wil.vec <- makeLocationVector(wil.name,wil.state,wil.lon,wil.lat,wil.countyFP,wil.stateFP)  


## OHIO
# Nelsonville
nel.name <- "Nelsonville"
nel.state <- "OH"
nel.lon <- -82.229056
nel.lat <- 39.456255
nel.countyFP <- 009
nel.stateFP <- 39

nel.vec <- makeLocationVector(nel.name,nel.state,nel.lon,nel.lat,nel.countyFP,nel.stateFP)  

### WEATHER STATIONS ----
## WEST VIRGINIA
# Parkersburg
pb.name <- "Parkersburg"
pb.state <- "WV"
pb.lon <- -81.44379
pb.lat <- 39.33948
pb.countyFP <- 107
pb.stateFP <- 54

pb.vec <- makeLocationVector(pb.name,pb.state,pb.lon,pb.lat,pb.countyFP,pb.stateFP)

# Charleston
ch.name <- "Charleston"
ch.state <- "WV"
ch.lon <- -81.59112
ch.lat <- 38.3795
ch.countyFP <- 39
ch.stateFP <- 54

ch.vec <- makeLocationVector(ch.name,ch.state,ch.lon,ch.lat,ch.countyFP,ch.stateFP)

# Bluestone Lake
bl.name <- "BluestoneLake"
bl.state <- "WV"
bl.lon <- -80.88278
bl.lat <- 37.64199
bl.countyFP <- 89
bl.stateFP <- 54

bl.vec <- makeLocationVector(bl.name,bl.state,bl.lon,bl.lat,bl.countyFP,bl.stateFP)


## MAKE DATA FRAME ----
app.locations <- rbind(pul.vec,wil.vec,nel.vec,pb.vec,ch.vec,bl.vec)
rownames(app.locations) <- c(pul.name,wil.name,nel.name,pb.name,ch.name,bl.name)
colnames(app.locations) <- c("Location","State","Longitude","Latitude","CountyFP","StateFP")

write.csv(app.locations,
          file="~/2023/NEX-GDDP/Code_Larsson/Analysis/LocationData_2024.csv")






## OTHER LOCATIONS ----
# 
# #blacksburg
# bbVA.name="Blacksburg"
# bbVA.state="VA"
# bbVA.lon=-80.413939
# bbVA.lat=37.229573
# makeLocationVector(bbVA.name,bbVA.state,bbVA.lon,bbVA.lat)
# 
# #lee county va
# leeVA.name="LeeCounty"
# leeVA.state="VA"
# leeVA.lon=-83.11302
# leeVA.lat=36.69065
# 
# 
# 
# #wise county va
# wiseVA.name="WiseCounty"
# wiseVA.state="VA"
# wiseVA.lon=-82.606352
# wiseVA.lat=37.128947