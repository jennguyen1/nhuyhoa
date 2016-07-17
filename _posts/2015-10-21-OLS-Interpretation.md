---
layout: post
title: "OLS: Interpretation of Model Results"
date: "October 21, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Beta Coefficients

## Continuous Variables


{% highlight r %}
y <- mtcars$mpg
x1 <- mtcars$wt
x2 <- mtcars$drat
m1 <- lm(y ~ x1 + x2)
{% endhighlight %}

With continuous variables, the $$ \beta $$ coefficient can be interpreted as the change in $$Y$$ for a unit increase in $$X$$, holding all other x-values constant. The corresponding test measures whether this effect is significantly different from $$0$$, after all other variables have been considered. 

Note that the interpretation of coefficients can be complicated with high collinearity. For example if $$x_1$$ is correlated with $$x_2$$, then increasing $$x_1$$ would lead to an increase of $$x_2$$ even when holding $$x_2$$ fixed. Thus it is important to examine multicollinearity among the covariates.


{% highlight r %}
summary(m1)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   30.290      7.318   4.139    0.000
## x1            -4.783      0.797  -6.001    0.000
## x2             1.442      1.459   0.989    0.331
{% endhighlight %}



{% highlight r %}
b4 <- predict(m1, data.frame(x1 = 1, x2 = 0))
after <- predict(m1, data.frame(x1 = 2, x2 = 0))
after - b4 # same as x1 coefficient
{% endhighlight %}



{% highlight text %}
##        1 
## -4.78289
{% endhighlight %}

Intercept terms are generally included in fitting a linear model. This intercept is interpreted as the expected value of $$Y$$ when all $$X$$'s are set to $$0$$. The intercept is a nuisance parameter, its signifiance is not important.


{% highlight r %}
summary(m1)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   30.290      7.318   4.139    0.000
## x1            -4.783      0.797  -6.001    0.000
## x2             1.442      1.459   0.989    0.331
{% endhighlight %}



{% highlight r %}
predict(m1, data.frame(x1 = 0, x2 = 0)) # same as intercept term
{% endhighlight %}



{% highlight text %}
##        1 
## 30.29037
{% endhighlight %}

### Excluding the Intercept Term
Removing the intercept term results in 

$$ Y = 0 + \beta_1 x_1 + \beta_2 x_2 $$ where $$ \beta_0 = 0 $$.

Thus when fitting a regression without an intercept, one assumes that the expected value of $$Y$$ when all $$X$$'s are $$0$$ is $$0$$. Doing so gives the model more degrees of freedom. However, care should be done in setting the intercept to $$0$$, as this may lead to errors in estimating the other coefficients. 

### Center and Scaling Features

Consider centering and scaling the data prior to fitting models. While interpretation of coefficients may change, the model is essentially the same model. 

In some cases it may not make sense to interpret the intercept when the predictors are set to zero. For example, consider the model $$Y = \alpha + \beta_1 * height + \beta_2 * weight$$. The intercept is the expected value of $$Y$$ when $$height$$ and $$weight$$ are set to $$0$$, but that isn't terribly useful. 

Now, consider the model where $$height$$ and $$weight$$ are centered around their respective means. Then the intercept is the expected value of $$Y$$ for the average $$height$$ and $$weight$$ (ie the average person). It is not always necessary to use the mean of the data. One can also center based on an understandable reference point. 

Coefficients may be easier to interpret when all features are standardized to a similar scale. Following standardization, the coefficients are interpreted in units of standard deviations with respect to the corresponding predictor. The intercept is the expected value of $$Y$$ when the predictors are at their mean values. 

## Categorical Variables

### Default Contrasts

{% highlight r %}
m2 <- lm(Petal.Length ~ Species, data = iris)
{% endhighlight %}

Linear models with categorical variables are converted into dummy variables. Coefficients rely some information about the expected value of $$Y$$ for that category. 

The intercept is interpreted as the expected value of $$Y$$ for the baseline variable. 


{% highlight r %}
summary(m2)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##                   Estimate Std. Error t value Pr(>|t|)
## (Intercept)          1.462      0.061  24.023        0
## Speciesversicolor    2.798      0.086  32.510        0
## Speciesvirginica     4.090      0.086  47.521        0
{% endhighlight %}



{% highlight r %}
baseline <- iris %>% 
  subset(Species == "setosa") %>% 
  summarise(v1 = mean(Petal.Length))
baseline # same as intercept term
{% endhighlight %}



{% highlight text %}
##      v1
## 1 1.462
{% endhighlight %}

The other coefficients represent the expected difference in $$Y$$ between the specified category and the baseline category. The corresponding test measures whether the expected value of $$Y$$ for the specified category and the baseline are significantly different from $$0$$.


