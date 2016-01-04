---
layout: post
title: "OLS: Diagnostics"
date: "November 13, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}




# What Can Go Wrong in Linear Regression

* Underfitting: important variables are not included
* Overfitting: unnecessary variables are included
* Error terms are not independent (check with resids vs fitted plot)
* Error terms are not normally distributed (check with QQ normal plot)
* Error terms do not have the same variance $$\sigma^2$$ (check with resids vs fitted plot)
* Influential points lead to generation of inaccurate model
* Multicollinearity leads to generation of inaccurate model

# Underfitting & Overfitting

## Underfitting
Suppose the true model is $$ Y = X\beta + Z\gamma + \epsilon $$ and we fit the model $$ Y = X\beta + \epsilon $$. 

When we underfit, our estimates for $$\hat{\beta}$$ and $$\hat{\sigma}^2$$ are both biased. 
Because of the bias variance trade off, the $$Var[\hat{\beta}]$$ gets smaller.

## Overfitting
Suppose the true model is $$ Y = \beta_1 X_1  + \epsilon $$ and we fit the model $$ Y = \beta_1 X_1 + \beta_2 X_2 + \epsilon $$.

When we over fit, our estimate of $$\hat{\beta}_1$$ is unbiased, but $$Var[\hat{\beta}_1]$$ is bigger.


# Outliers

## Observations with High Residuals
Residuals are defined as 
$$ \hat{\epsilon}_i = y_i - \hat{y}_i $$

Internally standardized residuals are defined as
$$ r_i = \frac{\hat{\epsilon}_i }{\hat{\sigma \sqrt{1 - h_{ii}}}}$$ 

where $$\frac{r_i^2}{n - p}$$ ~ $$Beta(\frac{1}{2}, \frac{1}{2}(n - p - 1))$$

Externally standardized residuals (jackknife residuals) are defined as 
$$ t_i = \frac{\hat{\epsilon}_i }{\hat{\sigma}_{(i)} \sqrt{1 - h_{ii}}}$$ 

where $$(i)$$ represents the estimate with the $$i^{th}$$ entry deleted. If $$ \vert t_i \vert > 2$$, we consider that a large residual.

Notice that residuals refer to extreme $$y$$-values. 

