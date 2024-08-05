## Notes


### AFT on all data

Overall 508 models where generated and tested.
Having taken all AFT models using all possible combinations 
of the variables

- `DVO`
- `Abattoir`
- `Sex`
- `Place of Death`
- `# conditions`
- `Herd size`
- `Breed`

we found that the best two performing models (with high loglik) are

- A model using `DVO`, `Abattoir`, `Sex`, `Place of Death`, and `# conditions` and the Weibull distribution. This yielded a log-likelihood of 239673885 and AIC of -479347710
- A model using `DVO`, `Abattoir`, `Sex`, `Place of Death`, `# conditions`, `Herd size`. Here the log-likelihood was 53977144 and AIC was -107954227

The remaining models exhibited underwhelming log-likelihood and AIC/BIC results.

The five best models are shown below


| Dist    | Vars   |  AIC   |     BIC   |   loglik |
| ----    | ------ | ------ | --------- | ------ | 
| Weibull | DVO, Abattoir, Sex, Place of Death, # conditions                    | -479,347,710 | -479,347,338 | 239,673,885 |
| Weibull | DVO, Abattoir, Sex, Place of Death, # conditions, Herd size       	| -107,954,227 | -107,953,842 |  53,977,144 |
| Weibull | DVO, Abattoir, Breed, Sex, Place of Death, # conditions, Herd size  |   27,802,610 |   27,803,081 | -13,901,267 |
| Weibull | DVO, Abattoir, Breed, Sex, # conditions, Herd size                  |   27,802,638 |   27,803,097 | -13,901,282 |
| Weibull | DVO, Abattoir, Breed, Sex, Place of Death, # conditions             |   27,803,492 |   27,803,951 | -13,901,709 |




### AFT on healthy data

Overall 252 models where generated and tested.
Here all models exhibited very low values of log-likelihood (and, thus, very high values of AIC and BIC).

The best five models are shown below

| Dist    | Vars  |  AIC   |     BIC   |   loglik |
| ----    | ------ | ------ | --------- | ------ | 
| Weibull | DVO, Abattoir, Breed, Sex, Place of Death, Herd size     | 22,698,592 | 22,699,044 | -11,349,259 |
| Weibull | DVO, Abattoir, Breed, Sex, Herd size                     | 22,698,615 | 22,699,055 | -11,349,272 |
| Weibull | DVO, Abattoir, Breed, Sex, Place of Death                | 22,699,395 | 22,699,835 | -11,349,662 |
| Weibull | DVO, Abattoir, Breed, Sex                                | 22,699,417 | 22,699,845 | -11,349,674 |
| Weibull | Abattoir, Breed, Sex, Place of Death, Herd size          | 22,701,253 | 22,701,595 | -11,350,599 |


### Cox models on all data

Overall 127 models where generated and tested.
The AIC, BIC, and log-likelihood of the five best models is shown below.
The results are not satisfatory. 


| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| DVO, Abattoir, Breed, Sex, Place of Death, # conditions, Herd size | 48514898  | 48515346  |  -24257413 | 
| DVO, Abattoir, Breed, Sex, # conditions, Herd size |   48514926 |   48515361 |   -24257428 | 
| DVO, Abattoir, Breed, Sex, Place of Death, # conditions |   48515655  |  48516090  |  -24257792 | 
| DVO, Abattoir, Breed, Sex, # conditions |   48515682   | 48516104  |  -24257807 | 
| Abattoir, Breed, Sex, Place of Death, # conditions, Herd size |   48518140 |   48518475 |   -24259043 | 


Using `cox.zph`, which implements the statistical test proposed by P. Grambsch and T. Therneau (1994),
we made the following observations:

1. In the univariate Cox models, the above statistical test showed that the proportional hazards (PH) assumption did not hold
2. In the majority of multivariate models, the PH assumption did not hold
3. In 12 of the multivariate models, the PH assumption was verified only for the herd size; details are shown below


