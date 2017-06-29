supply_power <- function(surplus,storage,hydro,capacity) {
  
  # surplus : supply - demand at time
  # storage : energy store
  # hydro : last resort energy source (hydro dams )
  
  if (surplus >= 0) {
    storage <- storage + surplus
    if (storage > capacity ) { storage <- capacity }
  }
  else { 
    if (storage > (-surplus)) { 
      storage <- storage + surplus
      surplus <- 0
    }
    else {
      surplus <- surplus + storage
      storage <- 0
      hydro <- -surplus
      surplus <- 0
    }
  }
  
  t = list(Storage=storage,Hydro=hydro)
  
  t

  
}