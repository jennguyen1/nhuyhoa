---
layout: post
title: "GLM: Poisson Regression"
date: "November 27, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Count Response
Suppose the response $$Y_i$$ ~ $$Pois(\mu_i)$$ where $$\mu > 0$$ and the $$Y_i$$ are independent

$$P(Y_i = y_i) = \frac{e^{\mu_i} \mu_i^{y_i}}{y_i!}$$

We also have $$E(Y_i) = Var(Y_i) = \mu_i$$

From this we can compute the deviance

$$ D = 2 \sum^n_{i = 1} \big[ y_i \log \left( \frac{y_i}{\hat{\mu}_i} \right)  - (y_i - \hat{\mu}_i) \big] $$

We face a problem when our response variable has a Poisson distribution. 

* $$Var(Y) = \mu$$, which is not constant
* $$\mu > 0$$: but OLS may predict values less than zero

To alleviate these concerns, we can use a link function $$\eta_i = g(\mu) = \log(\mu)$$ such that $$g^{-1}(\eta) > 0$$ $$\forall \eta$$.

Several instances can be classified as Poisson:

* Count is some number out of some possible total, response is binomial. Poisson is good approximation if success probability is small
* If the probability of an event occuring in a given time interval is proportional to the length of that time interval and independent of other events. The number of events in any specified time interval is Poisson
* When the time between events is independent and identically exponentially distributed. The count of events in a given time period is Poisson

# Poisson Regression Model

## Modeling Counts
We fit the model

$$ \log(\mu) = \beta_0 + \beta_1 x_1 + ... + \beta_k x_k$$

We can fit this model in R like so

{% highlight r %}
glm(counts ~ ., data = data, family = poisson)
{% endhighlight %}

## Modeling Ratios
If we have ratios and the proportions are small, we can use Poisson regression rather than logistic regression. We fit the model <br>
$$\log \left( \frac{count}{total} \right) = \beta_0 + \beta_1 x_1 + ... \beta_k x_k$$ <br>
$$ \log(count) = \log(total) + \beta_0 + \beta_1 x_1 + ... \beta_k x_k $$

We can fit this model in R like so

{% highlight r %}
glm(counts ~ offset(log(total)) + ., family = poisson, data = data)
{% endhighlight %}
The function `offset()` means to not fit a coefficient to a term (or set the coefficient to 1). In this model $$total = cells$$.

# Beta Coefficients

## Interpretation of Coefficients
Interpretation of coefficients is similar to the logistic regression case. 

------------------------------|---------------------
$$\log(y \vert x_1 = x + 1)$$ | $$ = \beta_0 + \beta_1 (x + 1) + ... + \beta_k x_k$$
$$\log(y \vert x_1 = x) $$    | $$ = \beta_0 + \beta_1 x + ... + \beta_k x_k$$

Then 

-----------------------------------------------------------|---------------------
$$ \log(y \vert x_1 = x + 1) - \log(odds \vert x_1 = x) $$ | $$ = \beta_1 $$
$$ \log \left( \frac{y \vert x_1 = x + 1}{y \vert x_1 = x} \right)$$ | $$ = \beta_1 $$
$$ \frac{y \vert x_1 = x + 1}{y \vert x_1 = x} $$          | $$ = e^{\beta_1} $$
$$ (y \vert x_1 = x + 1) $$                                | $$= e^{\beta_1} * (y \vert x_1 = x)$$

Holding all other predictors constant, a unit increase in $$x_i$$ increases the count by a factor of $$exp(\hat{\beta}_i)$$

# Overdispersion
Overdispersion occurs in poisson regression when $$Var(Y_i)$$ is greater than the assumed $$Var(Y_i) = \mu_i $$. With Poisson models, one can visually assess whether there might be overdispersion by plotting $$(y - \hat{\mu})^2$$ vs $$\mu$$ with the identity line. Overdispersion would result in a plot where the majority of points are above the identity line, indicating $$Var(Y) > E(Y)$$. 

The method to adjust for overdispersion involves multiplying the variance by a factor $$\sigma^2$$ to obtain <br>
$$Var(Y_i)^* = \sigma^2 \mu_i $$

