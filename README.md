# Cattle Mortality in Northern Ireland

MSc thesis by Marietta Dalamanga, Queen's University Belfast, 2024

## About

In this MSc project we present the results of a large scale survival analysis of cattle mortality
from across Northern Ireland exploring
several risk factors including the sex,
geographic area, production type,
place of death, and health status.
To this end, we used several parametric,
nonparametric, and semiparametric methods:
**Kaplan-Meier estimators**,
the **AFT** and
**Cox methods**,
fitting parametric distributions—including
mixture distributions—survival forests,
and methods from machine learning such as
random forests, extreme boosted trees
and regression trees.
We applied these methods to different
subpopulations of the dataset.
Best results were obtained using
a Cox model with shared frailty term
on the herd ID (C-index: 73.52%),
and a survival forest on the dairy
subpopulation (75.11%).
We were also able to predict the life span
of male animals using a random
forest (RMSE 153.4 days, R<sup>2</sup>=0.65).
The sex and certain abattoirs proved
to be the main risk factors for cattle survival.

You may download the final report from [here]().

## Key findings


## Contents

- `collinearity.Rmd`:  
- `cox_modelling.Rmd`       
- `eda_combined.Rmd`               
- `fit_distributions.Rmd`  
- `mean_age_different_variables.Rmd`
- `combined_km.Rmd`   
- `data_preprocessing.Rmd`  
- `fit_distributions_on_data.Rmd`
- `log_rank_tests.Rmd`
- `prepare_data_for_modelling.Rmd`

## How to use

TODO
