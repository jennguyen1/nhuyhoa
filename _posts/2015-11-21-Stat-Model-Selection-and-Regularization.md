---
layout: post
title: "Model Selection & Regularization"
date: "November 21, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Subset Selection

## Model Statistics: Adj R2, AIC, BIC, Mallow's Cp
A variety of different statistics can be used to compare models. Software will have functions to compute these statistics. These statistics should be used as guidelines, domain knowledge is always more important for determining which terms should be a part of the model.

When comparing model statistics, the underlying data should be the same across those models. For example, one cannot compare a model with and without an outlier using these statistics.

**Values:**

* .$$Adj.R^2 = 1 - \frac{SS_R/(n-p)}{SS_T/(n-1)}$$
* .$$AIC = -2 l(\hat{\beta}, y) + 2p$$
* .$$BIC = -2 l(\hat{\beta}, y) + \log(n)p$$
* $$Cp = \frac{CSS}{s^2} + 2p - n$$ where $$s^2$$ is the MSE of the most complex model


* Bigger values of adjusted $$R^2$$ is better
* Smaller values AIC and BIC are better
* Values of Mallow's Cp closer to p is better
* BIC tends to choose smaller models than AIC
* AIC works better when all candidate models are approximate
* BIC works better when one candidate model is really the right model and sample sizes are large

## Forward, Backwards, Stepwise Selection
These model selection methods uses model statistics, such as AIC or overall F-statistic, to compare models. 

* Best subsets selection: given a $$p$$, find best model with $$p$$ parameters based on criteria 
* Forward selection: start with the null model, add covariates one by one based on criteria until a stopping criteria is met
* Backwards selection: start with the full model, remove covariates one by one based on criteria until a stopping criteria is met
* Stepwise selection: combination of forward and stepwise selection based on criteria until a stopping criteria is met

These methods can be implemented in R with the `step()` or `regsubsets()` function (The latter provides more options).

# Shrinkage Methods, Regularization
Shrinkage methods regularizes coefficient estimates and shrinks those coefficient estimates towards zero. Shrinking the estimates can significantly reduce variance and provide a better fit. 

The package `glmnet` is a great resource on fitting regularization models in R. See the package [viginette][glmnet_vignette]{:target="blank"}. 



## Ridge Regression
In ridge regression, the values of $$\hat{\beta}_{ridge}$$ are found by minimizing the equation

$$\sum^n_{i = 1} (y_i - \beta_0 - \sum^p_{j = 1} \beta_j x_{ij})^2 + \lambda \sum^p_{j = 1} \beta_j^2 = RSS + \lambda \sum^p_{j = 1} \beta^2_j$$

where $$\lambda \ge 0$$ is a tuning parameter, chosen via cross-validation. 

Or equivalently minimize
$$ \sum^n_{i = 1} (y_i-\beta_0-\sum^p_{j = 1} \beta_j x_{ij})^2 $$ subject to $$\sum^p_{j = 1} \beta^2 \le s$$.

Then 

