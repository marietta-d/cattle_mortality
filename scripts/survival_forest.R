library(naivebayes)
library(tidyverse)
library(skimr)
library(FactoMineR)
library(factoextra)
library(mlbench)
library(caret)
library(caretEnsemble)
library(RANN)
library(caTools)
library(rpart)
library(rpart.plot)
library(ranger)
library(e1071)
library(arules)
library(arulesViz)
library(mice)
library(NbClust)
library("randomForestSRC")
library("survival")


train <- read.csv("./data/train.csv")
test <-read.csv("./data/test.csv")
validation <- read.csv(("./data/validation.csv"))

vars_surv <- colnames(train)[c(3, 6, 8, 11, 12, 13,14, 15, 20)]
train_surv <- train[, vars_surv]
val_surv <- validation[, vars_surv]

# make factors
train_surv[,c("Dvo_Code", "Abattoir", "prod_type", "Sex", "place_of_death", "num_cond")] = 
  lapply(train_surv[,c("Dvo_Code","Abattoir","prod_type", "Sex", "place_of_death", "num_cond")],
         function(x) as.factor(x))

val_surv[,c("Dvo_Code", "Abattoir", "prod_type", "Sex", "place_of_death", "num_cond")] = 
  lapply(val_surv[,c("Dvo_Code", "Abattoir","prod_type", "Sex", "place_of_death", "num_cond")],
         function(x) as.factor(x))


survforest <- function(part, ntree) {
  playground_ind <- createDataPartition(train_surv$days_alive, p=part, list=FALSE)
  playground_train <- train_surv[playground_ind, ]
  playground_val_ind <- createDataPartition(val_surv$days_alive, p=part, list=FALSE)
  playground_val <- val_surv[playground_val_ind, ]
  
  a = Sys.time()
  RSurvF_obj <- rfsrc.fast(Surv(days_alive,status)~., playground_train, ntree = ntree,  membership = TRUE, importance=TRUE)
  b = Sys.time()    
  print(paste0(round(as.numeric(difftime(time1 = b, time2 = a, units = "secs")), 3), " Seconds"))

  return(RSurvF_obj)
}


trees <- c(seq(10, 100, 10), seq(110, 500, 20), seq(550, 1500, 50))
parts <- c(0.01, 0.05, 0.1)

for (tree in trees) {
  for (p in parts) {
    print(paste0("Model with ", tree, " trees and ", p*nrow(train), " data points"))
    c_forst <- survforest(p, tree)
  }
}
