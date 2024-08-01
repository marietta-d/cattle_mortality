## Notes


### AFT on all data

Overall 508 models where generated and tested.
Having taken all AFT models using all possible combinations 
of the variables

- `DVO`
- `Abbatoir`
- `Sex`
- `Place of Death`
- `# conditions`
- `Herd size`
- `Breed`

we found that the best two performing models (with high loglik) are

- A model using `DVO`, `Abbatoir`, `Sex`, `Place of Death`, and `# conditions` and the Weibull distribution. This yielded a log-likelihood of 239673885 and AIC of -479347710
- A model using `DVO`, `Abbatoir`, `Sex`, `Place of Death`, `# conditions`, `Herd size`. Here the log-likelihood was 53977144 and AIC was -107954227

The remaining models exhibited underwhelming log-likelihood and AIC/BIC results.

The five best models are shown below


| Dist    | Vars   |  AIC   |     BIC   |   loglik |
| ----    | ------ | ------ | --------- | ------ | 
| Weibull | DVO, Abbatoir, Sex, Place of Death, # conditions                    | -479,347,710 | -479,347,338 | 239,673,885 |
| Weibull | DVO, Abbatoir, Sex, Place of Death, # conditions, Herd size       	| -107,954,227 | -107,953,842 |  53,977,144 |
| Weibull | DVO, Abbatoir, Breed, Sex, Place of Death, # conditions, Herd size  |   27,802,610 |   27,803,081 | -13,901,267 |
| Weibull | DVO, Abbatoir, Breed, Sex, # conditions, Herd size                  |   27,802,638 |   27,803,097 | -13,901,282 |
| Weibull | DVO, Abbatoir, Breed, Sex, Place of Death, # conditions             |   27,803,492 |   27,803,951 | -13,901,709 |




### AFT on healthy data

Overall 508 models where generated and tested.
Here all models exhibited very low values of log-likelihood (and, thus, very high values of AIC and BIC).

The best five models are shown below

| Dist    | Vars  |  AIC   |     BIC   |   loglik |
| ----    | ------ | ------ | --------- | ------ | 
| Weibull | DVO, Abbatoir, Breed, Sex, Place of Death, Herd size     | 22,698,592 | 22,699,044 | -11,349,259 |
| Weibull | DVO, Abbatoir, Breed, Sex, Herd size                     | 22,698,615 | 22,699,055 | -11,349,272 |
| Weibull | DVO, Abbatoir, Breed, Sex, Place of Death                | 22,699,395 | 22,699,835 | -11,349,662 |
| Weibull | DVO, Abbatoir, Breed, Sex                                | 22,699,417 | 22,699,845 | -11,349,674 |
| Weibull | Abbatoir, Breed, Sex, Place of Death, Herd size          | 22,701,253 | 22,701,595 | -11,350,599 |


### Cox models on all data

Overall 127 models where generated and tested.
The AIC, BIC, and log-likelihood of the five best models is shown below.
The results are not satisfatory. 


| Vars   |  AIC   |     BIC   |    loglik |
| ------ | ------ | --------- | ------ |
| DVO, Abbatoir, Breed, Sex, Place of Death, # conditions, Herd size | 48514898  | 48515346  |  -24257413 | 
| DVO, Abbatoir, Breed, Sex, # conditions, Herd size |   48514926 |   48515361 |   -24257428 | 
| DVO, Abbatoir, Breed, Sex, Place of Death, # conditions |   48515655  |  48516090  |  -24257792 | 
| DVO, Abbatoir, Breed, Sex, # conditions |   48515682   | 48516104  |  -24257807 | 
| Abbatoir, Breed, Sex, Place of Death, # conditions, Herd size |   48518140 |   48518475 |   -24259043 | 


Using `cox.zph`, which implements the statistical test proposed by P. Grambsch and T. Therneau (1994),
we made the following observations:

1. In the univariate Cox models, the above statistical test showed that the proportional hazards (PH) assumption did not hold
2. In the majority of multivariate models, the PH assumption did not hold
3. In 13 of the multivariate models, the PH assumption was verified only for the herd size; details are shown below


| Herd size | DVO | Abattoir | Sex | Place of death | Num conditions | Breed | 
| --------- | --- | -------- | --- | -------------- | -------------- | ----- |
|    0.81   | 0   |  0       |  0  |   X            | 0              | X     |
|    0.49   | X   |  0       |  0  |   X            | X              | X     | 
|    0.48   | X   |  0       |  0  |   0            | X              | X     |
|    0.33   | X   |  0       |  0  |   0            | 0              | X     |
|    0.33   | X   |  0       |  0  |   X            | 0              | X     |
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




