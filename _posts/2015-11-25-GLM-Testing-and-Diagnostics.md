---
layout: post
title: "GLM: Hypothesis Testing & Diagnostics"
date: "November 25, 2015"
categories: statistics
---

* TOC
{:toc}



# Hypothesis Testing

* Null model: intercept only model
* Saturated model: model with n obs and n parameters, each data point has its own parameter
* Proposed model: model with p parameters, model that you fit

Deviance is defined as 
$$ D(y) = -2 \left( L(y \vert \hat{\theta}_m)) - L(y \vert \hat{\theta}_s)) \right) $$

where $$L$$ denotes the log likelihood, $$\hat{\theta}_m$$ denotes fitted values for the proposed model and $$\hat{\theta}_s$$ denotes fitted values for the saturated model. 
The deviance is asymptotically distributed $$X^2_p$$.

There are two types of hypothesis tests that can be done with GLMs.

* Goodness of fit: does the current model fit the data?
* Compare two nested models, which one is better?

Note that the goodness of fit is a comparison of two models (the proposed model and the saturated model).

We can fit a glm in R and assess goodness of fit.

{% highlight r %}
mod1 <- glm(cbind(dead, alive) ~ conc, family = binomial, data = bliss)
summary(mod1)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## glm(formula = cbind(dead, alive) ~ conc, family = binomial, data = bliss)
## 
## Deviance Residuals: 
##       1        2        3        4        5  
## -0.4510   0.3597   0.0000   0.0643  -0.2045  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept)  -2.3238     0.4179  -5.561 2.69e-08 ***
## conc          1.1619     0.1814   6.405 1.51e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 64.76327  on 4  degrees of freedom
## Residual deviance:  0.37875  on 3  degrees of freedom
## AIC: 20.854
## 
## Number of Fisher Scoring iterations: 4
{% endhighlight %}

* Null deviance: $$D_{sat} - D_{null}$$
* Residual deviance: $$D_{sat} - D_{model}$$

With these values we can conduct our hypothesis tests.

{% highlight r %}
# goodness of fit - using deviance
pchisq(mod1$deviance, mod1$df.residual, lower.tail = FALSE)
{% endhighlight %}



{% highlight text %}
## [1] 0.9445968
{% endhighlight %}
With a $$p.value = 0.94$$, we can conclude that there is no evidence of lack of fit. 


{% highlight r %}
# goodness of fit - using pearson
pchisq(sum(residuals(mod1, "pearson")^2), mod1$df.residual, lower.tail = FALSE)
{% endhighlight %}



{% highlight text %}
## [1] 0.9469181
{% endhighlight %}
Here we use the Pearson $$X^2$$ statistic
$$X^2 = \Sigma_i \frac{(y_i - \hat{\mu}_i)^2}{var(\hat{\mu}_i)}$$

which is computed via the Pearson residuals $$X^2 = \Sigma r_p^2$$


{% highlight r %}
# test significance of conc by comparing to null mod1el
pchisq(mod1$null.deviance - mod1$deviance, mod1$df.null - mod1$df.residual, lower.tail = FALSE)
{% endhighlight %}



{% highlight text %}
## [1] 1.023593e-15
{% endhighlight %}



{% highlight r %}
anova(mod1, test = "Chi")
{% endhighlight %}



{% highlight text %}
## Analysis of Deviance Table
## 
## Model: binomial, link: logit
## 
## Response: cbind(dead, alive)
## 
## Terms added sequentially (first to last)
## 
## 
##      Df Deviance Resid. Df Resid. Dev  Pr(>Chi)    
## NULL                     4     64.763              
## conc  1   64.385         3      0.379 1.024e-15 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}
Here we see that the concentration term is significant. 

We can also compare to more complex models.

{% highlight r %}
# compare to quadratic concentration term
mod2 <- glm(cbind(dead, alive) ~ conc + I(conc^2), family = binomial, bliss)
anova(mod1, mod2, test="Chi")
{% endhighlight %}



{% highlight text %}
## Analysis of Deviance Table
## 
## Model 1: cbind(dead, alive) ~ conc
## Model 2: cbind(dead, alive) ~ conc + I(conc^2)
##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
## 1         3    0.37875                     
## 2         2    0.19549  1  0.18325   0.6686
{% endhighlight %}
The results here indicate no need for a quadratic concentration term. 

# Diagnostics

## Residuals

* Response residuals: $$y - \hat{\mu}$$ has non-constant variance
* Pearson residuals: $$\frac{y - \hat{\mu}}{\sqrt{Var(\hat{\mu})}}$$  , where $$\Sigma r^2_p = X^2$$
* Deviance residuals: $$sign(y - \hat{\mu}) \sqrt{d}_i$$, where $$\Sigma r^2_d = Deviance$$
* Jackknife residuals: expensive to compute, but approximations are available

## Leverages
Since GLMs use the IRWLS algorithm, the leverage values are affected by the weights. The hat matrix is defined by
$$ H = W^{1/2}X(X'WX)^{-1}X'W^{1/2} $$

where $$W = diag(w)$$

The diagonal elements of $$H$$ contain the leverages $$h_{i}$$.

## Cook's Distance
The Cook statistics:
$$D_i = 
\frac{(\hat{\beta}_{(i)} - \hat{\beta})' (X'WX) (\hat{\beta}_{(i)} - \hat{\beta})}{p\hat{\phi}}$$

## DFBETAs
Similar to to the linear model, DFBETAs can examine the change in fit (coefficients) from omitting an observation.

# Diagnostics in R

## How to Obtain Diagnostics in R

* Response residuals: `residuals(m, "response")`
* Pearson residuals: `residuals(m, "pearson")`
* Deviance residuals: `residuals(m)`
* Studentized residuals: `rstudent(m)`
* Leverage values: `influence(m)$hat`
* Cook statistics: `cooks.distance(m)`
* DFBETAs: `influence(m)$coef`

## Diagnostic Plots

### Residual vs Fitted Plots

{% highlight r %}
# fit model
mod <- glm(Species ~ ., family = poisson, data = g)
{% endhighlight %}

We can fit plots equivalent to the residuals vs fitted plots in linear regression. Since we use the deviance residuals (which are standardized), we should see constant variance. 

{% highlight r %}
# deviance resids vs fitted response
g1 <- qplot(y = residuals(mod), x = predict(mod, type = "response")) + 
  xlab(expression(hat(mu))) + 
  ylab("Deviance Residuals")
# deviance residuals vs fitted link
g2 <- qplot(y = residuals(mod), x = predict(mod, type = "link")) + 
  xlab(expression(hat(eta))) + 
  ylab("Deviance Residuals")

# combine
grid.arrange(g1, g2, nrow = 1)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-25-GLM-Testing-and-Diagnostics/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />
Two different scales for the fitted values. We see that using $$\hat{eta}$$ is better than $$\hat{\mu}$$. Overall, we see that the residuals are evenly spaced across fitted values, and there are no violation of assumptions.

What should we do if we see violations?

* Nonlinear trend: consider transformation of covariates (generally better than changing the link function)
* Non-constant variance: change the model

When we plot using the response residuals, we will see variation patterns consistent with the response distribution.

{% highlight r %}
# response residuals vs fitted link
qplot(y = residuals(mod, "response"), x = predict(mod, type = "link")) + 
  xlab(expression(hat(eta))) + 
  ylab("Deviance Residuals")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-25-GLM-Testing-and-Diagnostics/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />
Here we see a pattern of increasing variation consistent with the Poisson distribution. 

### Added Variable Plots
Similar to regression, we can generate added variable plots. The interpretation is similar to linear models.

In R: `car::avPlots()`

