---
layout: post
title: "OLS: Understanding Outputs"
date: "October 24, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}




{% highlight r %}
m <- lm(Sepal.Length ~ Petal.Length*Species, data = iris)
{% endhighlight %}

# Summary Table

{% highlight r %}
summary(m)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = Sepal.Length ~ Petal.Length * Species, data = iris)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.73479 -0.22785 -0.03132  0.24375  0.93608 
## 
## Coefficients:
##                                Estimate Std. Error t value Pr(>|t|)
## (Intercept)                      4.2132     0.4074  10.341  < 2e-16
## Petal.Length                     0.5423     0.2768   1.959  0.05200
## Speciesversicolor               -1.8056     0.5984  -3.017  0.00302
## Speciesvirginica                -3.1535     0.6341  -4.973 1.85e-06
## Petal.Length:Speciesversicolor   0.2860     0.2951   0.969  0.33405
## Petal.Length:Speciesvirginica    0.4534     0.2901   1.563  0.12029
## 
## Residual standard error: 0.3365 on 144 degrees of freedom
## Multiple R-squared:  0.8405,	Adjusted R-squared:  0.8349 
## F-statistic: 151.7 on 5 and 144 DF,  p-value: < 2.2e-16
{% endhighlight %}

The summary table contains a lot of information regarding the linear model.

* `Call`: the model formula
* `Residuals`: summary statistics on the residuals
* `Coefficients`: `Estimate`: the $$\hat{\beta}$$ coefficients
* `Coefficients`: `Std. Error`: the standard errors for the $$\hat{\beta}$$ coefficients
* `Coefficients`: `t value`: The $$t$$ statistic derived from the estimate and standard error of $$\hat{\beta}$$ and the null hypothesis that $$\hat{\beta} = 0$$. The $$t$$ value has the same degrees of freedom as the error
* `Coefficients`: `Pr(>|t|)`:  The two-sided p-value of the $$t$$ statistic

Note that the $$t$$ statistic and the p-value are interpreted as the effect of the variable after all other covariates have been accounted for. 

* `Residual standard error`: the estimate of $$\sigma$$. In other words this is equal to $$ \sqrt{MSE} = \sqrt{\frac{SSE}{df_E}} =  \sqrt{\frac{SSE}{n - p}} $$
* `R-squared`: This is the total variance of $$Y$$ that is explained by the covariates. In other words, $$ R^2 = 1 - \frac{SS_{err}}{SS_{tot}} $$
* `Adjusted R-squared`: This is the total variance of $$Y$$ that is explained by the covariates, adjusted for by the number of covariates. The $$R^2$$ will increase as more parameters are introduced into the model. The adjusted $$R^2$$ value places a penalty on an excess of parameters.
* `F-statistic`: The $$F$$ statistic and corresponding p-value comparing the full model to an intercept only model

# ANOVA Table

{% highlight r %}
anova(m)
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Response: Sepal.Length
##                       Df Sum Sq Mean Sq  F value    Pr(>F)
## Petal.Length           1 77.643  77.643 685.8998 < 2.2e-16
## Species                2  7.843   3.922  34.6441 5.206e-13
## Petal.Length:Species   2  0.381   0.190   1.6828    0.1895
## Residuals            144 16.301   0.113
{% endhighlight %}

The ANOVA table presents the sums of square contributions of covariates to the model. The ANOVA table is dependent on the ordering of covariates in the model formula. For example to interpret the entry for Species, we say that after $$Petal.Length$$ has been taken into consideration, the variance accounted for by $$Species$$ is signficantly greater than the variance of the error. If we were to order the covariates differently in the model formulation, we would see different values in the ANOVA table. 

Note the similarities between the summary table and the ANOVA table. 

* $$MSE = 0.113$$ in the ANOVA table. Take its square root and we see that it equals the residual standard error = $$0.336$$ of the summary table. The degrees of freedom are the same. 
* Compute $$F = \frac{\Sigma SS_R / \Sigma df_R}{SS_E/df_E} = \frac{85.867/5}{16.301/144} = 151.7 $$ on $$5$$ and $$144$$ degrees of freedom. This is equivalent to the $$F$$ statistic given in the summary table.
* While it's not evident in this model (due to the factors being in the model), the $$F$$ value of the last covariate in the ANOVA table is equal to the $$t$$ value in summary table to the $$2^{nd}$$ power. 


{% highlight r %}
m2 <- lm(Sepal.Length ~ Petal.Length + Sepal.Width, data = iris)
summary(m2)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept)     2.249      0.248   9.070        0
## Petal.Length    0.472      0.017  27.569        0
## Sepal.Width     0.596      0.069   8.590        0
{% endhighlight %}



{% highlight r %}
anova(m2)
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Response: Sepal.Length
##               Df Sum Sq Mean Sq F value    Pr(>F)
## Petal.Length   1 77.643  77.643 698.985 < 2.2e-16
## Sepal.Width    1  8.196   8.196  73.787 1.163e-14
## Residuals    147 16.329   0.111
{% endhighlight %}

In this example, we see that the square of the $$t$$ value for $$Sepal.Width$$ = $$ 8.59^2 = 78.78 $$ which is equal to the $$F$$ value for $$Sepal.Width$$. The interpretation of the $$t$$ value in the summary table is effect of the variable after all other covariates have been accounted for. This is reflected in the ANOVA table, where $$Sepal.Width$$ is the last variable. 

# Prediction and Confidence Intervals

{% highlight r %}
predict(m, interval = "confidence") %>% head
{% endhighlight %}



{% highlight text %}
##        fit      lwr      upr
## 1 4.972378 4.872401 5.072355
## 2 4.972378 4.872401 5.072355
## 3 4.918149 4.788924 5.047373
## 4 5.026607 4.930289 5.122925
## 5 4.972378 4.872401 5.072355
## 6 5.135066 4.974453 5.295679
{% endhighlight %}



{% highlight r %}
predict(m, interval = "prediction") %>% head
{% endhighlight %}



{% highlight text %}
##        fit      lwr      upr
## 1 4.972378 4.299884 5.644871
## 2 4.972378 4.299884 5.644871
## 3 4.918149 4.240689 5.595608
## 4 5.026607 4.354648 5.698566
## 5 4.972378 4.299884 5.644871
## 6 5.135066 4.450925 5.819206
{% endhighlight %}

These are the confidence and prediction intervals for $$Y$$. Note that the fitted values are the same, but the interval widths for the confidence intervals are smaller compared to the prediction intervals. We know this from the derivation in the [Regression: Confidence & Prediction Intervals post][reg_int_post]{:target="blank"}. 

[reg_int_post]: http://jnguyen92.github.io/nhuyhoa//2015/10/OLS-Intervals.html