| Herd size | DVO | Abattoir | Sex | Place of death | Num conditions | Breed | 
| --------- | --- | -------- | --- | -------------- | -------------- | ----- |
|    0.81   | 0   |  0       |  0  |   X            | 0              | X     |
|    0.49   | X   |  0       |  0  |   X            | X              | X     | 
|    0.48   | X   |  0       |  0  |   0            | X              | X     |
|    0.33   | X   |  0       |  0  |   0            | 0              | X     |
|    0.33   | X   |  0       |  0  |   X            | 0              | X     |
|    0.33   | X   |  0       |  0  |   0            | 0              | X     |
|    0.19   | 0   |  0       |  0  |   0            | X              | X     |
|    0.19   | 0   |  0       |  0  |   0            | X              | X     |
|    0.19   | 0   |  0       |  0  |   X            | X              | X     |
|    0.08   | 0   |  0       |  0  |   0            | 0              | X     |
|    0.08   | 0   |  0       |  0  |   X            | 0              | X     |
|    0.06   | X   |  X       |  0  |   X            | X              | X     |

It seems that although the herd size alone does not satisfy the PH assumption, in presence of
the sex variable it does. Apart from this, it is difficult to draw any definitive conclusions
regarding how and why this happens. 




### Cox models on healthy data

Overall, 63 models were run; the log-likelihood values obtained are not good. 
The five best models are reported below:

| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| DVO, Abattoir, Breed, Sex, Place of Death, Herd size | 39183922   | 39184338  |  -19591927 | 
| DVO, Abattoir, Breed, Sex, Herd size |   39183945  |  39184349  |  -19591940 | 
| DVO, Abattoir, Breed, Sex, Place of Death |   39184614  |  39185018  |  -19592274 | 
| DVO, Abattoir, Breed, Sex |  39184637   | 39185028   | -19592286 | 
| Abattoir, Breed, Sex, Place of Death, Herd size |   39186506  |  39186812  |  -19593228 | 

### Cox models with frailty

Frailty: Abattoir, the proportional assumption doesn't hold for any of the models
Overall, 63 models were run; the log-likelihood values obtained are not good. 
The five best models are reported below:

| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| DVO, Breed, Sex, #  Conditions, Herd size | 48514928 | 48515372| -24257428| 
| DVO, Breed, Sex, #  Conditions |  48515683 |	48516115 | -24259060 |
| Breed, Sex, # Conditions, Herd size |   48518173	| 48518505	| -24523926| 
| Breed, Sex, # Conditions |  48519233 | 48519553	| -24259591| 
| DVO, Breed, Sex, Herd size |   48529319 | 48529751	| -24264625|


Frailty: Breed, the proportional assumption doesn't hold for any of the models
Overall, 63 models were run; the log-likelihood values obtained are not good. 
The five best models are reported below:

| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| DVO, Abattoir, Sex, place of death, #  Conditions, Herd size | 48514900 | 48515360| -24257413| 
| DVO, Abattoir, Sex, #  Conditions, Herd size  |  48514928 |	48515375 | -24257428 |
| DVO, Abattoir, Sex, place of death, #  Conditions |   48515657	| 48516104	| -24257792| 
| DVO, Abattoir, Sex, #  Conditions |  48515684 | 48516119	| -24257807| 
| Abattoir, Sex, place of death, #  Conditions, Herd size |   48518142 | 48518490	| -24259043|


Frailty: DVO, the proportional assumption doesn't hold for any of the models
Overall, 63 models were run; the log-likelihood values obtained are not good. 
The five best models are reported below:

| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| Abattoir, Breed, Sex, place of death # Conditions, Herd size | 48514900 | 48515360| -24257413| 
| Abattoir, Breed, Sex, # Conditions, Herd size  |  48514928 |	48515375 | -24257428 |
| Abattoir, Breed, Sex, place of death # Conditions |   48515657	| 48516104	| -24257792| 
| Abattoir, Breed, Sex, # Conditions |  48515684 | 48516119	| -24257807| 
| Abattoir, Breed, Sex, place of death, Herd size|   48529283 | 48529730	| -24264605|


Frailty: Number of health conditions, the proportional assumption doesn't hold for any of the models
Overall, 63 models were run; the log-likelihood values obtained are not good. 
The five best models are reported below:

| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| DVO, Abattoir, Breed, Sex, Place of death, Herd size | 48514564 | 48515120| -24257237| 
| DVO, Abattoir, Breed, Sex, Herd size |  48514592 |	48515135 | -24257252 |
| DVO, Abattoir, Breed, Sex, Place of death |   48515317	| 48515860	| -24257615| 
| DVO, Abattoir, Breed, Sex |  48515344 | 48515874	| -24257629| 
| Abattoir, Breed, Sex, Place of death, Herd size|   48517802 | 48518246	| -24258865|




