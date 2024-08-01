## Notes


### AFT all data

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
- A model using `Dvo_Code`, `Abbatoir, `Sex`, `Abattoir_._Died_on_Farm`, `Total_Conditions_per_Animal`, `AvgOftotal_animals`. Here the log-likelihood was 53977144 and AIC was -107954227

The remaining models exhibited underwhelming log-likelihood and AIC/BIC results.

The five best models are shown below

```
Model                                                                                                                                           aic        bic      llik
AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal                          -479347710 -479347338 239673885
AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal+AvgOftotal_animals       -107954227 -107953842  53977144
AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal+AvgOftotal_animals   27802610   27803081 -13901267
AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Total_Conditions_per_Animal+AvgOftotal_animals                           27802638   27803097 -13901282
AFT::weibull::Surv(days_alive,status)~Dvo_Code+Abbatoir+Breed+Sex+Abattoir_._Died_on_Farm+Total_Conditions_per_Animal                      27803492   27803951 -13901709
```


