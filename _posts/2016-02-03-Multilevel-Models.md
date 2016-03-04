---
layout: post
title: "Multilevel Models"
date: "February 3, 2016"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



Multilevel models are a compromise between two extremes

* Models that pool the effects of multiple groups; group indicators are not included in the model
* Models that fit separate fits for each group


# Varying Intercept Model

Consider three variants of models: 

<img src="/nhuyhoa/figure/source/2016-02-03-Multilevel-Models/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

In the left plot, we fit two separate models. We fit one model with no group variables, the intercept estimate is represented by dashed horizontal line. We fit another model with separate intercepts for each group These intercept estimates and standard error bars are represented by the individual points. Notice that the error bars are quite large at small $$n$$ sizes and and smaller at higher $$n$$ sizes. The complete pooling model ignores county variability while the no-pooling model overstates it (as groups with small $$n$$ sizes are inaccurately estimated). 

In the right plot, we fit a multilevel model (with the same complete pooling estimate). Multilevel models attempt to compromise between the complete pooling and the no-pooling model. Essentially, the estimates in multilevel models are a weighted averages (based on the group $$n$$ size) of the complete pooling and the no-pooling estimates (variances). The weights are based on the group $$n$$ size; the smaller the group $$n$$ the closer the multilevel estimate is to overall average (pooling estimate), the larger the group $$n$$ the closer the multilevel estimate is to the county average (no-pooling estimate). Notice this trend in the multilevel plot above.

With multilevel models of varying intercepts, the intercept terms are $$\alpha_i$$ ~ $$N(\mu_a, \sigma^2_a)$$. When $$\sigma^2_a \rightarrow 0$$, we have a no-pooling model. When $$\sigma^2_a \rightarrow \infty$$, we have a complete pooling model. The multilevel model is essentially a compromise between the two models. 

We can assess the group and individual level variation using intraclass correlation. 

$$\frac{\sigma^2_a}{\sigma^2_a + \sigma^2_y}$$

This value ranges from $$0$$ (for no information conveyed by group) and $$1$$ (for consolidated groupings). 

We can also look at the variance ratio

$$r = \frac{\sigma^2_a}{\sigma^2_y}$$

This value tells us that the standard deviation of average $$y$$ between groups is the same as the standard deviation of the average of $$1/r$$ measurements within a group. For a group with more than $$1/r$$ observations, within-group measurements are more informative. Otherwise, the across group measurements are more informative. 

## Fitting Models

We can fit variants of the varying intercept models in R with the following `lmer()` commands

**Varying intercept, no predictors:**

$$y$$ ~ $$N(\alpha_i, \sigma^2_y)$$ and $$\alpha$$ ~ $$N(\mu_a, \sigma^2_a)$$


{% highlight r %}
lmer(y ~ 1 + (1 | group))
{% endhighlight %}

**Varying intercept, individual level predictors:**

$$y$$ ~ $$N(\alpha_i + \beta x, \sigma^2_y)$$ and $$\alpha$$ ~ $$N(\mu_a, \sigma^2_a)$$


{% highlight r %}
lmer(y ~ x + (1 | group))
{% endhighlight %}

**Varying intercept, individual and group level predictors:**

$$y$$ ~ $$N(\alpha_i + \beta x, \sigma^2_y)$$ and $$\alpha$$ ~ $$N(\mu_a + \tau grp.x, \sigma^2_a)$$


{% highlight r %}
lmer(y ~ x + grp.x + (1 | group))
{% endhighlight %}

# Varying Intercept, Varying Slope Model

# Generalized Linear Multilevel Models

# In R

## Viewing Results

We can use the following commands to view results and estimates.


{% highlight r %}
# view summary of data
display(mod)

# view group coefficients
coef(mod)

# view fixed effects
fixef(mod)

# view fixed effects standard error
se.fixef(mod)

# view random effects (these are the deviations from FE)
ranef(mod)

# view random effects standard error
se.ranef(mod)
{% endhighlight %}

We can use the following estimates to obtain confidence intervals for the estimates. 

## Prediction

We can obtain prediction estimates and its confidence intervals (from quantiles) by using simulation. The methods of how we do this may depend on what we want to predict. 

For example, if we want to predict a data point for a given group, we use the estimated group coefficient to calculate the fitted value for $$y$$. We also need to add an error term (specified by $$\sigma_y$$). The variance for these predictions are $$\sigma^2_y$$.

If we want to predict a data point for a new group, we conduct a two-step simulation. First we simulate the group estimate using its predictors and the error term $$\sigma^2_a$$. We then use these estimates to predict $$y$$ along with its own error terms $$\sigma^2_y$$. The variance of these predictions are $$\sigma^2_a + \sigma^2_y$$. The ability to obtain predictions for new groups is a great advantage for multilevel models.


