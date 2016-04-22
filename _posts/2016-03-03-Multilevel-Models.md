---
layout: post
title: "Multilevel Models"
date: "March 3, 2016"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Fitting Models

Models containing multiple variance components can be estimated using REML (restricted maximum likelihood). It has the advantage of obtaining unbiased estimates of the variance components (MLE estimates tend to be biased down). Once variance estimates are obtained, the fixed effects can be estimated using generalized least squares (similar to weighted least squares).

REML estimates variance components by 

1. Fit a model with fixed effects, ignoring any variance components
2. Obtain the regression residuals for observations modeled above (residuals only contain aspects of random effects and error)
3. MLE on residuals to get estimates of variance components, using $$N - p$$ as the denominator (ie taking into account FE parameters and unbiasing error variance)

Notice that REML uses a different likelihood function than simple likelihood. When comparing models, it is important to consider what likelihood a statistic is using. For example, if the AIC is based off the restricted likelihood, only models with different random effects can be compared. In order to compare models with different fixed effects, ordinary likelihood should be used. 

An alternative method is to use a Bayesian approach to fitting. Markov Chain Monte Carlo can be used to sample from the posterior to obtain interval estimates, distributions of statistics, etc. 

# Variants of Multilevel Models

Multilevel models are a compromise between two extremes

* Models that pool the effects of multiple groups; group indicators are not included in the model
* Models that fit separate fits for each group

Consider three variants of models: 

<img src="/nhuyhoa/figure/source/2016-03-03-Multilevel-Models/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

In the left plot, we fit two separate models. We fit one model with no group variables, the intercept estimate is represented by dashed horizontal line. We fit another model with separate intercepts for each group These intercept estimates and standard error bars are represented by the individual points. Notice that the sample variability is larger at small $$n$$ sizes and smaller at higher $$n$$ sizes. The complete pooling model ignores group variability while the no-pooling model overstates it (as groups with small $$n$$ sizes are inaccurately estimated). 

In the right plot, we fit a multilevel model (with the same complete pooling estimate). Multilevel models attempt to compromise between the complete pooling and the no-pooling model. Essentially, the estimates in multilevel models are a weighted averages (based on the group $$n$$ size) of the complete pooling and the no-pooling estimates (variances). The weights are based on the group $$n$$ size. The smaller the group $$n$$ the closer the multilevel estimate is to overall average (pooling estimate). The larger the group $$n$$ the closer the multilevel estimate is to the group average (no-pooling estimate). We refer to this as shrinkage towards the mean (of varying degrees).

With multilevel models of varying intercepts, the intercept terms are $$\alpha_i \sim N(\mu_a, \sigma^2_a)$$. When $$\sigma^2_a \rightarrow 0$$, we have a no-pooling model that may be underfitting. When $$\sigma^2_a \rightarrow \infty$$, we have a complete pooling model that may be overfitting. The multilevel model is essentially a compromise between the two models. It is an adaptive regularization technique.  

We can assess the group and individual level variation using intraclass correlation. 

$$\frac{\sigma^2_a}{\sigma^2_a + \sigma^2_y}$$

This value ranges from $$0$$ (for no information conveyed by group) and $$1$$ (for consolidated groupings). 

We can also look at the variance ratio

$$r = \frac{\sigma^2_y}{\sigma^2_a}$$

The variance ratio is a measure of how much many observations are needed in a group for there to be a balance between the completely-pooled and non-pooled estimates. The standard deviation of the mean between groups is the same as the standard deviation within a group with $$r$$ observations.

* If $$n_j < r$$ then $$\hat{a}_j$$ is closer to $$\mu_a$$
* If $$n_j = r$$ then $$\hat{a}_j$$ is an average of $$\mu_a$$ and $$\bar{y}_j$$
* If $$n_j > r$$ then $$\hat{a}_j$$ is closer to $$\bar{y}_j$$

This value tells us that the standard deviation of average $$y$$ between groups is the same as the standard deviation of the average of $$1/r$$ measurements within a group. For a group with more than $$1/r$$ observations, within-group measurements are more informative. Otherwise, the across group measurements are more informative. 

## Model Formulas

We can fit variants of the varying intercept models in R with the following `lmer()` commands

**Varying intercept; no predictors:**

$$y_i \sim N(\alpha_{j}, \sigma^2_y)$$ 

$$\alpha_j \sim N(\mu_a, \sigma^2_a)$$


{% highlight r %}
lmer(y ~ 1 + (1 | group))
{% endhighlight %}

**Varying intercept; individual level predictors:**

$$y_i \sim N(\alpha_{j} + \beta x_i, \sigma^2_y)$$ 

$$\alpha_j \sim N(\mu_a, \sigma^2_a)$$


{% highlight r %}
lmer(y ~ x + (1 | group))
{% endhighlight %}

**Varying intercept; individual and group level predictors:**

$$y_i \sim N(\alpha_{j} + \beta x_i, \sigma^2_y)$$ 

$$\alpha_j \sim N(\mu_a + \tau grp.x, \sigma^2_a)$$


{% highlight r %}
lmer(y ~ x + grp.x + (1 | group))
{% endhighlight %}

**Varying intercept, varying slope:**

$$y_i \sim N(\alpha_{j} + \beta_{j} x_i, \sigma^2_y)$$

