---
layout: post
title: "GLM: Logistic Regression"
date: "November 26, 2015"
categories: statistics
---

* TOC
{:toc}



# Binomial Response
Suppose the response $$Y_i$$ ~ $$Bin(n_i, p_i)$$ and the $$Y_i$$ are independent.
$$ P(Y_i = y_i) = \left(\begin{array}
{rrr}
  n \\
  y
\end{array}\right) \mu^y (1-\mu)^{n - y} $$

We face a few problems when our response variable has a binomial distribution. 

* $$Var(Y) = n \mu (1 - \mu)$$, which is not constant
* $$\mu = p$$ is bounded: $$0 \le p \le 1$$ but OLS may predict probabilities beyond this

There are a number of common link functions for binomial data. We want a link function $$\eta_i = g(p_i)$$ such that $$0 \le g^{-1}(\eta) \le 1 \forall \eta$$. 

* Logit: $$\eta = log \left( \frac{p}{1 - p} \right)$$
* Probit: $$\eta = \Phi^{-1}(p)$$
* Complementary log-log: $$\eta = log(-log(1 - p))$$

All of these link functions differ mostly at the tails. We will use the logit because it is easure to intepret using odds.

# Logistic Regression Model

We fit the model
$$log \left( \frac{p}{1 - p} \right) = \beta_0 + \beta_1 x_1 + ... \beta_p x_p$$

We can fit this model in R like so

{% highlight r %}
mod <- glm(cbind(damage, 6 - damage) ~ temp, data = orings, family = binomial)
{% endhighlight %}

Here we provide two pieces of information regarding the response. The first column of the matrix is the number of successes, $$y$$. The second column is the number of failures, $$n - y$$. 

Here we see a graphical representation of the data and how well it fits the data. 
<img src="/nhuyhoa/figure/source/2015-11-26-GLM-Logistic-Regression/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

# Model Evaluation
Assessing model fit can be done using deviance. See [GLM: Hypothesis Testing & Diagnostics][glm_diagnostic_link]{:target="blank"}.

# Understanding Output

{% highlight r %}
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

# Beta Coefficients

## Confidence Intervals
The $$100(1 - \alpha)$$% confidence interval for $$\hat{\beta}_i$$ is 

$$\hat{\beta}_i \pm z_{\alpha /2} se(\hat{\beta}_i)$$

## Interpreting Using Odds
The logit link function is otherwise known as log odds. Odds are often used to express the payoff for bets; it is a ratio of the probability for success vs the probability of failure. 

We have the following relationships:

$$ o = \frac{p}{1 - p} $$

$$ p = \frac{o}{1 + o} $$

where $$p$$ is the probability of success and $$o$$ is the odds. 

Odds provide a simple interpretation of the $$\hat{\beta}$$ coefficients in logistic regression. 
$$log(odds \vert x_1 = x + 1) = \beta_0 + \beta_1 (x + 1) + ... + \beta_p x_p$$
$$log(odds \vert x_1 = x) = \beta_0 + \beta_1 x + ... + \beta_p x_p$$

Then 
$$ log(odds \vert x_1 = x + 1) - log(odds \vert x_1 = x) = \beta_1 $$
$$ log \left( \frac{odds \vert x_1 = x + 1}{odds \vert x_1 = x} \right) = \beta_1 $$
$$ \frac{odds \vert x_1 = x + 1}{odds \vert x_1 = x} = e^{\beta_1} $$

Thus we can interpret the $$\beta_1$$ coefficient as follows: holding all other covariates constant, a unit increase in $$x_1$$ increases the odds of success by a factor of exp $$\beta_1$$.

# Prediction Confidence Intervals
For a given set $$ x_0 $$, we can predict the reponse.

Procedure:

* Compute point estimate: $$ \hat{\eta} = x_0 \hat{\beta} $$
* From R we can extract the variance matrix of the coefficients: `m$cov.unsealed`
* Compute variance: $$ var(\hat{\eta}) = x'_0 (X'WX)^{-1} x_0$$
* Compute confidence interval: $$ exp \left( \hat{\eta} \pm z_{\alpha/2} \sqrt{var(\hat{\eta})} \right)$$

We can also use built in R functions:

* Predict $$\hat{\eta}$$: `predict(object, newdata, type = "link")`
* Predict $$\hat{\mu}$$: `predict(object, newdata, type = "response")`

# Effective Dose 
We can find the $$x$$ value in which there is a $$50$$% chance of success. 

One variable case:
$$log \left( \frac{0.5}{1 - 0.5} \right) = \beta_0 + \beta_1 x_1 $$
$$ 0 = \beta_0 + \beta_1 x_1 $$
$$ x_1 = -\frac{\beta_0}{\beta_1} $$

Multiple variables:
$$log \left( \frac{0.5}{1 - 0.5} \right) = \beta_0 + \beta_1 x_1 + ... + \beta_p x_p$$
$$ 0 = \beta_0 + \beta_1 x_1 + ... + \beta_p x_p $$
$$ x_1 = -\frac{\beta_0 + \beta_2 x_2 + ... + \beta_p x_p}{\beta_1} $$

To determine the standard error of this estimate, we can use the delta method. 

$$ var[g(\hat{\theta})] = g'(\hat{\theta})' var[\hat{\theta}] g'(\hat{\theta}) $$

We can also use the built in R function: `MASS::dose.p()`

[glm_diagnostic_link]: http://jnguyen92.github.io/nhuyhoa//2015/11/GLM-Testing-and-Diagnostics.html

