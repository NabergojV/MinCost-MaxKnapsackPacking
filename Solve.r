#### Trditev 6:

#Optimalna rešitev in optimalna vrednost rešitve MCMKP lahko izračunamo v $O(nC)$ času s prostorsko zahtevnostjo $O(n+C)$.

#Dodana pa sta algoritma, ki poiščeta optimalno rešitev:
  
Resi <- function(N, C){
  z_st <- c()
  X_st <- c()
  z_st[1] <- 0
  for(k in c(2:C+1)){
    z_st[k] <- Inf
    if(length(N$w)==1){
      X_st[k] <- c()
    }
  }
  if(length(N$w)==1){
    X_st[1] <- c()
    X_st[N$w[1]+1] <- N
  }
  for(i in c(length(N$w):1)){
    if((C)>=N$w[i]){
      for(k in c((C+1):(N$w[i]+1))){
        z_st[k] <- min(c(z_st[k], z_st[k-N$w[i]] + N$p[i]))
      }
    }
  }
  if(length(N$w)==1){
    result <- list(X_st = X_st, z_st = z_st)
    return(result)
  }
  result <- c(z_st = z_st)
  return(result)
}

Rekurziven_DP <- function(N, C, z_st){
  N_st <- c()
  C_st <- 0
  X_st <- c()
  particija <- trunc(length(N$w)/2)
  N_1 <- N[1:particija,]
  N_2 <- N[(particija+1):nrow(N$w),]
  z_st_1 <- Resi(N_1, C)
  z_st_2 <- Resi(N_2, C)
  if(length(N_1$w) != 1 && length(N_2$w) != 1){
    z <- sapply(c(1:(C+1)), function(ind){
      z_st_1[ind] + z_st_2[(C+1)-ind]
    })
    C_1 <- which(z == z_st) %>% head(1)
    C_1 <- C_1 - 1
    C_2 <- C - C_1
  }
  if(length(N_1$w) == 1 && length(N_2$w) != 1){
    z <- sapply(c(1:(C+1)), function(ind){
      z_st_1[2][ind] + z_st_2[(C+1)-ind]
    })
    C_1 <- which(z == z_st) %>% head(1)
    C_1 <- C_1 - 1
    C_2 <- C - C_1
  }
  if(length(N_1$w) != 1 && length(N_2$w) == 1){
    z <- sapply(c(1:(C+1)), function(ind){
      z_st_1[ind] + z_st_2[2][(C+1)-ind]
    })
    C_1 <- which(z == z_st) %>% head(1)
    C_1 <- C_1 - 1
    C_2 <- C - C_1
  }
  if(length(N_1$w) == 1 && length(N_2$w) == 1){
    z <- sapply(c(1:(C+1)), function(ind){
      z_st_1[2][ind] + z_st_2[2][(C+1)-ind]
    })
    C_1 <- which(z == z_st) %>% head(1)
    C_1 <- C_1 - 1
    C_2 <- C - C_1
  }
  if(length(N_1$w) == 1){
    # tukaj naletim na težavo, saj ne vem kako naj bi izgledal Merge...
  }
}
