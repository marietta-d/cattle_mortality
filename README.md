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

You may download the final report from [here](https://github.com/marietta-d/cattle_mortality/releases/download/v1.0/M.Dalamanga.Cattle.mortality.MSc.thesis.pdf).

## Shiny App for survival analysis

A **Shiny** app has been developed to facilitate the visulation of survival analysis.
The app is in `cattle_mortality_app/`. Here is a screenshot:

<img width="545" alt="1" src="https://github.com/user-attachments/assets/c0995c08-7f98-4922-926e-bf255c6a29ab" />


## Key findings

Survival functions were estimated for animals of different sexes

<img width="545" alt="1" src="https://github.com/user-attachments/assets/d275fdea-7b3a-4ef0-a4b7-d9152d76deff" />

different places of death

<img width="546" alt="2" src="https://github.com/user-attachments/assets/7faded63-497b-49bc-829b-80a3f267ef66" />

different breeds

<img width="551" alt="3" src="https://github.com/user-attachments/assets/6dcebbb3-7fc4-4c00-ba20-8c7df46218e9" />

different health conditions 

<img width="540" alt="4" src="https://github.com/user-attachments/assets/3f222c51-d84a-41d7-8c1c-ffa148c20f2a" />

and many more parameters.

An exhaustive analysis was conducted were several Cox models were produced, with and without frailty terms. 
Indicatively, the findings are shown in the table below

<img width="741" alt="5" src="https://github.com/user-attachments/assets/4b2bb5f7-24af-4a20-9540-11e4562a3c63" />

a lot more results, analyses, and conclusions are available in the [MSc report](https://github.com/marietta-d/cattle_mortality/releases/download/v1.0/M.Dalamanga.Cattle.mortality.MSc.thesis.pdf).

This GitHub repo contains the R and Python scripts used to perform the analyses. Due to confidentiality reasons, the raw data have not been included in this repo.




