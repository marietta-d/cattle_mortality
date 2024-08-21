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

vars_surv <- colnames(train)[c(6, 8, 12, 13, 14, 15, 20)]
train_surv <- train[, vars_surv]
val_surv <- validation[, vars_surv]

# make factors
train_surv[,c("Abattoir", "prod_type", "Sex", "num_cond")] = 
  lapply(train_surv[,c("Abattoir", "prod_type", "Sex", "num_cond")],
         function(x) as.factor(x))

val_surv[,c("Abattoir", "prod_type", "Sex", "num_cond")] = 
  lapply(val_surv[,c("Abattoir","prod_type", "Sex", "num_cond")],
         function(x) as.factor(x))


survforest <- function(part, ntree) {
	  playground_ind <- createDataPartition(train_surv$days_alive, p=part, list=FALSE)
	  playground_train <- train_surv[playground_ind, ]
	  playground_val_ind <- createDataPartition(val_surv$days_alive, p=part, list=FALSE)
	  playground_val <- val_surv[playground_val_ind, ]
	  
	  a = Sys.time()
	  # Note: use rfsrc ane not rfsrc.fast so that we 
	  # get normal mortality predictions (not probabilities 
	  # or whatever!)
	  RSurvF_obj <- rfsrc(Surv(days_alive,status)~., playground_train, ntree = ntree,  membership = TRUE, importance=TRUE, forest=TRUE)
	  b = Sys.time()    
	  print(paste0(round(as.numeric(difftime(time1 = b, time2 = a, units = "secs")), 3), " Seconds"))

	  return(RSurvF_obj)
}


set.seed(123)
trees <- c(seq(100, 500, 10), seq(550, 1000, 50))
parts <- c(0.05, 0.1)


# ------------------------------------


for (tree in trees) {
  for (p in parts) {
  	print("++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    c_fname <- paste("models/survforests_simple/survforest_p_", p, "_trees_", tree, ".rds", sep="")
    if (file.exists(c_fname)) {  
	print(paste("File ", c_fname, " exists"))
    } else {
	print(paste0("[Yo!] Model with ", tree, " trees and ", p*nrow(train), " data points (p=", p, ")"))
	c_forst <- survforest(p, tree)
	c_cind <- get.cindex(c_forst$yvar[,1], c_forst$yvar[,2], c_forst$predicted.oob)
	print(paste0("C-index: ", c_cind))

	print(paste("[Yo!] Saving in", c_fname))
	saveRDS(c_forst, c_fname)
	print("[Yo!] Model successfully saved!")
	print("  ")
    }
  }
}

# To predict do:
# pr <- predict(c_forst, test[1:5, ])


