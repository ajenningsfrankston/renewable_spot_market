library(distr)

load(file="../rdata/sl_015590_2016_02_solar_densities.rd") 

sd <- solar_densities[[11]]

x <- sd$x

px <- approxfun(sd$x,sd$y,yleft=0,yright=0,rule=2)


dist <-AbscontDistribution(d=px)  # signature for a dist with pdf ~ p
rdist <- r(dist)                 # function to create random variates from p

set.seed(1)                      # for reproduceable example
X <- rdist(1000)                 # sample from X ~ p
x <- seq(0,7.5, .01)
hist(X, freq=F, breaks=50, xlim=c(0,7.5))

lines(x,px(x),lty=2, col="red")