The steps for assessing overdispersion are listed in the [GLM Testing and Diagnostics: Overdispersion][glm_diagnostics_post]{:target = "blank"}.

## Negative Binomial Regression
One alternative to the Poisson regression with overdispersion is negative binomial regression. The response $$Z$$ is assumed to follow a negative binomial distribution with $$Z$$ being the number of trials until the $$k^{th}$$ success 

$$P(Z = z) = \left(\begin{array}
{rrr}
z - 1\\
k - 1
\end{array}\right)
p^k (1 - p)^{z - k}
$$

where $$ z > k$$, $$p$$ is the probability of success.

This equation can be rewritten if we let $$Y = Z - k$$ and $$p = (1 + \alpha)^{-1}$$

$$P(Y = y) = \left(\begin{array}
{rrr}
y + k - 1\\
k - 1
\end{array}\right)
\frac{\alpha^y}{(1 + \alpha)^{y + k}}$$

where $$E(Y) = k\alpha = \mu$$ and $$Var(Y) = k\alpha + k\alpha^2 = \mu + D\mu^2$$. The parameter $$D = 1/k$$ is called the dispersion parameter.

The negative binomial regression model is

$$\eta = \log \left( \frac{\mu}{\mu + k} \right) = x \beta$$

Greater heterogeneity in Poisson resulting in overdispersion results in a larger value of $$D$$. As $$D \rightarrow 0$$, $$Var(Y) \rightarrow \mu$$ and the negative binomial and Poisson regression gives the same inference. 

To fit a negative binomial function in R:

{% highlight r %}
# load package
library(MASS)

# fit model
mod <- glm.nb(skips ~ ., solder)
summary(mod)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## glm.nb(formula = skips ~ ., data = solder, init.theta = 4.397157245, 
##     link = log)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.7376  -1.0068  -0.3834   0.4460   2.7829  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -1.42245    0.14274  -9.965  < 2e-16 ***
## OpeningM     0.50294    0.07976   6.306 2.87e-10 ***
## OpeningS     1.91317    0.07152  26.750  < 2e-16 ***
## SolderThin   0.93932    0.05362  17.517  < 2e-16 ***
## MaskA3       0.58981    0.09651   6.112 9.87e-10 ***
## MaskA6       2.26734    0.10182  22.269  < 2e-16 ***
## MaskB3       1.21101    0.09637  12.566  < 2e-16 ***
## MaskB6       1.99037    0.09223  21.580  < 2e-16 ***
## PadTypeD6   -0.46592    0.11238  -4.146 3.38e-05 ***
## PadTypeD7   -0.03315    0.10673  -0.311 0.756114    
## PadTypeL4    0.38268    0.10265   3.728 0.000193 ***
## PadTypeL6   -0.57844    0.11413  -5.068 4.01e-07 ***
## PadTypeL7   -0.36656    0.11094  -3.304 0.000953 ***
## PadTypeL8   -0.15890    0.10821  -1.468 0.141986    
## PadTypeL9   -0.56600    0.11393  -4.968 6.77e-07 ***
## PadTypeW4   -0.20044    0.10873  -1.844 0.065255 .  
## PadTypeW9   -1.56460    0.13621 -11.486  < 2e-16 ***
## Panel        0.16369    0.03139   5.214 1.85e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for Negative Binomial(4.3972) family taken to be 1)
## 
##     Null deviance: 4043.3  on 899  degrees of freedom
## Residual deviance: 1008.3  on 882  degrees of freedom
## AIC: 3683.3
## 
## Number of Fisher Scoring iterations: 1
## 
## 
##               Theta:  4.397 
##           Std. Err.:  0.495 
## 
##  2 x log-likelihood:  -3645.309
{% endhighlight %}
Here we see that $$\hat{k} = 4.4$$ with a standard error of 0.5. 

[glm_diagnostics_post]: http://jnguyen92.github.io/nhuyhoa//2015/11/GLM-Testing-and-Diagnostics.html#overdispersion
