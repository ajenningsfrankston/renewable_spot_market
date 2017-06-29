library(ggplot2)
library(distr)

source("supply_power.R")

load("../rdata/list_sum_densities.rd")
load("../rdata/feb_2017_demand.rd")

surplus = matrix(nrow=24,ncol=1000)
hydro = matrix(nrow=24,ncol=1000,0)
storage = matrix(nrow=24,ncol=1000,0)

storage_capacity = 1   #1GwHr of storage capacity

mean_supply = vector(length=24)

for (time in 1:23) {
  
  sum_densities[[time]]$x <- sum_densities[[time]]$x - mean_hour_demand[time,]$demand
  
  sd <- sum_densities[[time]]
  px <- approxfun(sd$x,sd$y,yleft=0,yright=0,method="linear",rule=2)
  
  dist <-AbscontDistribution(d=px)  
  rdist <- r(dist)                 
  
  set.seed(1)                      # for reproduceable example
  X <- rdist(1000)                 # sample from X ~ p
  
  mean_supply[time] <- mean(X)

  surplus[time,] <- X
  
}

for (hr in 2:23) { 
  
  t <- mapply(supply_power,surplus[hr,],storage[hr-1,],hydro[hr-1,],SIMPLIFY=FALSE,storage_capacity)
  
  storage[hr,] <- unlist(lapply(t,function(x) x$Storage))
  hydro[hr,] <- unlist(lapply(t,function(x) x$Hydro))
  
  sdr <- mean_supply[hr]/mean_hour_demand[hr,]$demand
  sdrs <- sprintf("%1.2f",sdr)
  tsrs <- sprintf("%1.1f",storage_capacity)
  header <- paste0(tsrs,"GwHr mean supply/demand ",sdrs)
  
  hist(storage[hr,],main= paste0(header,"  Storage ",toString(hr)), freq=F,  xlim=c(0,max(storage[hr,])))
  
  Sys.sleep(1)
  
  hist(hydro[hr,],main= paste0(header,"  Hydro ",toString(hr)), freq=F, xlim=c(0,max(hydro[hr,])))
  
  Sys.sleep(1)
  
  }

save(storage,file="../rdata/hydro.rd")
save(hydro,file="../rdata/storage.rd")


