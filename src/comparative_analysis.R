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
n <- 100

# size of each sample
N <- 100

# resampling process (Bootstrapping)
## first sample
set.seed(6)
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


# pairwise Mood's median tests across groups
post.hoc <- pairwiseMedianTest(b_loss ~ age, data=data.boot2[1:N,],  exact  = T,
                               digits = 3, method = "bonferroni")

# letter display for lists of comparisons
cldList(comparison = post.hoc$Comparison,
        p.value    = post.hoc$p.adjust, threshold  = 0.05)


# experience comparison ---------------------------------------------------

## Confirmation Bias
b_confirmation.experience <- bootstrap.p(data.boot2, 'b_confirmation', 'experience')

## Loss aversion
b_loss.experience <- bootstrap.p(data.boot2, 'b_loss', 'experience')

## Gambler's fallacy
b_gambler.experience <- bootstrap.p(data.boot2, 'b_gambler', 'experience')

## Availability Cascade
b_availability.experience <- bootstrap.p(data.boot2, 'b_availability', 'experience')

## Hot hand's fallacy
b_hot_hand.experience <- bootstrap.p(data.boot2, 'b_hot_hand', 'experience')

## Bandwagon effect
b_bandwagon.experience <- bootstrap.p(data.boot2, 'b_bandwagon', 'experience')

## Dunning-Kruger effect
b_dunning.experience <- bootstrap.p(data.boot2, 'b_dunning', 'experience')

# put all the results in a table
table3 <- rbind(
  round(b_confirmation.experience, 3),
  round(b_loss.experience, 3),
  round(b_gambler.experience, 3),
  round(b_availability.experience, 3),
  round(b_hot_hand.experience, 3),
  round(b_bandwagon.experience, 3),
  round(b_dunning.experience, 3)
) %>% 
  as.data.frame() %>% 
  mutate(
    Fallacies = c("Confirmation", "Loss aversion", "Gambler's", "Availability",
                  "Hot hand's", "Bandwagon", "Dunning-Kruger")
  )

# move the column of names from last column to first 
table3 <- table3[,c(6,1:5)]

names(table3) <- c("Fallacy", "<3", "3-5", "5-10", ">10", "p-Value")

table3

# pairwise Mood's median tests across groups
post.hoc2 <- pairwiseMedianTest(b_loss ~ age, data=data.boot2[1:N,],  exact  = T,
                                digits = 3, method = "bonferroni")

# letter display for lists of comparisons
cldList(comparison = post.hoc2$Comparison,
        p.value    = post.hoc2$p.adjust, threshold  = 0.05) 


# adding p-values of the previous research to our tables

table1 <- table1 %>% mutate("previous p-Value" = c(0.364, 0.341, 0.000, 0.000, 0.440, 0.329, 0.054))
table2 <- table2 %>% mutate("previous p-Value" = c(0.001, 0.000, 0.170, 0.485, 0.000, 0.163, 0.283))
table3 <- table3 %>% mutate("previous p-Value" = c(0.201, 0.025, 0.087, 0.047, 0.072, 0.020, 0.044))


# rmd ---------------------------------------------------------------------

# In order to avoid repeating previous codes in rmd file, 
# final results have been defined as parameters in rmarkdown file.
# use render() function for rendering rmd file from src folder 
# Here, the parameters are table1, table2 and table3 which 
# are the results of sex, age and experience respectively.

rmarkdown::render(
  input = "src/presentation.Rmd",
  output_file = "presentation.html",
  params = list(
    table1 = table1,
    table2 = table2,
    table3 = table3
  ),
  output_dir   = "out",
  encoding     = 'UTF-8'
)

