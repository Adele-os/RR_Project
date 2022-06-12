library(dplyr)
library(RVAideMemoire) # library for Mood's median test
library(rcompanion)    # library for pairwise Mood's median tests
library(types)         # library for type annotation in functions

bootstrap.p <- function(df, 
                        col.name = ? character,
                        col.group = ? character, 
                        n = 50 ? integer){
  
  # create an empty dataframe for saving the results of each loop in one row
  a <- nlevels(as.factor(df[col.group] %>% pull()))
  result = data.frame(rbind(rep(0,a)), 'p' = 0)
  
  # for-loop for each sample
  for (i in 1:n) {
    
    # extract ith sample from whole dataset
    y <- df[((i-1)*N+1):(N*i), col.name]
    x <- df[((i-1)*N+1):(N*i), col.group]
    
    # assign the result of ith sample to ith row of "result"
    result[i,] <- c(
      (aggregate(y, list(x), mean, na.rm=T))$x, 
      ifelse(a==2,
             mood.test(y ~ x)$p,           
             mood.medtest(y ~ x)$p.value   
             )
      )
  }
  
  # return a vector contains mean of each column of "result"
  return(apply(result,2,mean))
}