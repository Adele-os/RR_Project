library(dplyr)
library(RVAideMemoire) # library for Mood's median test
library(rcompanion)    # library for pairwise Mood's median tests
library(types)         # library for type annotation in functions

source("src/func.R")   # read our function from file func.R

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


# sex comparison -----------------------------------------

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
table1 <- table1[,c(4,1:3)]

# add the names of each column
names(table1) <- c("Fallacy", "Female", "Male", "p-Value")

# print table1
table1


# age comparison ----------------------------------------------------------

## Confirmation Bias
b_confirmation.age <- bootstrap.p(data.boot2, 'b_confirmation', 'age')

## Loss aversion
b_loss.age <- bootstrap.p(data.boot2, 'b_loss', 'age')

## Gambler's fallacy
b_gambler.age <- bootstrap.p(data.boot2, 'b_gambler', 'age')

## Availability Cascade
b_availability.age <- bootstrap.p(data.boot2, 'b_availability', 'age')

## Hot hand's fallacy
b_hot_hand.age <- bootstrap.p(data.boot2, 'b_hot_hand', 'age')

## Bandwagon effect
b_bandwagon.age <- bootstrap.p(data.boot2, 'b_bandwagon', 'age')

## Dunning-Kruger effect
b_dunning.age <- bootstrap.p(data.boot2, 'b_dunning', 'age')

# put all the results in a table
table2 <- rbind(
  round(b_confirmation.age, 3),
  round(b_loss.age, 3),
  round(b_gambler.age, 3),
  round(b_availability.age, 3),
  round(b_hot_hand.age, 3),
  round(b_bandwagon.age, 3),
  round(b_dunning.age, 3)
) %>% 
  as.data.frame() %>%          # convert matrix to dataframe
  mutate(                      # add a column including the name of each row
    Fallacies <- c("Confirmation", "Loss aversion", "Gambler's", "Availability",
                   "Hot hand's", "Bandwagon", "Dunning-Kruger")
  )

# move the column of names from last column to first 
table2 <- table2[,c(5,1:4)]

# add names of each column
names(table2) <- c("Fallacy", "<35", "36-45", ">45", "p-Value")

table2



