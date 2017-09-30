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

* `Residual standard error`: the estimate of $$\sigma$$ and how much the fitted values are expected to be off on average. In other words this is equal to $$ \sqrt{MSE} = \sqrt{\frac{SSE}{df_E}} =  \sqrt{\frac{SSE}{n - p}} $$
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

The ANOVA table presents the sums of square contributions of covariates to the model. The ANOVA table is dependent on the ordering of covariates in the model formula. For example interpret the entry for Species as after $$Petal.Length$$ has been taken into consideration, the variance accounted for by $$Species$$ is signficantly greater than the variance of the error. Ordering the covariates differently results in different values in the ANOVA table. This is known as the **Type I SS ANOVA** table, which takes into account the order.

There is also **Type III SS ANOVA** table, which displays the effects when other variables have been accounted for (when fit last). 


{% highlight r %}
drop1(m, ~ ., test = "F")
{% endhighlight %}



{% highlight text %}
## Single term deletions
## 
## Model:
## Sepal.Length ~ Petal.Length * Species
##                      Df Sum of Sq    RSS     AIC F value    Pr(>F)
## <none>                            16.301 -320.91                  
## Petal.Length          1   0.43459 16.735 -318.97  3.8392    0.0520
## Species               2   2.89913 19.200 -300.36 12.8054 7.611e-06
## Petal.Length:Species  2   0.38098 16.682 -321.45  1.6828    0.1895
{% endhighlight %}


Note the similarities between the summary table and the ANOVA table. 

* $$MSE = 0.113$$ in the ANOVA table. Take its square root which equals the residual standard error = $$0.336$$ of the summary table. The degrees of freedom are the same. 
* Compute $$F = \frac{\Sigma SS_R / \Sigma df_R}{SS_E/df_E} = \frac{85.867/5}{16.301/144} = 151.7 $$ on $$5$$ and $$144$$ degrees of freedom. This is equivalent to the $$F$$ statistic given in the summary table.
* The $$F$$ value of $$Petal.Length$$ from the Type III ANOVA table is equal to $$t^2$$ of $$Petal.Length$$ from the summary table. Both of these correspond to the effect when it is fit last

# Comparing Models
Consider comparing two models, where one is nested in the other. Let $$R$$ correspond to the reduced model with $$p - q$$ parameters. Let $$F$$ correspond to the full model with $$p$$ parameters. Then compare the two models with a test statistic

$$ F = \frac{(SSE_R - SSE_F)/ (df_F - df_R)}{SSE_F/df_F} $$

where $$ F  \sim  F_{q, n - p} $$ and $$SSE$$ is the sum square errors and $$DF$$ is the residual degrees of freedom corresponding to the specified model.

Let's look at an example:

{% highlight r %}
# fit models
modh <- lm(Sepal.Length ~ Petal.Length + Species, data = iris)
moda <- lm(Sepal.Length ~ Petal.Length * Species, data = iris)

# obtain the sum square error
RSSh <- anova(modh)["Sum Sq"][3,1]
RSSa <- anova(moda)["Sum Sq"][4,1]

# compute the F statistic & p-value by hand
F <- (RSSh - RSSa) / (2) / (RSSa/144)
pf(F, 2, 144, lower.tail = FALSE)
{% endhighlight %}



{% highlight text %}
## [1] 0.1894918
{% endhighlight %}



{% highlight r %}
# using built in R
anova(modh, moda)
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Model 1: Sepal.Length ~ Petal.Length + Species
## Model 2: Sepal.Length ~ Petal.Length * Species
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1    146 16.682                           
## 2    144 16.301  2   0.38098 1.6828 0.1895
{% endhighlight %}

Thus the full and simplified model are not significantly different from each other. The interaction term is not significantly different from $$0$$, meaning that the slope of $$Petal.Length$$ on $$Sepal.Length$$ is the same for all species. 

# Confidence Intervals for Betas

Obtain the confidence intervals for the $$\beta$$s using the following function

{% highlight r %}
confint(m)
{% endhighlight %}



{% highlight text %}
##                                       2.5 %     97.5 %
## (Intercept)                     3.407870308  5.0184661
## Petal.Length                   -0.004757525  1.0893427
## Speciesversicolor              -2.988483690 -0.6228065
## Speciesvirginica               -4.406804100 -1.9002142
## Petal.Length:Speciesversicolor -0.297224644  0.8692014
## Petal.Length:Speciesvirginica  -0.120048393  1.0269405
{% endhighlight %}


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

These are the confidence and prediction intervals for $$Y$$. Note that the fitted values are the same, but the interval widths for the confidence intervals are smaller compared to the prediction intervals. 