{% highlight r %}
summary(m2)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##                   Estimate Std. Error t value Pr(>|t|)
## (Intercept)          1.462      0.061  24.023        0
## Speciesversicolor    2.798      0.086  32.510        0
## Speciesvirginica     4.090      0.086  47.521        0
{% endhighlight %}



{% highlight r %}
iris %>% # same as versicolor coefficient
  subset(Species == "versicolor") %>% 
  summarise(d = mean(Petal.Length) - baseline) 
{% endhighlight %}



{% highlight text %}
##      v1
## 1 2.798
{% endhighlight %}

**Excluding the Intercept**

When the intercept term is excluded, the coefficients are no longer relative comparisons. Instead, they are the expected value of $$Y$$ for that group. The test measures whether the mean is significant different from $$0$$, doesn't portray much meaning. Because of this, there is no meaning in running a linear model without an intercept for categorical covariates.


{% highlight r %}
m2a <- lm(Petal.Length ~ Species - 1, data = iris)
summary(m2a)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##                   Estimate Std. Error t value Pr(>|t|)
## Speciessetosa        1.462      0.061  24.023        0
## Speciesversicolor    4.260      0.061  69.998        0
## Speciesvirginica     5.552      0.061  91.228        0
{% endhighlight %}

### Polynomial Contrasts
When there are ordinal categorical variables, it is more useful to generate polynomial contrasts to assess linear, quadratic, and cubic trends among those ordered groups. The ordinal categorical variable should have levels that are equally spaced. 

For the example, consider simulated ordinal categorical variables.

{% highlight r %}
# make 3 equal sized ordered groups of Petal.Length
ord.Petal.Length <- cut(iris$Petal.Length, 3, ordered_result = TRUE)

# fit model
m3 <- lm(Sepal.Length ~ ord.Petal.Length, data = iris)
summary(m3)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##                    Estimate Std. Error t value Pr(>|t|)
## (Intercept)           5.864      0.040 146.590    0.000
## ord.Petal.Length.L    1.179      0.071  16.700    0.000
## ord.Petal.Length.Q   -0.058      0.068  -0.855    0.394
{% endhighlight %}
Here there is a strong linear effect of $$ord.Petal.Length$$ with $$Sepal.Length$$. There is not a strong quadratic effect of $$ord.Petal.Length$$ with $$Sepal.Length$$.

## Continuous and Categorical Variables

{% highlight r %}
m4 <- lm(Sepal.Length ~ Petal.Length*Species, data = iris)
summary(m4)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##                                Estimate Std. Error t value Pr(>|t|)
## (Intercept)                       4.213      0.407  10.341    0.000
## Petal.Length                      0.542      0.277   1.959    0.052
## Speciesversicolor                -1.806      0.598  -3.017    0.003
## Speciesvirginica                 -3.154      0.634  -4.973    0.000
## Petal.Length:Speciesversicolor    0.286      0.295   0.969    0.334
## Petal.Length:Speciesvirginica     0.453      0.290   1.563    0.120
{% endhighlight %}

This is a model fit with both continuous variables (Petal.Length) and categorical variables (Species). Let's break down the regression formulas.

If $$Species == "setosa"$$:

-------------------|-----------------------------
$$ Sepal.Length $$ | $$ = \beta_0 + \beta_1 * Petal.Length $$
                   | $$ = 4.2 + 0.54 * Petal.Length $$


If $$Species == "versicolor"$$:

-------------------|-----------------------------
$$ Sepal.Length $$ | $$ = \beta_0 + \beta_1 * Petal.Length + \beta_2 + \beta_4 * Petal.Length $$
                   | $$ = (\beta_0 + \beta_2) + (\beta_1 + \beta_4) * Petal.Length $$
                   | $$ = (4.2 + -1.8) + (0.54 + 0.29) * Petal.Length $$

If $$Species == "virginica"$$:

-------------------|-----------------------------
$$ Sepal.Length $$ | $$ = \beta_0 + \beta_1 * Petal.Length + \beta_3 + \beta_5 * Petal.Length $$
                   | $$ = (\beta_0 + \beta_3) + (\beta_1 + \beta_5) * Petal.Length $$
                   | $$ = (4.2 + -3.2) + (0.54 + 0.45) * Petal.Length $$

Essentially there are 3 separate lines for each value of Species, the categorical variable. 

<img src="/nhuyhoa/figure/source/2015-10-21-OLS-Interpretation/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />

Perform hypothesis testing to determine whether the species have similar intercepts (no difference between the categories) and/or similar slopes (effect of continuous variable is the same for all categories) for Petal Length, thereby simplifying the model. 

