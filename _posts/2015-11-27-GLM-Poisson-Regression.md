---
layout: post
title: "GLM: Poisson Regression"
date: "November 27, 2015"
categories: statistics
---

* TOC
{:toc}



# Count Response
Suppose the response $$Y_i$$ ~ $$Pois(\mu_i)$$ where $$\mu > 0$$ and the $$Y_i$$ are independent
$$P(Y_i = y_i) = \frac{e^{\mu_i} \mu_i^{y_i}}{y_i!} \forall y_i = 0, 1, ... $$

We also have $$E(Y_i) = Var(Y_i) = \mu_i$$

From this we can compute the deviance
$$ D = 2 log \left( \frac{L_L}{L_S} \right) $$
$$ D = 2 \Sigma^n_{i = 1} \big[ y_i log \left( \frac{y_i}{\hat{\mu}_i} \right)  - (y_i - \hat{\mu}_i) \big] $$

We face a problem when our response variable has a Poisson distribution. 

* $$Var(Y) = \mu$$, which is not constant
* $$\mu > 0: but OLS may predict values less than zero

To alleviate these concerns, we can use a link function $$\eta_i = g(\mu) = log(\mu)$$ such that $$g^{-1}(\eta) > 0$$ $$\forall \eta$$.

Several instances can be classified as Poisson:

* If the count is some number out of some possible total, the response is binomial. But if the success probability is small and the total is big, then the Poisson is a good approximation
* If the probability of an event occuring in a given time interval is proportional to the lentgh of that time interval and independent of other events. The number of events in any specified time interval is Poisson
* When the time between events is independent and identically exponentially distributed. The count of events in a given time period is Poisson.

# Poisson Regression Model
We fit the model
$$ log(\mu) = \beta_0 + \beta_1 x_1 + ... + \beta_k x_k$$

We can fit this model in R like so

{% highlight r %}
glm(Species ~ ., data = g, family = poisson)
{% endhighlight %}

If we have ratios and the proportions are small, we can use Poisson regression rather than logistic regression. We fit the model
$$log \left( \frac{count}{total} \right) = \beta_0 + \beta_1 x_1 + ... \beta_k x_k$$
$$ log(count) = log(total) + \beta_0 + \beta_1 x_1 + ... \beta_k x_k $$

We can fit this model in R like so

{% highlight r %}
glm(ca ~ offset(log(cells)) + log(doserate)*dosef, family = poisson, dicentric)
{% endhighlight %}
The function `offset()` means to not fit a coefficient to a term (or set the coefficient to 1). In this model $$total = cells$$.

# Beta Coefficients

## Confidence Intervals
The $$100(1 - \alpha)$$% confidence interval for $$\hat{\beta}_i$$ is 

$$\hat{\beta}_i \pm z_{\alpha /2} se(\hat{\beta}_i)$$

# Predicted Values

## Prediction Confidence Intervals
For a given set $$ x_0 $$, we can predict the reponse.

Procedure:

* Compute point estimate: $$ \hat{\eta} = x_0 \hat{\beta} $$
* From R we can extract the variance matrix of the coefficients: `m$cov.unsealed`
* Compute variance: $$ var(\hat{\eta}) = x'_0 (X'WX)^{-1} x_0$$
* Compute confidence interval: $$ exp \left( \hat{\eta} \pm z_{\alpha/2} \sqrt{var(\hat{\eta})} \right)$$

We can also use built in R functions:

* Predict $$\hat{\eta}$$: `predict(object, newdata, type = "link")`
* Predict $$\hat{\mu}$$: `predict(object, newdata, type = "response")`