$$ \hat{\beta}_{ridge} = (X'X + \lambda I_p)^{-1} X'Y $$

The term $$\lambda \Sigma_j \beta^2_j$$ is a shrinkage penalty; it is small when the $$\beta$$ estimates are close to zero. The tuning parameter $$\lambda$$ controls the impact of shrinkage.

* $$\lambda = 0$$, have OLS coefficient estimates
* $$\lambda \rightarrow \infty$$, coefficients approach 0, ie the null model
* Increasing $$\lambda$$ decreases variance, but increases bias (bias variance tradeoff)

**Important Notes:**

* Ridge regression uses the $$l_2$$ norm, otherwise defined as $$\sqrt{\Sigma_{j = 1}^p \beta^2_j}$$ (euclidian distance)
* Shrink the $$\beta$$ coefficients, not the intercept parameter
* Ridge regression coefficients are sensitive to scale (the $$\lambda \Sigma_j \beta^2_j$$ term), so standardize the covariates prior to applying ridge regression (good to standardize y responses too)

**Advantages:**

* Ridge regression works best when OLS has high variance, $$p >> n$$, high multicollinearity
* If a group of covariates are highly correlated, they will have similar estimated coefficients (group selection)

**Disadvantages:**

* Ridge regression does not perform model selection

**Example:**

{% highlight r %}
sim_ridge_cv <- cv.glmnet(X, Y, alpha = 0)

# MSE vs log(lambda)
plot(sim_ridge_cv)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Stat-Model-Selection-and-Regularization/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

{% highlight r %}
# coefficients for lambda with the smallest cross-validated MSE
m <- glmnet(X, Y, alpha = 0, lambda = sim_ridge_cv$lambda.min)
m$beta
{% endhighlight %}



{% highlight text %}
## 10 x 1 sparse Matrix of class "dgCMatrix"
##              s0
## V1   1.80990964
## V2  -3.67613266
## V3  -0.05713566
## V4   0.02331129
## V5  -0.00649756
## V6  -0.03693205
## V7   0.11064738
## V8   0.05256531
## V9   0.03613080
## V10 -0.05908619
{% endhighlight %}



{% highlight r %}
# coefficient plot
plot(glmnet(X,Y,alpha=0),xvar="lambda",label=T)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Stat-Model-Selection-and-Regularization/unnamed-chunk-3-2.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />
Notice how as $$\lambda$$ increases, the coefficients are shrunk towards 0 (but not necessarily equal to 0).

## Lasso Regression
In lasso regression, the values of $$\hat{\beta}_{lasso}$$ are found by minimizing the equation

$$\sum^n_{i = 1} (y_i - \beta_0 - \sum^p_{j = 1} \beta_j x_{ij})^2 + \lambda \sum^p_{j = 1} \vert\beta_j \vert = RSS + \lambda \sum^p_{j = 1} \vert\beta_j \vert$$

where $$\lambda \ge 0$$ is a tuning parameter, chosen via cross-validation. 

Or equivalently minimize
$$ \sum^n_{i = 1} (y_i-\beta_0-\sum^p_{j = 1} \beta_j x_{ij})^2 $$ subject to $$\sum^p_{j = 1} \vert \beta \vert \le s$$.

The term $$\lambda \Sigma_j \vert \beta_j \vert$$ is a shrinkage penalty. The tuning parameter $$\lambda$$ controls the impact of shrinkage. Lasso is different from ridge because it can shrink the coefficient estimates to zero when $$\lambda$$ is large. Thus lasso regression can perform variable selection.

**Important Notes:**

* Ridge regression uses the $$l_1$$ norm, otherwise defined as $$\Sigma_{j = 1}^p \vert \beta_j \vert$$ (manhattan distance)
* Shrink the $$\beta$$ coefficients, not the intercept parameter
* Lasso regression coefficients are sensitive to scale (the $$\lambda \Sigma_j \vert \beta_j \vert$$ term), so standardize the covariates prior to applying lasso regression (good to standardize y responses too)

**Advantages:**

* Lasso regression works best when OLS has high variance
* Can perform variable selection

**Disadvantages:**

* When there is a group of highly collinear covariates, LASSO selects one variable and ignores the others
* When $$p > n$$, LASSO can only select at most $$n$$ variables

**Example:**

{% highlight r %}
sim_lasso_cv <- cv.glmnet(X, Y, alpha = 1)

# MSE vs log(lambda)
plot(sim_lasso_cv)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Stat-Model-Selection-and-Regularization/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

{% highlight r %}
# coefficients for lambda with the smallest cross-validated MSE
m <- glmnet(X, Y, alpha = 1, lambda = sim_lasso_cv$lambda.min)
m$beta
{% endhighlight %}



{% highlight text %}
## 10 x 1 sparse Matrix of class "dgCMatrix"
##               s0
## V1   1.967695383
## V2  -4.009847561
## V3   .          
## V4   .          
## V5   .          
## V6   .          
## V7   0.050922575
## V8   0.001028827
## V9   .          
## V10  .
{% endhighlight %}



{% highlight r %}
# coefficient plot
plot(glmnet(X,Y,alpha=1),xvar="lambda",label=T)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Stat-Model-Selection-and-Regularization/unnamed-chunk-4-2.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />
Notice how as $$\lambda$$ increases, the coefficients are shrunk directly towards 0.

## Elastic Net
Elastic net is an approach that blends both the $$l_2$$ and $$l_1$$ norm. In elastic net, the objective is to minimize the equation
$$ argmin_{\beta} \vert y - X \beta \vert^2 $$

subject to $$(1 - \alpha) * \sum^p_{j = 1} \vert \beta_j \vert + \alpha * \sum^p_{j = 1} \beta^2_j \le t $$ for some $$t$$ (elastic net penalty) where $$ \alpha = \frac{\lambda_2}{\lambda_1 + \lambda_2}$$, chosen by cross-validation.

* When $$\alpha = 1$$, have ridge regression
* When $$\alpha = 0$$, have LASSO regression
* When $$\alpha \in (0, 1)$$, have a mix of ridge and LASSO

Note that since elastic net is a hybrid of ridge and LASSO, the covariates should be scaled prior to fitting the model (good to standardize y responses too).


[glmnet_vignette]: https://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html
