normd <- function(d) {
  
  
  # normalise distribution
  
  sum <- (d$x[2]-d$x[1])*sum(d$y)
  
  d$y <- d$y/sum 
  
  d

}