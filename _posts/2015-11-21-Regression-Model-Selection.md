---
layout: post
title: "Regression: Model Selection"
date: "November 21, 2015"
categories: statistics
---

* TOC
{:toc}



# Bias Variance Tradeoff
Recall from the diagnostics post underfitting (important variables are not included) and overfitting (unnecessary models are included). With all models, we want to minimize the error, which is a function of bias and variance of our model.
$$ E[y_i - \hat{f}(x_i)]^2 = Var[\hat{f}(x_i)] + Bias[\hat{f}(x_i)]^2 + Var[\epsilon] $$

* Variance: the amount by which $$\hat{f}(x_i)$$ would change if it was estimated with different testing data
* Bias: error from approximating real life problem to simple models

When models are do not contain enough important variables (underfitted), bias tends to be high and variance low. When models contain too many unecessary variables (overfitted), variance tends to be high and bias low. Thus we have what is called the bias-variance tradeoff. We want to choose a model such that the average test error is minimized, while taking into account both the bias and the variance.

# Training & Testing Error
To understand the effectiveness of cross validation, we need to make a distinction between the training error and the test error.

* Training error: error that results from prediction using the data that generated the model 
* Test error: error that results from prediction using new data, data the model has not yet seen

Training error tends to decrease as we introduce more flexibility to the model (overfitting). Thus training data can severely underestimate the testing error. Thus testing error should always be used as the model selection metric.

Consider the following plot of prediction error against model complexity. As the model gets increasingly complex, training error decreases, even beyond the baseline error. Testing error intially decreases due to reduction of bias, but then increases due to increased variability.
<img src="/nhuyhoa/figure/source/2015-11-21-Regression-Model-Selection/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

# Subset Selection

## Model Statistics: Adj R2, AIC, BIC, Mallow's Cp
We can use a variety of different statistics to compare models. Software will have functions to compute these statistics. These statistics should be used as guidelines, domain knowledge is always more important.

* Bigger values of adjusted $$R^2$$ is better
* Smaller values AIC and BIC are better
* Values of Mallow's Cp closer to p is better

Values:

* .$$Adj.R^2 = 1 - \frac{SS_R/(n-p)}{SS_T/(n-1)}$$
* .$$AIC = -2 l(\hat{\beta}, y) + 2p$$
* .$$BIC = -2 l(\hat{\beta}, y) + 2log(n)p$$
* $$Cp = \frac{CSS}{s^2} + 2p - n$$ where $$s^2$$ is the MSE of the most complex model.

## Forward, Backwards, Stepwise Selection
These model selection methods uses model statistics, such as AIC or overall F-statistic, to compare models. 

* Best subsets selection: given a p, find best model with p parameters based on criteria 
* Forward selection: start with the null model, add covariates one by one based on criteria until a stopping criteria is met
* Backwards selection: start with the full model, remove covariates one by one based on criteria until a stopping criteria is met
* Stepwise selection: combination of forward and stepwise selection based on criteria until a stopping criteria is met

# Cross Validation
The cross-validation procedure can be used to select the model which minimizes error. The CV error is compared across different models to select the one with the smallest CV error. 

Procedure:

* Randomly divide data into $$K$$ equal-sized parts, usually $$K = 5$$ or $$10$$
* Leave part $$k$$ out and fit the model to the other $$k - 1$$ parts combined
* Using the fitted model, obtain predictions for left out $$k$$ part and compute the error
* Repeat for all $$k$$
* Combine the results from all partitions, usually with a weighted average
* Compare the cross-validated metric across different models to find the best model parameters
* Refit the model based on the best model parameters using all of the data

# Shrinkage Methods, Regularization
Shrinkage methods regularizes coefficient estimates and shrinks those coefficient estimates towards zero. Shrinking the estimates can significantly reduce variance and provide a better fit. 




## Ridge Regression
In ridge regression, we find the values of $$\hat{\beta}_{ridge}$$ such that we minimize the equation
$$\Sigma^n_{i = 1} (y_i - \beta_0 - \Sigma^p_{j = 1} \beta_j x_{ij})^2 + \lambda \Sigma^p_{j = 1} \beta_j^2 = RSS + \lambda \Sigma^p_{j = 1} \beta^2_j$$

