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
library(frailtypack)

data <- read.csv("./data/common_conditions_breed_data.csv")
# Factor variables
data[,c("Herd_Id", "Abbatoir", "Dvo_Code", "Breed", "Sex", "Abattoir_._Died_on_Farm", "Beef_or_Dairy")] = 
      lapply(data[,c("Herd_Id", "Abbatoir", "Dvo_Code", "Breed", "Sex", "Abattoir_._Died_on_Farm", "Beef_or_Dairy")],
                                function(x) as.factor(x))
                                
                                
                                
                                
#' Formula with combination of k variables
#' 
#' @param predictors list of variables (strings)
#' @param k tuple size
#' @returns list of all possible formulas with k variables
formulas_of_len <- function(predictors, k) {
  mdl_prefix <- "Surv(days_alive, status) ~"
  all_formulas_len_k <- c()
  combs <- combn(predictors, k, simplify = FALSE)
  num_combs <- length(combs)
  for (j in 1:num_combs) {
    comb_j <- combs[j][[1]]
    comb_j_joined <- paste(comb_j, collapse = "+")
    comb_j_joined <- paste(mdl_prefix, comb_j_joined)
    all_formulas_len_k <- c(all_formulas_len_k, comb_j_joined)
  }
  return(all_formulas_len_k)
}

#' Wrapper function that returns all possible formulas (list of strings)
#' There are 2^N - 1 formulas, where N is the number of predictors
#' 
#' @param predictors list of variables (strings)
#' @returns all possible formulas (list of strings)
all_possible_formulas <- function(predictors) {
  all_formulas <- c()
  num_predictors <- length(predictors)
  for (i in 1:num_predictors) {
      these_combinations <- formulas_of_len(predictors, i)
      all_formulas <- c(all_formulas, these_combinations)
  }
  return(all_formulas)
}





run_cox_models_frailty <- function(data, predictors, destination_folder, frailty_var) {
    # TAKE ALL FORMULAS OF LENGTH 1, 2, ..., n
    formulas <- all_possible_formulas(predictors)
    aic_cache <- c()
    bic_cache <- c()
    llik_cache <- c()
    formula_cache <- c()
    cox_mdl_cache <- list()
    test_ph_cache <- list()
    i <- 1
    # MAKE COX MODELS
    for (f in formulas) {
      # 1. make the model
      f_with_frailty = paste(f, "+ frailty(", frailty_var, ")")
      print(f_with_frailty)
      cox_mdl <- coxph(as.formula(f_with_frailty), data=data)
      # 2. compute statistics
      aic_value <- as.numeric(AIC(cox_mdl))
      bic_value <- as.numeric(BIC(cox_mdl))
      llik_value <- as.numeric(logLik(cox_mdl))
      # 3. Statistical tests
      
      zphSuccess <- 0
      tryCatch({
        test_ph <- cox.zph(cox_mdl)
        test_ph_cache[[i]] <- test_ph
        zphSuccess <- 1
      } , error = function(e) {
          print("Error!")
          print(e)
          test_ph_cache[[i]] <- 0
        }
      )
      
      # 4. Print info
      print("---------------------------------------------")
      print(paste("Formula       : ", f))
      print(paste("AIC           : ", aic_value))
      print(paste("ell           : ", llik_value))
      print(paste("BIC           : ", bic_value))
      if (zphSuccess == 1) {
        print(paste("significance* : ", as.numeric(test_ph$table[,"p"][1])))
        print("* must be LARGE for the Cox assumptions to hold")
        print(test_ph)
      }
      print(".............................................")
      
      aic_cache <- c(aic_cache, aic_value)
      bic_cache <- c(bic_cache, bic_value)
      llik_cache <- c(llik_cache, llik_value)
      formula_cache <- c(formula_cache, f)
      cox_mdl_cache[[i]] <- cox_mdl
      
      
      i <- i + 1
    }
    
    
    model_meta <- data.frame(aic_cache, bic_cache, llik_cache, formula_cache)
    print("Modelling complete - saving final data in destination folder")
    meta_fname <- paste("models", destination_folder, paste("meta_", frailty_var,".rds", sep=""), sep="/")
    models_fname <- paste("models", destination_folder, paste("models_", frailty_var,".rds", sep=""), sep="/")
    statistical_tests_fname <- paste("models", destination_folder, paste("stats_", frailty_var,".rds", sep=""), sep="/")
    saveRDS(model_meta, file=meta_fname)  
    saveRDS(cox_mdl_cache,  file=models_fname) 
    saveRDS(test_ph_cache,  file=statistical_tests_fname) 
    
    return(list(model_meta, cox_mdl_cache, test_ph_cache))
}





frailty_data <- data[, c(14, 15, 1, 3, 6, 7, 8, 11, 13, 20)]
destination_folder <- "cox_frailty"
all_predictors <- colnames(frailty_data)[3:10]
predictors_not_herd_id <- all_predictors[2:length(all_predictors)]


for (i in 1:(length(predictors_not_herd_id)-1)) {
  c_predictors <- predictors_not_herd_id[-i]
  c_frailty <- predictors_not_herd_id[i]
  print(paste("[ANNOUNCEMENT!] Running with frailty variable", c_frailty))
  run_cox_models_frailty(frailty_data, c_predictors, destination_folder, c_frailty)
}


