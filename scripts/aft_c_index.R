library(tidyverse)
library(dplyr)
library(tidyr)
library(survival)
library(survminer)
library(ggplot2)
library(ggpubr)
library(fitdistrplus)
library(logspline)
library(fitur)
library(actuar)
library(JM)
library(caret)
library(SurvMetrics)


training_dataset_fname <- "data/train.csv"
validation_dataset_fname <- "data/validation.csv"
training_dataset <- read.csv(training_dataset_fname)
validation_dataset <- read.csv(validation_dataset_fname)

exclude_shortlived <- function(ds) {
	ds <- ds[ds$days_alive > 1, ]
}

training_dataset <- training_dataset[training_dataset$days_alive > 1, ]
split_indices <- createDataPartition(training_dataset$days_alive, p=0.05, list=FALSE)
training_dataset <- training_dataset[split_indices, ]

validation_dataset <- validation_dataset[validation_dataset$days_alive > 1, ]


training_dataset[,c("Herd_Id", "Abattoir", "Dvo_Code", "Breed", "Sex", "place_of_death", "prod_type")] = lapply(training_dataset[,c("Herd_Id", "Abattoir", "Dvo_Code", "Breed", "Sex", "place_of_death", "prod_type")], function(x) as.factor(x))


colnames(training_dataset)[15] <- "time"
colnames(validation_dataset)[15] <- "time"

split_indices <- createDataPartition(validation_dataset$time, p=0.022, list=FALSE)
validation_data_sample <- validation_dataset[split_indices, ]

validation_data_sample[,c("Herd_Id", "Abattoir", "Dvo_Code", "Breed", "Sex", "place_of_death", "prod_type")] = lapply(validation_data_sample[,c("Herd_Id", "Abattoir", "Dvo_Code", "Breed", "Sex", "place_of_death", "prod_type")], function(x) as.factor(x))

cat(paste0("Training points   : ", nrow(training_dataset), "\n"))
cat(paste0("Validation points : ", nrow(validation_data_sample), "\n"))

vars_to_test <- c("Dvo_Code + Abattoir + Sex + place_of_death + num_cond + herd_size",
		  "Dvo_Code + Abattoir + Sex + place_of_death + num_cond")


for (vars in vars_to_test) {
	cat("--------------\n")
	cat(paste("AFT/Weibull with variables: ", vars, "\n"))
	formula <- paste("Surv(time, status) ~ ", vars, sep="")
	cat("Training...\n")
	surv_model <- survreg(as.formula(formula), data = training_dataset, dist = "weibull")
	cat("Computing C-index...\n")
	c_cind <- Cindex(surv_model, validation_data_sample)
	cat(paste("C-index: ", c_cind, "\n"))
	cat("Saving...\n")
	model_fname <- paste0("models/aft_weibull_fine_selection/mdl_", vars, "__x.rds", sep="")
	saveRDS(surv_model, model_fname)
}




