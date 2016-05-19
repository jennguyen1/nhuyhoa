---
layout: post
title: "GLM: Understanding Output"
date: "November 25, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}

# Summary Table


The output from glms in R are basically the same regardless of the link.

Consider the following example


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

# Beta Confidence Intervals
The $$100(1 - \alpha)$$% confidence interval for $$\hat{\beta}_i$$ is 

$$\hat{\beta}_i \pm z_{\alpha /2} se(\hat{\beta}_i)$$

# Predicted Values and Prediction Confidence Intervals

Procedure for prediction:

* Compute point estimate: $$ \hat{\eta} = x_0 \hat{\beta} $$
* From R, extract the variance matrix of the coefficients: `m$cov.unsealed`
* Compute variance: $$ var(\hat{\eta}) = x'_0 (X'WX)^{-1} x_0$$
* Compute confidence interval: $$ exp \left( \hat{\eta} \pm z_{\alpha/2} \sqrt{var(\hat{\eta})} \right)$$

Built in R functions:

* Predict $$\hat{\eta}$$: `predict(object, newdata, type = "link")`
* Predict $$\hat{\mu}$$: `predict(object, newdata, type = "response")`
