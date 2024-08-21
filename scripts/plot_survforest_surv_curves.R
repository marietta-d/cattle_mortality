# REFERENCE: https://www.randomforestsrc.org/articles/survival.html
# Explains how to plot survival curves (actual/predicted)

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



data <- read.csv("data/validation.csv")
# Take random sample 
split_indices <- createDataPartition(data$days_alive, p=0.2, list=FALSE)
few_data <- data[split_indices, ]
files <- list.files(path="models/survforests/", pattern="*.rds", full.names=TRUE, recursive=FALSE)

for (f in files) {
	print("------------------------------------------------------------")
	
	print(f)	
	# Load model
	m <- readRDS(f)
	# Predict survival using survival forest model
	y <- predict(m, few_data)
	print(y)	

	print(" ")
	print(" ")
}
