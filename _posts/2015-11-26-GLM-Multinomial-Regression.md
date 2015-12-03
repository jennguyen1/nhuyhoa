---
layout: post
title: "GLM: Multinomial Regression"
date: "November 26, 2015"
categories: statistics
---

* TOC
{:toc}



# Nomial Regression
Let {$$\pi_1, ... \pi_J$$} denote the response probabilities satisfying $$\Sigma_j\pi_j = 1$$. With $$n$$ independent observations the probability distribution for the number of outcomes of the $$J$$ types is the multinomial.
$$P(Y_{i1} = y_{i1}, ..., Y_{iJ} = y_{iJ}) = \frac{n_i}{y_{i1}! ... y_{iJ}!} \pi^{y_{i1}}_{i1}...\pi^{y_{iJ}}_{iJ}$$

where $$J$$ denotes the number of categories for $$Y$$.  Nomial regression is just an extension of binomial logistic regression. 

## Interpreting Models and Coefficients
When the last category ($$J$$) is the baseline, the baseline-cateogry logits with predictor $$x$$ are

$$ log(\pi_i/\pi_1) = \beta_{i0} + \beta_{i1} x_1 + ... + \beta_{ip} x_p$$

where $$i = 2,..., J$$. There are $$J-1$$ equations, with separate parameters for each. (When $$J = 2$$, model simplifies to the ordinary logistic regression for binary responses).  

Another way to look at this is via the link function

$$\eta_{ij} = x'_i \beta_j = log \left( \frac{\pi_{ij}}{\pi_{i1}} \right) $$

To compare two categories where neither is the baseline, we can do some simple rearrangements.

$$ log\left( \frac{\pi_a}{\pi_b} \right) = log\left( \frac{\pi_a/\pi_1}{\pi_b/\pi_1} \right) = log\left( \frac{\pi_a}{\pi_1} \right) - log\left( \frac{\pi_b}{\pi_1} \right)$$
$$ = (\alpha_a + \beta_a * x) - (\alpha_b + \beta_b * x) $$
$$ = (\alpha_a - \alpha_b) + (\beta_a - \beta_b)*x $$

where $$(\alpha_a - \alpha_b)$$ is the intercept parameter with slope parameter $$(\beta_a - \beta_b)$$ for the new comparison. 

Interpretation of coefficients is identical to logistic regression case. For example, the equation
$$log\left( \frac{\pi_a}{\pi_b} \right) = \alpha + \beta_1 x_1 + ... + \beta_p + x_p$$

Holding all other covariates constant, a unit increase in $$x_i$$ will lead to an increase in odds of falling into category $$a$$ over category $$b$$ by a factor of $$exp(\beta_i)$$.

## Estimating Response Probabilities
Similar to logistic regression to estimate response probabilities, we have

$$ \hat{\pi}_i = \frac{exp(\eta_{ij})}{1 + \Sigma^J_{j = 2} exp(\eta_{ij})}$$

where $$\Sigma_i \pi_i = 1$$ and $$\eta_{i1} = 0$$. 

We can also do this in R:

* Response probabilities: `predict(mod, newdata, type = "probs")`
* Class: `predict(mod, newdata, type = "class")`

## Example
With this example, we examine how aligator length can be used to predict the gator's food choice. 

{% highlight r %}
ggplot(data = gator, aes(x = choice, y = length)) + 
  geom_boxplot() +
  xlab("Food Choice") + ylab("Length") + 
  ggtitle("Gator Length vs Food Choice")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-26-GLM-Multinomial-Regression/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />
From the boxplot, we see a trend in food choice and gator length.

So let's fit a multinomial model.

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

From this, we get the multinomial equations 
$$ log(\pi_O/\pi_F) = -1.618 + 0.1101x $$
$$ log(\pi_I/\pi_F) = 4.089 - 2.3553x $$

Thus we can use both these equations to calculate  
$$log(\pi_O/\pi_I) = log(\pi_O/\pi_F) - log(\pi_I/\pi_F) $$
$$ = (-1.618 + 0.1101x) - (4.089 - 2.3553x) $$
$$ = -5.707 + 2.4654x$$

For the alligators of length $$x + 1$$ meters, the estimated odds that primary food type is "invertebrate" rather than "fish" equal $$exp(-2.3553) = 0.0945$$ times the estimated odds at length $$x$$ meters.  

Note: to switch the odds (go from $$\pi_1/\pi_2$$ to $$\pi_2/\pi_1$$) just switch the signs of the equation on the RHS.  

Original equation:
$$ log(\pi_1/\pi_2) = \alpha_1 + \beta_1x $$ 

Flipped equation:
$$ log(\pi_2/\pi_1) = log( (\pi_1/\pi_2)^{-1} ) = -log(\pi_1/\pi_2) = -\alpha_1 + -\beta_1x $$ 


We can also compute the response probabilities using the equation above. 
$$ \hat{\pi}_O = \frac{exp(-1.618 + 0.1101x)}{1 + exp(-1.618 + 0.1101x) + exp(4.089 - 2.3553x)} $$
$$ \hat{\pi}_I = \frac{exp(4.089 - 2.3553x)}{1 + exp(-1.618 + 0.1101x) + exp(4.089 - 2.3553x)} $$
$$ \hat{\pi}_F = \frac{1}{1 + exp(-1.618 + 0.1101x) + exp(4.089 - 2.3553x)} $$

