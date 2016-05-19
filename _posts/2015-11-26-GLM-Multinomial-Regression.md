---
layout: post
title: "GLM: Multinomial Regression"
date: "November 26, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Nomial Regression
Let {$$\pi_1, ... \pi_J$$} denote the response probabilities satisfying $$\Sigma_j\pi_j = 1$$. With $$n$$ independent observations the probability distribution for the number of outcomes of the $$J$$ types is the multinomial.

$$P(Y_{i1} = y_{i1}, ..., Y_{iJ} = y_{iJ}) = \frac{n_i}{y_{i1}! ... y_{iJ}!} \pi^{y_{i1}}_{i1}...\pi^{y_{iJ}}_{iJ}$$

where $$J$$ denotes the number of categories for $$Y$$.  Nomial regression is just an extension of binomial logistic regression. 

## Interpreting Models and Coefficients
When the last category ($$J$$) is the baseline, the baseline-cateogry logits with predictor $$x$$ are

$$ \log(\pi_i/\pi_1) = \beta_{i0} + \beta_{i1} x_1 + ... + \beta_{ip} x_p$$

where $$i = 2,..., J$$. There are $$J-1$$ equations, with separate parameters for each. (When $$J = 2$$, model simplifies to the ordinary logistic regression for binary responses).  

Another way to look at this is via the link function

$$\eta_{ij} = x'_i \beta_j = \log \left( \frac{\pi_{ij}}{\pi_{i1}} \right) $$

To compare two categories where neither is the baseline, do some simple rearrangements

--------------------------------------------|-------------------------------------
$$ \log\left( \frac{\pi_a}{\pi_b} \right)$$ | $$ = \log\left( \frac{\pi_a/\pi_1}{\pi_b/\pi_1} \right) = \log\left( \frac{\pi_a}{\pi_1} \right) - \log\left( \frac{\pi_b}{\pi_1} \right)$$
                                            | $$ = (\alpha_a + \beta_a * x) - (\alpha_b + \beta_b * x) $$
                                            | $$ = (\alpha_a - \alpha_b) + (\beta_a - \beta_b)*x $$

where $$(\alpha_a - \alpha_b)$$ is the intercept parameter with slope parameter $$(\beta_a - \beta_b)$$ for the new comparison. 

Interpretation of coefficients is identical to logistic regression case. For example, the equation <br>
$$\log\left( \frac{\pi_a}{\pi_b} \right) = \alpha + \beta_1 x_1 + ... + \beta_p + x_p$$

Holding all other covariates constant, a unit increase in $$x_i$$ will lead to an increase in odds of falling into category $$a$$ over category $$b$$ by a factor of $$exp(\beta_i)$$.

## Estimating Response Probabilities
Similar to logistic regression to estimate response probabilities

$$ \hat{\pi}_i = \frac{exp(\eta_{ij})}{1 + \sum^J_{j = 2} exp(\eta_{ij})}$$

where $$\Sigma_i \pi_i = 1$$ and $$\eta_{i1} = 0$$. 

In R, do this with

* Response probabilities: `predict(mod, newdata, type = "probs")`
* Class: `predict(mod, newdata, type = "class")`

## Example
This example examines how aligator length can be used to predict the gator's food choice. 

{% highlight r %}
ggplot(data = gator, aes(x = choice, y = length)) + 
  geom_boxplot() +
  xlab("Food Choice") + ylab("Length") + 
  ggtitle("Gator Length vs Food Choice")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-26-GLM-Multinomial-Regression/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />
From the boxplot, there is a trend in food choice and gator length.

So fit a multinomial model.

{% highlight r %}
# package to fit multinomial models
library(nnet)

# fit model
mod1 <- multinom(choice ~ length, data = gator)
{% endhighlight %}



{% highlight text %}
## # weights:  9 (4 variable)
## initial  value 64.818125 
## iter  10 value 49.170710
## final  value 49.170622 
## converged
{% endhighlight %}



{% highlight r %}
summary(mod1)
{% endhighlight %}



{% highlight text %}
## Call:
## multinom(formula = choice ~ length, data = gator)
## 
## Coefficients:
##   (Intercept)     length
## I    4.079701 -2.3553303
## O   -1.617713  0.1101012
## 
## Std. Errors:
##   (Intercept)    length
## I    1.468640 0.8032870
## O    1.307274 0.5170823
## 
## Residual Deviance: 98.34124 
## AIC: 106.3412
{% endhighlight %}

The multinomial equations <br>
$$ \log(\pi_O/\pi_F) = -1.618 + 0.1101x $$ <br>
$$ \log(\pi_I/\pi_F) = 4.089 - 2.3553x $$

Use both these equations to calculate  

