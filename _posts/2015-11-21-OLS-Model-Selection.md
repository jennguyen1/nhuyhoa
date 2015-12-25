---
layout: post
title: "OLS: Model Selection"
date: "November 21, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Bias Variance Tradeoff
See [Bias Variance Tradeoff and Cross Validation: Bias Variance Tradeoff][bv_tradeoff_post]{:target = "_blank"}.

# Training & Testing Error
See [Bias Variance Tradeoff and Cross Validation: Training & Testing Error][bv_tradeoff_train_test_post]{:target = "_blank"}.

# Subset Selection

## Model Statistics: Adj R2, AIC, BIC, Mallow's Cp
We can use a variety of different statistics to compare models. Software will have functions to compute these statistics. These statistics should be used as guidelines, domain knowledge is always more important.

* Bigger values of adjusted $$R^2$$ is better
* Smaller values AIC and BIC are better
* Values of Mallow's Cp closer to p is better

Values:

* .$$Adj.R^2 = 1 - \frac{SS_R/(n-p)}{SS_T/(n-1)}$$
* .$$AIC = -2 l(\hat{\beta}, y) + 2p$$
* .$$BIC = -2 l(\hat{\beta}, y) + log(n)p$$
* $$Cp = \frac{CSS}{s^2} + 2p - n$$ where $$s^2$$ is the MSE of the most complex model.

## Forward, Backwards, Stepwise Selection
These model selection methods uses model statistics, such as AIC or overall F-statistic, to compare models. 

* Best subsets selection: given a p, find best model with p parameters based on criteria 
* Forward selection: start with the null model, add covariates one by one based on criteria until a stopping criteria is met
* Backwards selection: start with the full model, remove covariates one by one based on criteria until a stopping criteria is met
* Stepwise selection: combination of forward and stepwise selection based on criteria until a stopping criteria is met

# Cross Validation
See [Bias Variance Tradeoff and Cross Validation: Cross Validation][bv_tradeoff_cv_post]{:target = "_blank"}.

# Shrinkage Methods, Regularization
Shrinkage methods regularizes coefficient estimates and shrinks those coefficient estimates towards zero. Shrinking the estimates can significantly reduce variance and provide a better fit. 



## Ridge Regression
In ridge regression, we find the values of $$\hat{\beta}_{ridge}$$ such that we minimize the equation
$$\Sigma^n_{i = 1} (y_i - \beta_0 - \Sigma^p_{j = 1} \beta_j x_{ij})^2 + \lambda \Sigma^p_{j = 1} \beta_j^2 = RSS + \lambda \Sigma^p_{j = 1} \beta^2_j$$

where $$\lambda \ge 0$$ is a tuning parameter, chosen via cross-validation. 

Or equivalently we minimize
$$ \Sigma^n_{i = 1} (y_i-\beta_0-\Sigma^p_{j = 1} \beta_j x_{ij})^2 $$ subject to $$\Sigma^p_{j = 1} \beta^2 \le s$$.