$$ \left(\begin{array}
{rrr}
\alpha_j \\
\beta_j
\end{array}\right)
 \sim N\left( \left(\begin{array}
{rrr}
\mu_a \\
\mu_b
\end{array}\right) , 
\left(\begin{array}
{rrr}
\sigma^2_a & p \sigma^2_a \sigma^2_b \\
p \sigma^2_a \sigma^2_b & \sigma^2_b
\end{array}\right)
\right)$$


{% highlight r %}
lmer(y ~ x + (1 + x | group))
{% endhighlight %}

**Varying intercept, varying slope; group level predictors:**

$$y_i \sim N(\alpha_{j} + \beta_{j} x_i, \sigma^2_y)$$

$$ \left(\begin{array}
{rrr}
\alpha_j \\
\beta_j
\end{array}\right)
 \sim N\left( \left(\begin{array}
{rrr}
\mu_a + \tau grp.x\\
\mu_b + \gamma grp.x
\end{array}\right) , 
\left(\begin{array}
{rrr}
\sigma^2_a & p \sigma^2_a \sigma^2_b \\
p \sigma^2_a \sigma^2_b & \sigma^2_b
\end{array}\right)
\right)$$


{% highlight r %}
lmer(y ~ x + grp.x + x:grp.x + (1 + x | group))
{% endhighlight %}

**Varying intercept, varying slope; individual level predictors:**

$$y_i \sim N(\alpha_{j} + \beta_{j} x_i + \beta_z z_i + \beta_{j, z} (x_i z_i), \sigma^2_y)$$

$$ \left(\begin{array}
{rrr}
\alpha_j \\
\beta_j \\
\beta_{j, z}
\end{array}\right)
 \sim N\left( \left(\begin{array}
{rrr}
\mu_a \\
\mu_b \\
\mu_{bz}
\end{array}\right) , 
\left(\begin{array}
{rrr}
\sigma^2_a & p_1 \sigma^2_a \sigma^2_b & p_2 \sigma^2_a \sigma^2_{bz} \\
p_1 \sigma^2_a \sigma^2_b & \sigma^2_b & p_3 \sigma^2_b \sigma^2_{bz} \\
p_2 \sigma^2_a \sigma^2_{bz} & p_3 \sigma^2_b \sigma^2_{bz} & \sigma^2_{bz} \\
\end{array}\right)
\right)$$


{% highlight r %}
lmer(y ~ z + x + (x + x:z | group))
{% endhighlight %}

**Varying slope:**

$$y_i \sim N(\alpha + \beta_{j} x_i, \sigma^2_y)$$ 

$$\beta_j \sim N(\mu_b, \sigma^2_b)$$


{% highlight r %}
lmer(y ~ x + (x - 1 | group))
{% endhighlight %}

**Nested Models:**

$$y_i \sim N(\mu + \alpha_j + \beta_{k[j]}, \sigma^2_y)$$

$$\alpha_j \sim N(0, \sigma^2_a)$$

$$\beta_k \sim N(0, \sigma^2_b)$$


{% highlight r %}
lmer(y ~ 1 + (1 | group.b / group.a))
{% endhighlight %}


**Non-Nested Models:**

$$y_i \sim N(\mu + \alpha_j + \beta_k, \sigma^2_y)$$

$$\alpha_j \sim N(0, \sigma^2_a)$$

$$\beta_k \sim N(0, \sigma^2_b)$$


{% highlight r %}
lmer(y ~ 1 + (1 | group.a) + (1 | group.b))
{% endhighlight %}

**Transformations:**

As with regular regression, we can perform transformations for more effective fitting and interpretation. For example, centering and scaling may allow for easier interpretation of coefficients, especially when they are correlated (as with varying intercept, varying slope type models). 

Multilevel models may also be used creatively to assess a variety of effects. For example, consider a scenario where you have a number of variables that mostly measure the same thing. You can use all of the variables by combining them into a weighted average. The weighted average term would be something along the lines of $$\frac{1}{n} \sum^n_i \beta_{ij} * x_{j}$$. 

## Generalized Linear Multilevel Models

We can easily extend the fitting of multilevel models to glms.

In R, we can fit these models with `lmer()` or `glmer()`. 

# Statistical Software

## Viewing Results in R

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

If we want to predict a data point for a given group, we use the estimated group coefficient to calculate the fitted value for $$y$$. We also need to add an error term (specified by $$\sigma_y$$). The variance for these predictions are $$\sigma^2_y$$.

If we want to predict a data point for a new group, we conduct a two-step simulation. First we simulate the group estimate using its predictors and the error term $$\sigma^2_a$$. We then use these estimates to predict $$y$$ along with its own error terms $$\sigma^2_y$$. The variance of these predictions are $$\sigma^2_a + \sigma^2_y$$. The ability to obtain predictions for new groups is a great advantage for multilevel models.

The simulation procedure detailed above is done on a Bayesian approach. We can also simulate data from a bootstrapping approach. Simulations are useful to obtain predictions, standard error estimates, etc.

## Fitting in SAS and Residuals

In SAS, mixed models can be fit with the `proc mixed` procedure. 


{% highlight r %}
proc mixed;
  class a;
  model y = / outp = cond_resids outpm = marginal_resids;
  random a;
run;
{% endhighlight %}

The model above fits a simple random effect model $$Y_{ij} = \mu + A_i + \epsilon_{ij}$$ where $$A_i \sim N(0, \sigma^2_a)$$ and $$\epsilon \sim N(0, \sigma^2_e)$$. It outputs two sets of residuals

* `outp`: $$Y - X\hat{\beta} - Z\hat{b}$$
* `outpm`: $$Y - X\hat{\beta}$$