----------------------|-----------------------------------
$$\log(\pi_O/\pi_I)$$ | $$ = \log(\pi_O/\pi_F) - \log(\pi_I/\pi_F) $$
                      | $$ = (-1.618 + 0.1101x) - (4.089 - 2.3553x) $$
                      | $$ = -5.707 + 2.4654x$$

For the alligators of length $$x + 1$$ meters, the estimated odds that primary food type is "invertebrate" rather than "fish" equal $$exp(-2.3553) = 0.0945$$ times the estimated odds at length $$x$$ meters.  

Note: to switch the odds (go from $$\pi_1/\pi_2$$ to $$\pi_2/\pi_1$$) just switch the signs of the equation on the RHS.  

Original equation: <br>
$$ \log(\pi_1/\pi_2) = \alpha_1 + \beta_1x $$ 

Flipped equation: <br>
$$ \log(\pi_2/\pi_1) = \log( (\pi_1/\pi_2)^{-1} ) = -\log(\pi_1/\pi_2) = -\alpha_1 + -\beta_1x $$ 


Compute the response probabilities using the equation above 
$$ \hat{\pi}_O = \frac{exp(-1.618 + 0.1101x)}{1 + exp(-1.618 + 0.1101x) + exp(4.089 - 2.3553x)} $$ <br>
$$ \hat{\pi}_I = \frac{exp(4.089 - 2.3553x)}{1 + exp(-1.618 + 0.1101x) + exp(4.089 - 2.3553x)} $$ <br>
$$ \hat{\pi}_F = \frac{1}{1 + exp(-1.618 + 0.1101x) + exp(4.089 - 2.3553x)} $$

These probabilities can be used to plot the probabilities of various food preferences in gators across lengths.

<img src="/nhuyhoa/figure/source/2015-11-26-GLM-Multinomial-Regression/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

In SAS, multinomial models can be fit like so

{% highlight r %}
proc logistic;
  # reset the baseline categories
  class color (ref = "F") / param = ref;
  # set the model 
  model choice = length color / link = glogit;
run;

proc catmod; response logits; direct length;
  model choice = length / pred = freq;
run;
{% endhighlight %}


# Ordinal Regression
With ordinal categorical variables, use the proportional odds logistic regression model, which can account for ordering using cumulative probabilities.

A cumulative probability for $$Y$$ is the probability that $$Y$$ falls at or below a particular point. For outcome category $$j$$, the cumulative probability is 

$$P(Y \le j) = p_1 + ... + p_j $$ 

where $$j = 1, ..., J - 1$$. 

The cumulative probabilities reflect the ordering, with 

$$ P(Y \le 1) \le P(Y \le 2) \le ... \le P(Y \le J) = 1$$

The logits of cumulative probabilities are

$$ logit \big[ P(Y \le j) \big] = \log \left( \frac{P(Y \le j)}{1 - P(Y \le j)} \right) = \log \left( \frac{p_1 + ... p_j}{p_{j + 1} + ... + p_J} \right)$$

## Interpreting Models and Coefficients
For ordinal categorical variables

$$ logit \big[ P(Y \le j ) \big] = \theta_j - x' \beta $$

where $$j = 1,...,J-1$$ and where $$\beta$$ describes the effect of $$x$$ on the log odds of response in category j or below. This model assumes that the effect of $$x$$ is identical for all $$J-1$$ cumulative logits. In other words, there would be parallel cumulative probability lines. 

Because the covariate terms are subtracted, the $$\beta$$s are interpreted with respect to the $$\log \left( \frac{P(Y > j)}{P(Y \le j)} \right)$$ instead of $$\log \left( \frac{P(Y \le j)}{P(Y > j)} \right)$$.

For example, assume there are 3 ordered categories and 2 predictors. Thus

$$ logit \big[ P(Y \le 1 ) \big] = \alpha_1 - \beta_1 x_1 - \beta_2 x_2$$ <br>
$$ logit \big[ P(Y \le 2 ) \big] = \alpha_2 - \beta_1 x_1 - \beta_2 x_2$$ <br>
$$ logit \big[ P(Y \le 3 ) \big] = 1 $$

The intercept $$\alpha_j$$ is the log-odds of falling into or below category $$j$$ for $$x_1 = x_2 = 0$$. 

Obtain $$P(Y = j)$$ with $$P(Y = j) = P(Y \le j) - P(Y \le j - 1)$$.

The slope parameter $$\beta_k$$ can be interpreted as so: holding all other covariates constant, a unit increase in $$x_k$$ increases the odds of above any category by a factor of $$exp(\beta_k)$$. Another way to interpret this is holding all other covariates constant, a unit increase in $$x_k$$ increases the odds of falling into or below any category by a factor of $$exp(-\beta_k)$$. (See diagram below, available in An Introduction to Categorical Data Analysis, Agresti).