These probabilities can be used to plot the probabilities of various food preferences in gators across lengths.

<img src="/nhuyhoa/figure/source/2015-11-26-GLM-Multinomial-Regression/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


# Ordinal Regression
With ordinal categorical variables, we will discuss the proportional odds logistic regression model, which can account for ordering using cumulative probabilities.

A cumulative probability for $$Y$$ is the probability that $$Y$$ falls at or below a particular point. For outcome category $$j$$, the cumulative probability is 

$$P(Y \le j) = p_1 + ... + p_j $$ 

where $$j = 1, ..., J - 1$$. 

The cumulative probabilities reflect the ordering, with 

$$ P(Y \le 1) \le P(Y \le 2) \le ... \le P(Y \le J) = 1$$

The logits of cumulative probabilities are

$$ logit \big[ P(Y \le j) \big] = log \left( \frac{P(Y \le j)}{1 - P(Y \le j)} \right) = log \left( \frac{p_1 + ... p_j}{p_{j + 1} + ... + p_J} \right)$$

## Interpreting Models and Coefficients
For ordinal categorical variables, we have the model

$$ logit \big[ P(Y \le j ) \big] = \theta_j + x' \beta $$

where $$j = 1,...,J-1$$ and where $$\beta$$ describes the effect of $$x$$ on the log odds of response in category j or below. This model assumes that the effect of $$x$$ is identical for all $$J-1$$ cumulative logits. In other words, we would have parallel cumulative probability lines. 

For example, assume we have 3 ordered categories and 2 predictors. Thus, we would have

$$ logit \big[ P(Y \le 1 ) \big] = \alpha_1 + \beta_1 x_1 + \beta_2 x_2$$
$$ logit \big[ P(Y \le 2 ) \big] = \alpha_2 + \beta_1 x_1 + \beta_2 x_2$$
$$ logit \big[ P(Y \le 3 ) \big] = 1 $$

The intercept $$\alpha_j$$ is the log-odds of falling into or below category $$j$$ for $$x_1 = x_2 = 0$$. 

The slope parameter $$\beta_k$$ can be interpreted as so: holding all other covariates constant, a unit increase in $$x_k$$ increases the odds of falling into or below any category by a factor of $$exp(\beta_k)$$. 

We can also obtain $$P(Y = j)$$ with $$P(Y = j) = P(Y \le j) - P(Y \le j - 1)$$.

When $$\beta > 0$$, we have cumulative probability plots similar to the one below.

![cumulative probabilities in proportional odds model][cum_prob_prop_odds_model]

When $$\beta < 0$$, the curves in Figure 6.2 descend rather than ascend.

## Estimating Response Probabilities
To obtain the response probabilities, we have

$$ P(Y \le j) = \frac{exp(\theta + \beta' x_i)}{1 + exp(\theta_j + \beta' x_i)}$$ 

## Example


{% highlight r %}
# package to fit model
library(MASS)

# fit model
mod2 <- polr(sPID ~ nincome, nes96)
summary(mod2)
{% endhighlight %}



{% highlight text %}
## Call:
## polr(formula = sPID ~ nincome, data = nes96)
## 
## Coefficients:
##           Value Std. Error t value
## nincome 0.01312   0.001971   6.657
## 
## Intercepts:
##                        Value   Std. Error t value
## Democrat|Independent    0.2091  0.1123     1.8627
## Independent|Republican  1.2916  0.1201    10.7526
## 
## Residual Deviance: 1995.363 
## AIC: 2001.363
{% endhighlight %}

We have the models

$$logit(P(Y \le Democrat)) = 0.2091 + 0.01323 x$$
$$logit(P(Y \le Independent)) = 1.2916 + 0.01323 x$$

The interpretation of $$\beta$$ here is the same as in logistic regression. The odds of moving from Democrat to Independent/Republican (or from Democrat/Independent to Republican) increases by a factor of $$exp(0.01312) = 1.0132$$ as income increases by one unit. 

If we set $$income = 0$$, we can find the baseline probabilities of the classes. 

For the democrat class,
$$P(Y \le Dem) = P(Y = Dem) = ilogit(0.209) =$$ 0.5520606

For the independent class,
$$P(Y \le Ind) = P(Y \le Ind) - P(Y \le Dem) = ilogit(1.292) - ilogit(0.209) =$$ 0.2324249

And for the republican class, 
$$P(Y = Rep) = 1 - P(Y \le Ind) = 1 - ilogit(1.292) =$$ 0.2155145

To test the proportional odds assumption, we can compute the observed odds proportions with respect to income levels. 

{% highlight r %}
# log-odds difference between P(Y <= 1) and P(Y <= 2)
pim <- prop.table(table(nes96$nincome, nes96$sPID), 1)
y <- logit(pim[,1]) - logit(pim[,1] + pim[,2]) 
plot(y)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-26-GLM-Multinomial-Regression/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />
The assumption of constant proportions is questionable, but at least there is no noticable trends. 

# Model Testing and Diagnostics
Similar to other glms, we can use deviance and the likelihood ratio test to compare two models. 

[cum_prob_prop_odds_model]: /figure/images/cum_probs_prop_odds_model.png
