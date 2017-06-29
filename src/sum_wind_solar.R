#
# sum all the densities ...
#
library(gtools)
library(ggplot2)
library(readr)

source("convolution.R")
source("normd.R")

all_files <- list.files(path="../rdata")
solar_files <- all_files[which(startsWith(all_files,"sl_"))]
solar_files <- mixedsort(solar_files)


wind_files <- all_files[which(startsWith(all_files,"wd_"))]
wind_files <- mixedsort(wind_files)

solar_files <- paste0("../rdata/",solar_files)
wind_files <- paste0("../rdata/",wind_files)

# sum wind densities

load(wind_files[1])

sum_wind_density <- wind_density

for (wind_file in wind_files[-1]) {
  
  load(wind_file)
  d <- convolution(sum_wind_density,wind_density)
  pd = data.frame(x=d$z,y=d$dz)
  pd <- normd(pd)
  
  sum_wind_density <- pd
  
}

title="sum wind density"

#p <- ggplot(sum_wind_density,aes(x=x,y=y)) + geom_line() + ggtitle(title)
#print(p)


# solar density hrs 7-22 zero outside those times

load(solar_files[1])
solar_densities_sum = solar_densities

for (solar_file in solar_files[-1]) {
  
  load(solar_file)
  
  for (time in 7:22) {

    d <- convolution(solar_densities_sum[[time]],solar_densities[[time]])
    pd = data.frame(x=d$z,y=d$dz)
    pd <- normd(pd)
    
    solar_densities_sum[[time]] <- pd
    
  }
  
}

# sum solar and wind together

sum_densities = list()



for (time in 1:24) {
  
  if (time >= 7 && time <= 22) { 
    d <- convolution(solar_densities_sum[[time]],sum_wind_density)
    
    pd = data.frame(x=d$z,y=d$dz)
    pd <- normd(pd)
    
    sum_densities[[time]] <- pd
    
  } else {
    sum_densities[[time]] <- sum_wind_density
  }
  
}



save(sum_densities,file="../rdata/list_sum_densities.rd")

for (time in 1:24) {
  
  title = paste("Time of day ",time,":00",sep="")
  
  p <- ggplot(sum_densities[[time]],aes(x=x,y=y)) + geom_line() + ggtitle(title)
  print(p)
  
  Sys.sleep(1)
  
}

