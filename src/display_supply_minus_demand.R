library(ggplot2)

load("../rdata/list_sum_densities.rd")
load("../rdata/feb_2017_demand.rd")

for (time in 1:23) {
  
  title = paste("Supply - Demand Time of day ",time,":00",sep="")
  
  sum_densities[[time]]$x <- sum_densities[[time]]$x - mean_hour_demand[time,]$demand
  
  p <- ggplot(sum_densities[[time]],aes(x=x,y=y)) + geom_line() + ggtitle(title)
  print(p)
  
  Sys.sleep(1)
  
}