where $$\lambda \ge 0$$ is a tuning parameter, chosen via cross-validation. 

Then we get
$$ \hat{\beta}_{ridge} = (X'X + \lambda I_p)^{-1} X'Y $$

The term $$\lambda \Sigma_j \beta^2_j$$ is a shrinkage penalty; it is small when the $$\beta$$ estimates are close to zero. The tuning parameter $$\lambda$$ controls the impact of shrinkage.

* $$\lambda = 0$$, have OLS coefficient estimates
* $$\lambda \rightarrow \infty$$, coefficients approach 0, ie the null model
* Increasing $$\lambda$$ decreases variance, but increases bias (bias variance tradeoff)

Important Notes:

* Ridge regression uses the $$l_2$$ norm, otherwise defined as $$\sqrt{\Sigma_{j = 1}^p \beta^2_j}$$
* While we shrink the $$\beta$$ coefficients, we do not shrink the intercept parameter
* Ridge regression coefficients are sensitive to scale (the $$\lambda \Sigma_j \beta^2_j$$ term), so we must standardize the covariates prior to applying ridge regression
* Ridge regression works best when OLS has high variance

Example:

{% highlight r %}
sim_ridge_cv <- cv.glmnet(X, Y, alpha = 0)

# MSE vs log(lambda)
plot(sim_ridge_cv)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Regression-Model-Selection/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

{% highlight r %}
# coefficients for lambda with the smallest cross-validated MSE
m <- glmnet(X, Y, alpha = 0, lambda = sim_ridge_cv$lambda.min)
m$beta
{% endhighlight %}



{% highlight text %}
## 10 x 1 sparse Matrix of class "dgCMatrix"
##               s0
## V1   1.825228643
## V2  -3.706062022
## V3  -0.054764815
## V4   0.023413320
## V5  -0.005635995
## V6  -0.036991355
## V7   0.109822472
## V8   0.051801318
## V9   0.035288399
## V10 -0.055343783
{% endhighlight %}



{% highlight r %}
# coefficient plot
plot(glmnet(X,Y,alpha=0),xvar="lambda",label=T)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Regression-Model-Selection/unnamed-chunk-4-2.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />
Notice how as $$\lambda$$ increases, the coefficients are shrunk towards 0 (but not necessarily equal to 0).

## Lasso Regression
In lasso regression, we find the values of $$\hat{\beta}_{lasso}$$ such that we minimize the equation
$$\Sigma^n_{i = 1} (y_i - \beta_0 - \Sigma^p_{j = 1} \beta_j x_{ij})^2 + \lambda \Sigma^p_{j = 1} \vert\beta_j \vert = RSS + \lambda \Sigma^p_{j = 1} \vert\beta_j \vert$$

where $$\lambda \ge 0$$ is a tuning parameter, chosen via cross-validation. 

The term $$\lambda \Sigma_j \vert \beta_j \vert$$ is a shrinkage penalty. The tuning parameter $$\lambda$$ controls the impact of shrinkage. Lasso is different from ridge because it can shrink the coefficient estimates to zero when $$\lambda$$ is large. Thus lasso regression can perform variable selection.

Important Notes: 

* Ridge regression uses the $$l_1$$ norm, otherwise defined as $$\Sigma_{j = 1}^p \vert \beta_j \vert$$
* While we shrink the $$\beta$$ coefficients, we do not shrink the intercept parameter
* Lasso regression coefficients are sensitive to scale (the $$\lambda \Sigma_j \vert \beta_j \vert$$ term), so we must standardize the covariates prior to applying lasso regression
* Lasso regression works best when OLS has high variance and we want to perform variable selection

Example:

{% highlight r %}
sim_lasso_cv <- cv.glmnet(X, Y, alpha = 1)

# MSE vs log(lambda)
plot(sim_lasso_cv)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-Regression-Model-Selection/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

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

<img src="/nhuyhoa/figure/source/2015-11-21-Regression-Model-Selection/unnamed-chunk-5-2.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />
Notice how as $$\lambda$$ increases, the coefficients are shrunk directly towards 0.

## Elastic Net

# Dimension Reduction Techniques

## Principle Components

## Partial Least Squares Regression