### Excluding the Intercept


{% highlight r %}
m4a <- lm(Sepal.Length ~ Petal.Length*Species - 1, data = iris)
summary(m4a)$coefficients %>% round(3)
{% endhighlight %}



{% highlight text %}
##                                Estimate Std. Error t value Pr(>|t|)
## Petal.Length                      0.542      0.277   1.959    0.052
## Speciessetosa                     4.213      0.407  10.341    0.000
## Speciesversicolor                 2.408      0.438   5.493    0.000
## Speciesvirginica                  1.060      0.486   2.181    0.031
## Petal.Length:Speciesversicolor    0.286      0.295   0.969    0.334
## Petal.Length:Speciesvirginica     0.453      0.290   1.563    0.120
{% endhighlight %}

Removing the intercept terms results in 

If $$Species == "setosa"$$: <br>
$$ Sepal.Length = 4.2 + 0.54 * Petal.Length $$

If $$Species == "versicolor"$$: <br>
$$ Sepal.Length = 2.4 + (0.54 + 0.29) * Petal.Length $$

If $$Species == "virginica"$$: <br>
$$ Sepal.Length = 1.1 + (0.54 + 0.45) * Petal.Length $$

This is essentially the same equations as the previous model.

It is important to note even though both models generate similar regression lines, the overall model diagnostics ($$R^2$$, F statistic) will be different because the model is different.

## Interaction Terms
An interaction relates to the relationship among 2 or more variables. It occurs when the simultaneous influence of two variables on a third is not additive. In other words, the effect of one predictor on the response is different for different levels of another predictor. When interactions are significant the main effects cannot be interpreted alone. This is known as the **hierarchical principle**. 

Consider the example above. The effect of $$Petal.Length$$ on $$Sepal.Length$$ are the same for every $$Species$$, ie the slopes are the same. In this case, there is no (significant) interaction between $$Species$$ and $$Petal.Length$$. If the slopes were different, the effect of $$Petal.Length$$ on $$Sepal.Length$$ were different for different species.

Another example is genetic risk factors and diet on diabetes. Unhealthy diets have been shown to have an effect on diabetes, but that effect is more severe if one has a gene with high risk for developing diabetes. 

Interaction effects can be examined with interaction plots. The idea here is to plot $$Y$$ against one effect grouped by the other effect. Here's an example.
<img src="/nhuyhoa/figure/source/2015-10-21-OLS-Interpretation/unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" />

If the interaction term is significant, there would be parallel lines. Here the lines are parallel at low doses, so the effect of the dosage is the same for both supplements. However at higher does the lines are not parallel, so the effect of dosage is not the same for the two supplements.


## Analysis of Variance

The basic idea here is to compare the variance accounted for by the covariates to the variance of the error, by computing the test statistic $$F = \frac{SS_R/df_R}{SS_E/df_E} $$, where $$SS_R$$ and $$df_R$$ are the sums of squares and degrees of freedom accounted for by the covariates and $$SS_E$$ and $$df_E$$ are the sums of squares and degrees of freedom of the error. Recall that this is the $$ F $$ distribution with $$ df_R, df_E $$ degrees of freedom. Use this distribution to determine if the ratio observed is too great to be due to chance.

Consider a simple case, where the responses are continuous and the covariates are categorical. 


{% highlight r %}
# fit model
m <- lm(Petal.Length ~ Species, data = iris)
# anova table
anova(m)
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Response: Petal.Length
##            Df Sum Sq Mean Sq F value    Pr(>F)    
## Species     2 437.10 218.551  1180.2 < 2.2e-16 ***
## Residuals 147  27.22   0.185                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}

Here the $$F$$ statistic, a ratio of the mean square errors, is too big to be due to chance with a p-value < 0.05. This means that the variability accounted for by the $$Species$$ variable is significantly greater than the variability of the error (unexplained variability). Another way to say this is that the variability between $$Species$$ is significantly greater than the pooled variability within treatments, assuming all treatments have equal variance. 

This basic case is known as single-factor ANOVA. The procedures here can be extended to any model, with categorical or continuous variables. 

Consider the follow model:

{% highlight r %}
# fit model
m <- lm(Sepal.Length ~ Petal.Length * Species, data = iris)
# anova table
anova(m)
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Response: Sepal.Length
##                       Df Sum Sq Mean Sq  F value    Pr(>F)    
## Petal.Length           1 77.643  77.643 685.8998 < 2.2e-16 ***
## Species                2  7.843   3.922  34.6441 5.206e-13 ***
## Petal.Length:Species   2  0.381   0.190   1.6828    0.1895    
## Residuals            144 16.301   0.113                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}

