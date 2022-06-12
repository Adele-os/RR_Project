library(dplyr)
library(data.table)
library(RVAideMemoire) 
library(rcompanion) 

data1 = read.csv("survey_data.csv", header = T)
head(data1)
dim(data1)

data2 = data.table(data1)
data2[,.(mean(b_confirmation)),.(experience)]

n=50
N = nrow(data1)*4

data.boot2 = data1[sample(1:nrow(data1), N, rep=T),]
dim(data.boot2)

for(i in 1:49){
  data.boot2 = rbind(data.boot2, data1[sample(1:nrow(data1), N, rep=T),])
}


data.boot2$age[data.boot2$age == 4] = 3

############### 2 samples #################################

bootstrap.p <- function(df, col.name, col.group){
  result = data.frame(0, 0, 'Z statistics'= 0, 'p' = 0)
  for (i in 1:n) {
    y = df[((i-1)*N+1):(N*i), col.name]
    x = df[((i-1)*N+1):(N*i), col.group]
    result[i,] = c((aggregate(y, list(x), median, na.rm=T))$x,
                   mood.test(y ~ x)$statistic, mood.test(y ~ x)$p)
  }
  return(apply(result,2,mean)) #,round(result,3)
}


p.b_confirmation.sex = bootstrap.p(data.boot2, 'b_confirmation', 'sex')
p.b_loss.sex = bootstrap.p(data.boot2, 'b_loss', 'sex')
p.b_gambler.sex = bootstrap.p(data.boot2, 'b_gambler', 'sex')
p.b_availability.sex = bootstrap.p(data.boot2, 'b_availability', 'sex')
p.b_hot_hand.sex = bootstrap.p(data.boot2, 'b_hot_hand', 'sex')
p.b_bandwagon.sex = bootstrap.p(data.boot2, 'b_bandwagon', 'sex')
p.b_dunning.sex = bootstrap.p(data.boot2, 'b_dunning', 'sex')