## Observations with High Leverage Values
Recall the hat matrix $$ H = X(X'X)^{-1}X' $$. $$H$$ is invariate to scale and location transformations of the columns of X.

Leverage is the diagonals of the hat matrix and defined as 

.$$ h_i = \frac{1}{n} + (n - 1)^{-1}(x_i - \bar{x})'S^{-1}(x_i - \bar{x}) $$ 

where $$x_i$$ is the column vector of the $$i^{th}$$ row of X and $$S = \frac{\sum (x_i - \bar{x})(x_i - \bar{x})'}{n - 1} $$ is the sample covariance matrix.

Notice that leverage refers to extreme $$x$$-values. 

## Influential Points and Outliers
An influental point is an observation that has substantial influence on regression, such that its removal would greatly affect the regression line.  

An outlier is an extreme point that does not fit in with the rest of the data.

Influential points and outliers are closely related, and both are affected by residual and leverage values. However, they are not synonymous.

## Cook's Distance and DFFITS
Cook's Distance measures the influence of the $$i^{th}$$ observation on all of the fitted values of a linear model, by deleting that observation. 

It is defined as
$$ D_i = \sum \frac{(\hat{y}_j - \hat{y}_{j(i)})^2}{ps^2} $$

where $$ \hat{y}_{j(i)} $$ represents the fitted value for the $$j^{th}$$ observation when the $$i^{th}$$ observation is left out. 

For a general rule of thumb Cook's distance of $$D_i > 5$$ warrants further review, while $$D_i > 1$$ is more serious.

DFFITS is a measure of how much the $$i^{th}$$ fitted value changes when the $$i^{th}$$ observation is deleted. 

It is defined as 
$$ DFFITS_i = \frac{\hat{y}_i - \hat{y}_{i(i)}}{\hat{\sigma}_{(i)}\sqrt{H_{ii}}} $$

where $$._{(i)}$$ indicates that $$i^{th}$$ observation was not used in fitting the model. 

For small to medium data sets, a value greater than 1 warrants further review. For large data sets, a value greater than $$2 \sqrt{(p + 1) / n}$$ warrants further review. 

## DFBETAS
DFBETAS measures how much the coefficients change when the $$i^{th}$$ observation is deleted. 

It is defined as
$$ DFBETAS_{j(i)} = \frac{\hat{\beta}_j - \hat{\beta}_{j(i)}}{\sqrt{\hat{\sigma}^2_{(i)} (X'X)^{-1}_{jj}}} $$

where $$._{(i)}$$ indicates that $$i^{th}$$ observation was not used in fitting the model.

For small to medium data sets, a value greater than 1 warrants further review. For large data sets, a value greater than $$2 / \sqrt{n}$$ warrants further review. 

# Multicollinearity
Severe multicollinearity in regression can result in difficult interpretation of coefficients. The variance inflation factor is a measure of how much the variance of an estimate is increased due to collinearity with other estimates.

Recall,
$$Var[\hat{\beta}] = \hat{\sigma}^2 (X'X)^{-1}$$

The variance of $$\hat{\beta}_j$$ is 
$$Var[\hat{\beta}_j] = \frac{\sigma^2}{\sum^n_{i = 1} (x_{ij} - \bar{x}_j)^2} * \frac{1}{1 - R_j^2} $$

where $$R^2_j$$ is the $$R^2$$ value obtained by regressing the $$j^{th}$$ predictor on the remaining predictors. The greater the linear dependence of $$x_j$$ on the other predictors, the larger the $$R^2_j$$ and the $$var(\hat{\beta}_j)$$.

The variance inflation factor (VIF) is defined as 

$$VIF_j = \frac{1}{1 - R^2_j} $$

where $$VIF_j$$ is a measure of how much variance of the estimated coefficient is inflated due to collinearity with other predictor variables. 

A VIF of 1 indicates no correlation. VIFs greater than 5 are on the fence, further investigation should be done. A VIF exceeding 10 indicates serious multicollinearity and requires immediate intervention. 

# Diagnostic Plots

## How to Obtain Values in R
* Residuals: `residuals(m)`
* Internally standardized residuals: `rstandard(m)`
* Externally standardized residuals: `rstudent(m)`
* Leverage values: `hatvalues(m)`
* Cook's Distance: `cooks.distance(m)`
* DFFITS: `dffits(m)`
* DFBETAS: `dfbetas(m)`
* Influence statistics: `influence.measures(m)`
* Influence plot: `influencePlot(m)`
* Variance Inflation Factor: `vif(m)`

## Assess Independence:
Independence is generally difficult to test for. Generally scientific knowledge regarding the problem at hand should be used to assess independence of observations.

## Assess Linearity & Homoscedasticity: Residuals Vs Fitted Plots
Residuals vs fitted values plots are useful for assessing linearity and homoskedaskticity.

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />
Here we see that the plotted points are randomly distributed above and below 0. We can conclude that our assumptions of a linear relationship and equal variance were valid

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />
Here we see that our model does not have a linear relationship, indicated by the quadratic trend of our plot.

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />
Here we see a funneling pattern as we increase fitted values. This indicates that we have heteroskedaskticity or unequal variance. A transformation may be necessary to make the variances equal.

## Assess Normality: QQ Normal
To assess whether our errors are normally distributed, we can use a QQ Normal plot. See more information on how to interpret [QQ plots][qq_link]{:target="blank"}.

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />
Given an approximately linear trend, we can conclude that our errors are normally distributed.

## Assess Outliers: Residuals Vs. Leverage Plot
The residuals vs leverage plot can identify outliers in both x and y. In addition, these plots can incorporate Cook's distance to identify highly influential points. 

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />
There are no observations beyond a Cook's Distance of 0.5 or 1, so there is no concern for influential points.

## Assess Individual X Variables: Added Variable Plots
Also known as partial regression plots, added-variable plots are refined residual plots that provide graphic information about the marginal importance of predictor $$X_j$$, given that other variables are already in the model. 

To generate these plots, we graph the residual from the model $$Y$$ ~ $$X$$ (excluding $$X_j$$) vs. the residuals from the model $$X_j$$ ~ $$X$$. The y-axis is the y-variable after removing the effect of the x-variables (except $$X_j$$). The x-axis is $$X_j$$ after removing the effect of the other x-variables. Plotting these two residuals against each other gives us the effect of $$X_j$$ after other variables have been adjusted for, in other words, the coefficient of $$X_j$$ in the full model. 

We can use these plots to tell us whether we should to include $$X_j$$ in the model and whether a transformation of $$X_j$$ is necessary.


{% highlight r %}
# summary of data
head(trees)
{% endhighlight %}



{% highlight text %}
##   Girth Height Volume
## 1   8.3     70   10.3
## 2   8.6     65   10.3
## 3   8.8     63   10.2
## 4  10.5     72   16.4
## 5  10.7     81   18.8
## 6  10.8     83   19.7
{% endhighlight %}



{% highlight r %}
# fit the model for the y axis
m2 <- lm(Height ~ Girth, data = trees)
# fit the model for the x axis
m3 <- lm(Volume ~ Girth, data = trees)
# fit the full model
m1 <- lm(Height ~ Girth + Volume, data = trees)
coef(m1)
{% endhighlight %}



{% highlight text %}
## (Intercept)       Girth      Volume 
##  83.2957705  -1.8615109   0.5755946
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

Note that the slope of the plot and the coefficient for volume on the full model are the same. We interpret this plot to mean that the variable $$Volume$$ provides a meaningful contribution after already adjusting for $$Girth$$. Thus $$ Volume$$ should be added to the model.

There is also a function in R: `car::avPlots()` or `av.Plots()`

{% highlight r %}
car::avPlots(m1)
{% endhighlight %}



{% highlight text %}
## Warning: no function found corresponding to methods exports from
## 'SparseM' for: 'coerce'
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-13-OLS-Diagnostics/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

# Solutions to Violation of Assumptions

* Underfitting/overfitting: use model selection techniques to fit better models
* Error terms are not distributed $$N(0, \sigma^2)$$: perform transformations, such as the Box-Cox family of transformations
* Influential points: look into potential reasons (data entry error, scientific reason), fit model with and without the influential point and see if there is a difference, remove point
* Multicollinearity: remove variable(s)

[qq_link]: http://jnguyen92.github.io/nhuyhoa//2015/10/qqplots.html