Then we get
$$ \hat{\beta}_{ridge} = (X'X + \lambda I_p)^{-1} X'Y $$

The term $$\lambda \Sigma_j \beta^2_j$$ is a shrinkage penalty; it is small when the $$\beta$$ estimates are close to zero. The tuning parameter $$\lambda$$ controls the impact of shrinkage.

* $$\lambda = 0$$, have OLS coefficient estimates
* $$\lambda \rightarrow \infty$$, coefficients approach 0, ie the null model
* Increasing $$\lambda$$ decreases variance, but increases bias (bias variance tradeoff)

Important Notes:

* Ridge regression uses the $$l_2$$ norm, otherwise defined as $$\sqrt{\Sigma_{j = 1}^p \beta^2_j}$$ (euclidian distance)
* While we shrink the $$\beta$$ coefficients, we do not shrink the intercept parameter
* Ridge regression coefficients are sensitive to scale (the $$\lambda \Sigma_j \beta^2_j$$ term), so we must standardize the covariates prior to applying ridge regression (good to standardize y responses too)

Advantages:

* Ridge regression works best when OLS has high variance, $$p >> n$$, high multicollinearity
* If a group of covariates are highly correlated, they will have similar estimated coefficients (group selection)

Disadvantages:

* Ridge regression does not perform model selection

Example:

{% highlight r %}
sim_ridge_cv <- cv.glmnet(X, Y, alpha = 0)

# MSE vs log(lambda)
plot(sim_ridge_cv)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-OLS-Model-Selection/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

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

<img src="/nhuyhoa/figure/source/2015-11-21-OLS-Model-Selection/unnamed-chunk-3-2.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />
Notice how as $$\lambda$$ increases, the coefficients are shrunk towards 0 (but not necessarily equal to 0).

## Lasso Regression
In lasso regression, we find the values of $$\hat{\beta}_{lasso}$$ such that we minimize the equation
$$\Sigma^n_{i = 1} (y_i - \beta_0 - \Sigma^p_{j = 1} \beta_j x_{ij})^2 + \lambda \Sigma^p_{j = 1} \vert\beta_j \vert = RSS + \lambda \Sigma^p_{j = 1} \vert\beta_j \vert$$

where $$\lambda \ge 0$$ is a tuning parameter, chosen via cross-validation. 

Or equivalently we minimize
$$ \Sigma^n_{i = 1} (y_i-\beta_0-\Sigma^p_{j = 1} \beta_j x_{ij})^2 $$ subject to $$\Sigma^p_{j = 1} \vert \beta \vert \le s$$.

The term $$\lambda \Sigma_j \vert \beta_j \vert$$ is a shrinkage penalty. The tuning parameter $$\lambda$$ controls the impact of shrinkage. Lasso is different from ridge because it can shrink the coefficient estimates to zero when $$\lambda$$ is large. Thus lasso regression can perform variable selection.

Important Notes: 

* Ridge regression uses the $$l_1$$ norm, otherwise defined as $$\Sigma_{j = 1}^p \vert \beta_j \vert$$ (manhattan distance)
* While we shrink the $$\beta$$ coefficients, we do not shrink the intercept parameter
* Lasso regression coefficients are sensitive to scale (the $$\lambda \Sigma_j \vert \beta_j \vert$$ term), so we must standardize the covariates prior to applying lasso regression (good to standardize y responses too)

Advantages:

* Lasso regression works best when OLS has high variance
* Can perform variable selection

Disadvantages:

* When there is a group of highly collinear covariates, LASSO selects one variable and ignores the others
* When $$p > n$$, LASSO can only select at most $$n$$ variables

Example:

{% highlight r %}
sim_lasso_cv <- cv.glmnet(X, Y, alpha = 1)

# MSE vs log(lambda)
plot(sim_lasso_cv)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-11-21-OLS-Model-Selection/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

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

<img src="/nhuyhoa/figure/source/2015-11-21-OLS-Model-Selection/unnamed-chunk-4-2.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />
Notice how as $$\lambda$$ increases, the coefficients are shrunk directly towards 0.

## Elastic Net
Elastic net is an approach that blends both the $$l_2$$ and $$l_1$$ norm. In elastic net, we minimize the equation
$$ argmin_{\beta} \vert y - X \beta \vert^2 $$

subject to $$(1 - \alpha) * \Sigma^p_{j = 1} \vert \beta_j \vert + \alpha * \Sigma^p_{j = 1} \beta^2_j \le t $$ for some $$t$$ (elastic net penalty) where $$ \alpha = \frac{\lambda_2}{\lambda_1 + \lambda_2}$$, chosen by cross-validation.

* When $$\alpha = 1$$, we have ridge regression
* When $$\alpha = 0$$, we have LASSO regression
* When $$\alpha \in (0, 1)$$, we have a mix of ridge and LASSO

Note that since elastic net is a hybrid of ridge and LASSO, the covariates should be scaled prior to fitting the model (good to standardize y responses too).

## In R Software
The package `glmnet` is a great resource on fitting regularization models in R. See the package [viginette][glmnet_vignette]{:target="blank"}. 

# Dimension Reduction Techniques

## Principle Components

## Partial Least Squares Regression

[glmnet_vignette]: https://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html
[bv_tradeoff_post]: http://jnguyen92.github.io/nhuyhoa//2015/12/ML-Bias-Variance-and-CV.thml#bias-variance-tradeoff
[bv_tradeoff_train_test_post]: http://jnguyen92.github.io/nhuyhoa//2015/12/ML-Bias-Variance-and-CV.thml#training--testing-error
[bv_tradeoff_cv_post]: http://jnguyen92.github.io/nhuyhoa//2015/12/ML-Bias-Variance-and-CV.thml#cross-validation