The results of an analysis of variance table should be read in a certain order. 
  
* 1st row: variance accounted for by $$Petal.Length$$ is significantly greater than the unexplained variance
* 2nd row: after $$Petal.Length$$ has been taken into consideration, the variance accounted for by $$Species$$ is signficantly greater than the unexplained variance
* 3rd row: after $$Petal.Length$$ and $$Species$$ have been taken into consideration, the variance accounted for by the interaction of $$Petal.Length$$ and $$Species$$ is not significantly different than the variance of the error

These extensions from the basic case are known as ANCOVA (analysis of covariance), MANOVA (multivariate analysis of variance), and MANCOVA (multivariate analysis of variance). They can all be assessed with linear models using the summary table or anova table in R.

# Intervals Around Fitted Values

## Confidence Intervals
Recall $$ Y_* = x_*\beta $$

Let $$ x'_* = (1, x_{0*}, ..., x_{*p}) $$ 

The expected value of Y is <br>
$$ E(Y) = \hat{Y}_* = x'_*\hat{\beta} $$

The variance of the estimate is

----------------------|-------------------
$$ Var(\hat{Y}_*) $$  | $$= Var(x'_*\hat{\beta})$$ 
                      | $$= x'_*Var(\hat{\beta})x_* $$
                      | $$= \sigma^2x'_*(X'X)^{-1}x_* $$

thus $$ \hat{Y}_*  \sim  N(x'_*\hat{\beta}, \sigma^2x'_*(X'X)^{-1}x_*) $$

So the $$100(1-\alpha)$$% confidence interval is

$$ \hat{Y}_* \pm t_{n-p-1, \alpha/2} \sqrt{MSE} \sqrt{x'_*(X'X)^{-1}x_*} $$

In R: `predict(object, newdata, interval = "confidence")`

## Prediction Intervals
To predict new values, additional error is incurred. <br>
$$ Y_0 = x'_0\beta + \epsilon_0 $$

Assume that $$ e_0  \sim  N(0, \sigma^2) $$ and $$ e_0 \perp \hat{Y}_0 $$ 
Let $$ x'_0 = (1, x_{00}, ..., x_{0p}) $$

The expected value of Y is <br>
$$ E(Y) = \hat{Y}_0 + 0 = x'_0\hat{\beta} $$

The variance of the estimate is

----------------------|-------------------
$$ Var(\hat{Y}_0) $$  | $$ = Var(x'_0\hat{\beta} + \epsilon) $$
                      | $$ = \sigma^2x'_0(X'X)^{-1}x_0 + \sigma^2 $$
                      | $$ = \sigma^2 (x'_0(X'X)^{-1}x_0 + 1) $$

Thus the $$100(1-\alpha)$$% confidence interval is

$$ \hat{Y}_* \pm t_{n-p-1, \alpha/2} \sqrt{MSE} \sqrt{x'_*(X'X)^{-1}x_* + 1} $$

Let's assess the assumptions. Linear regression assumes that $$ e_0  \sim  N(0, \sigma^2) $$ and $$ e_0 \perp \hat{Y}_0 $$. 

$$ e_0 = Y_0 - \hat{Y}_0 $$ <br>
$$ cov(e_0, \hat{Y}_0) = cov(Y - \hat{Y}_0, \hat{Y}_0) = cov(Y_0 - HY_0, HY_0) $$ <br>
where $$ H = X(X'X)^{-1}X' $$ or the projection matrix.

----------------------------|--------------------
$$ cov(Y_0(I - H), HY_0) $$ | $$ = cov(Y_0, HY_0) + cov(-HY_0, HY_0) $$
                            | $$ = H Var(Y_0) - Var(\hat{Y}_0) $$ 
                            | $$ = H \sigma^2 - \sigma^2X'_0(X'X)^{-1}X_0 $$
                            | $$ = \sigma^2 (H - H) $$
                            | $$ = 0 $$
                               
Thus, $$ e_0 \perp \hat{Y}_0 $$ and the above prediction interval is correct.

In R: `predict(object, newdata, interval = "prediction")`

## Example
The plot below displays the fitted line (black), 95% confidence interval (blue), and 95% prediction intervals (green) for the estimated Y. Notice that the prediction intervals are much wider than the confidence intervals to account for prediction error. Also note that the bands are tighter around the $$\bar{x}$$ and wider at points farther away from $$\bar{x}$$. 

<img src="/nhuyhoa/figure/source/2015-10-21-OLS-Interpretation/unnamed-chunk-16-1.png" title="plot of chunk unnamed-chunk-16" alt="plot of chunk unnamed-chunk-16" style="display: block; margin: auto;" />

