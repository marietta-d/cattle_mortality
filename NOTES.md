## Notes


### AFT on all data

Having taken all AFT models using all possible combinations 
of the variables

- `Dvo_Code`
- `Abbatoir`
- `Sex`
- `Abattoir_._Died_on_Farm`
- `Total_Conditions_per_Animal`
- `AvgOftotal_animals`
- `Breed`

we found that the best two performing models (with high loglik) are

- A model using `Dvo_Code`, `Abbatoir`, `Sex`, `Abattoir_._Died_on_Farm`, and `Total_Conditions_per_Animal` and the Weibull distribution. This yielded a log-likelihood of 239673885 and AIC of -479347710
- A model using `Dvo_Code`, `Abbatoir`, `Sex`, `Abattoir_._Died_on_Farm`, `Total_Conditions_per_Animal`, `AvgOftotal_animals`. Here the log-likelihood was 53977144 and AIC was -107954227

The remaining models exhibited underwhelming log-likelihood and AIC/BIC results.

The five best models are shown below


| Model  |  aic   |     bic   |   llik |
| ------ | ------ | --------- | ------ | 
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal                          | -479,347,710 | -479,347,338 | 239,673,885 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal+AvgOftotal_animals       | -107,954,227 | -107,953,842 |  53,977,144 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal+AvgOftotal_animals |   27,802,610 |   27,803,081 | -13,901,267 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Total_Conditions_per_Animal+AvgOftotal_animals                         |   27,802,638 |   27,803,097 | -13,901,282 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal                    |   27,803,492 |   27,803,951 | -13,901,709 |




### AFT on healthy data

Here all models exhibited very low values of log-likelihood (and, thus, very high values of AIC and BIC).

The best five models are shown below

| Model  |  aic   |     bic   |   llik |
| ------ | ------ | --------- | ------ | 
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm+AvgOftotal_animals     | 22,698,592 | 22,699,044 | -11,349,259 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+AvgOftotal_animals                             | 22,698,615 | 22,699,055 | -11,349,272 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm                        | 22,699,395 | 22,699,835 | -11,349,662 |
| AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex                                                | 22,699,417 | 22,699,845 | -11,349,674 |
| AFT::weibull::Surv(days_alive,status)~Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm+AvgOftotal_animals              | 22,701,253 | 22,701,595 | -11,350,599 |


### Cox models on all data
