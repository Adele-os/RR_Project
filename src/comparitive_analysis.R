library(dplyr)
library(RVAideMemoire) # library for Mood's median test
library(rcompanion)    # library for pairwise Mood's median tests

# Import data 
data1 <-  read.csv("in/survey_data.csv", header = T)
head(data1)
dim(data1)


# Bootstrapping -----------------------------------------------------------

# the number of resampling for Bootstrapping 
n <- 50

# size of each sample
N <- nrow(data1)*4

# resampling process (Bootstrapping)
## first sample
data.boot2 <- data1[sample(1:nrow(data1), N, rep=T),]

## next samples
for(i in 1:(n-1)){
  data.boot2 <- rbind(data.boot2, data1[sample(1:nrow(data1), N, rep=T),])
}

data.boot2$age[data.boot2$age == 4] <- 3


# sex comparison (2 samples test) -----------------------------------------

# a function for running pairwise Mood's test for all n Bootstrap samples 
# It takes the dataframe, name of variable (column) to compare
# and name of column which includes the group each case assigned to. 

bootstrap.p <- function(df, col.name, col.group, n=50){
  
  # create an empty dataframe for saving the results of each loop in one row
  result  <- data.frame(0, 0, 'Z statistics'= 0, 'p' = 0)
  
  # a for-loop for each sample
  for (i in 1:n) {
    
    # extract ith sample from whole dataset
    y <- df[((i-1)*N+1):(N*i), col.name] # assign our dependent variable to y
    x <- df[((i-1)*N+1):(N*i), col.group] # assign our independent variable to y
    
    # assign the result of ith sample to ith row of "result"
    result[i,] <- c(
      (aggregate(y, list(x), median, na.rm=T))$x, #calculate median for each group
      mood.test(y ~ x)$statistic,                 # extract test statistic of Mood's test
      mood.test(y ~ x)$p                          # extract p-value
      )
  }
  
  # return a vector contains mean of each column of "result"
  return(apply(result,2,mean))
}

# using our "bootstrap.p" function for camparing males and females:

## Confirmation Bias
p.b_confirmation.sex <- bootstrap.p(data.boot2, 'b_confirmation', 'sex')

## Loss aversion
p.b_loss.sex <- bootstrap.p(data.boot2, 'b_loss', 'sex')

## Gambler's fallacy
p.b_gambler.sex <- bootstrap.p(data.boot2, 'b_gambler', 'sex')

## Availability Cascade
p.b_availability.sex <- bootstrap.p(data.boot2, 'b_availability', 'sex')

## Hot hand's fallacy
p.b_hot_hand.sex <- bootstrap.p(data.boot2, 'b_hot_hand', 'sex')

## Bandwagon effect
p.b_bandwagon.sex <- bootstrap.p(data.boot2, 'b_bandwagon', 'sex')

## Dunning-Kruger effect
p.b_dunning.sex <- bootstrap.p(data.boot2, 'b_dunning', 'sex')


# put all the results in a table
table1 <- rbind(
  round(p.b_confirmation.sex, 3),
  round(p.b_loss.sex, 3),
  round(p.b_gambler.sex, 3),
  round(p.b_availability.sex, 3),
  round(p.b_hot_hand.sex, 3),
  round(p.b_bandwagon.sex, 3),
  round(p.b_dunning.sex, 3)
  ) %>% 
  as.data.frame() %>%         # convert matrix to dataframe
  mutate(                     # add a column including the name of each row
    Fallacies = c("Confirmation", "Loss aversion", "Gambler's", "Availability",
                  "Hot hand's", "Bandwagon", "Dunning-Kruger")
    )

# move the column of names from last column to first 
table1 <- table1[,c(5,1:4)]

# add the names of each column
names(table1) <- c("Fallacy", "Female", "Male", "Test-statistics", "p-Value")

# print table1
table1
