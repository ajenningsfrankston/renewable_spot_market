library(lubridate)
library(dplyr)

aemo_data = read.csv("../data/PRICE_AND_DEMAND_201702_VIC1.csv")

t <- aemo_data[,2]
d <- aemo_data[,3]
day_demand = data.frame(hour(t),minute(t),d)
names(day_demand) <- c("hour","minute","demand")
day_hour_demand <- filter(day_demand,minute == 0)


mean_hour_demand = data.frame(1:23,0)
names(mean_hour_demand) <- c("hour","demand")

for (hr in 1:23){ 
  v <- filter(day_hour_demand,hour==hr)
  m <- mean(v$demand)
  mean_hour_demand$demand[hr] <- m/1000.0
}

save(mean_hour_demand,file="../rdata/feb_2017_demand.rd")
