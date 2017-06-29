convolution <- function(dx,dy) {
  #
  # convolution of x and y (distributions) to produce new distribution, z
  #
  
  x <- dx$x
  y <- dy$x
  
  px <- approxfun(dx$x,dx$y,yleft=0,yright=0,rule=2)
  py <- approxfun(dy$x,dy$y,yleft=0,yright=0,rule=2)

  
  z_min <- min(x+y)
  z_max <- max(x+y)
  z <- seq(1,512)
  z <- z_min + z*(z_max-z_min)/512
  
  pz <- function(z) integrate(function(x,z) py(z-x)*px(x),-Inf,Inf,z,stop.on.error = FALSE)$value
  pz <- Vectorize(pz)
  
  dz <- pz(z)
  
  data.frame(z,dz)
}