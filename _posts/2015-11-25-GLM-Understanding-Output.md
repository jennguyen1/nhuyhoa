---
layout: post
title: "GLM: Understanding Output"
date: "November 25, 2015"
categories: statistics
---

* TOC
{:toc}



The output from glms in R are basically the same regardless of the link. Here we will look at an example output. 


{% highlight r %}
mod <- glm(cbind(damage, 6 - damage) ~ temp, data = orings, family = binomial)
summary(mod)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## glm(formula = cbind(damage, 6 - damage) ~ temp, family = binomial, 
##     data = orings)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -0.9529  -0.7345  -0.4393  -0.2079   1.9565  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) 11.66299    3.29626   3.538 0.000403 ***
## temp        -0.21623    0.05318  -4.066 4.78e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 38.898  on 22  degrees of freedom
## Residual deviance: 16.912  on 21  degrees of freedom
## AIC: 33.675
## 
## Number of Fisher Scoring iterations: 6
{% endhighlight %}

* Coefficient table: $$\hat{\beta}$$ estimates and standard errors, $$\hat{\beta}$$ are normally distributed
* Model Fit Statistics: deviances and AIC, deviances have $$X^2$$ distribution
* Fischer Scoring iterations: number of iterations in the IRWLS algorithm