![Cumulative proportional odds model](http://jnguyen92.github.io/nhuyhoa/figure/images/cum_probs_prop_odds_model.png)

## Estimating Response Probabilities
To obtain the response probabilities

$$ P(Y \le j) = \frac{exp(\theta - \beta' x_i)}{1 + exp(\theta_j - \beta' x_i)}$$ 

## Example


{% highlight r %}
# package to fit model
library(MASS)

# fit model
mod2 <- polr(response ~ cheese, weights = N, data = cheese)
summary(mod2)
{% endhighlight %}



{% highlight text %}
## Call:
## polr(formula = response ~ cheese, data = cheese, weights = N)
## 
## Coefficients:
##          Value Std. Error t value
## cheeseB -3.352     0.4287  -7.819
## cheeseC -1.710     0.3715  -4.603
## cheeseD  1.613     0.3805   4.238
## 
## Intercepts:
##     Value    Std. Error t value 
## 1|2  -5.4674   0.5236   -10.4413
## 2|3  -4.4122   0.4278   -10.3148
## 3|4  -3.3126   0.3700    -8.9522
## 4|5  -2.2440   0.3267    -6.8680
## 5|6  -0.9078   0.2833    -3.2037
## 6|7   0.0443   0.2646     0.1673
## 7|8   1.5459   0.3017     5.1244
## 8|9   3.1058   0.4057     7.6547
## 
## Residual Deviance: 711.3479 
## AIC: 733.3479
{% endhighlight %}
One thing to note is that R fits the model $$\log \left( \frac{P(Y \le j)}{P(Y > j)} \right) = \theta_j - x' \beta$$. This affects how the $$\beta$$ coefficients are interpreted.

For the cheese variable, the baseline dummy is $$A$$. The coefficient for $$cheeseB = -3.352$$. The responses are ordered 1 - 9, with bigger numbers indicating better responses. Thus interpret the $$cheeseB$$ coefficient as so: <br>
$$\frac{odds.B.better}{odds.A.better} = exp(\beta_{cheeseB}) = exp(−3.352) = 0.035$$ 

The odds that cheese B is ranked "better" is $$0.035$$ times the odds that cheese A is ranked "better". Therefore cheese A is preferred over cheese B. The t-value is relatively big in magnitude so this difference in preference is significant. Also note that this ranking holds over all responses, due to the proportional odds assumption. That is, cheese A is preferred over cheese B regardless of whether "better" is a response cutoff of 3 or 7 (or any other value). Similar comparisons can be done for other cheese types. 

Use the results to generate the individual equations. <br>
$$ \log \left( \frac{P(Y \le 1)}{P(Y > 1)} \right) = -5.4674 - - 3.352X_1 - - 1.710X_2 - 1.613X_3) $$ <br>
$$ \log \left( \frac{P(Y \le 2)}{P(Y > 2)} \right) = -4.4122 - - 3.352X_1 - - 1.710X_2 - 1.613X_3) $$ <br>
$$...$$ <br>
$$ \log \left( \frac{P(Y \le 8)}{P(Y > 8)} \right) = 3.1058 - - 3.352X_1 - - 1.710X_2 - 1.613X_3) $$

Note that the intercept specified by the model is added, but the $$\beta$$ coefficients are subtracted

Calculate individual probabilities at the baseline cheese (A):

For $$response = 1$$ <br>
$$P(Y = 1) = P(Y \le 1) = ilogit(-5.4674) = 0.0042$$

For $$response = 2$$ <br>
$$P(Y = 2) = P(Y \le 2) - P(Y \le 1) = ilogit(-4.4122) - ilogit(-5.4674) = 0.00778$$

For $$response = 3$$ <br>
$$P(Y = 3) = P(Y \le 3) - P(Y \le 2) = ilogit(-3.3126) - ilogit(-4.4122) = 0.023$$

For $$response = 9$$ <br>
$$P(Y = 9) = 1 - P(Y \le 8) = 1 - ilogit(3.1058) = 0.0429$$

In SAS, ordinal logistic models are fit as so

{% highlight r %}
proc logistic;
  class cheese(ref = '0') / param = reference;
  model response = cheese;
run;

proc catmod; weight count; response clogits;
  model response = _response_ cheese / p = freq;
run;
{% endhighlight %}


## Other Topics
The model discussed here assumed proportional odds. Thus it is important to assess whether this assumption is valid (along with other assumptions). If this assumption is wrong, then different models that don't make this assumption should be fit. 

The `VGAM` package is an additional resource that has functions for fitting multinomial models. 

# Model Testing and Diagnostics
Testing and diagnostics is similar to other glms. See [GLM Testing and Diagnostics][glm_diagnostics_post]{:target = "blank"}

[glm_diagnostics_post]: http://jnguyen92.github.io/nhuyhoa//2015/11/GLM-Testing-and-Diagnostics.html
