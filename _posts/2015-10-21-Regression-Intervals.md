---
layout: post
title: "Regression Confidence & Prediction Intervals"
date: "October 21, 2015"
categories: statistics
---

* TOC
{:toc}




# Confidence Intervals
Recall $$ Y_* = x_*\beta $$

Let $$ x'_* = (1, x_{0*}, ..., x_{*p}) $$ 

The expected value of Y is 
$$ E(Y) = \hat{Y}_* = x'_*\hat{\beta} $$

The variance of our estimate is
$$ Var(\hat{Y}_*) = Var(x'_*\hat{\beta}) = x'_*Var(\hat{\beta})x_* = \sigma^2x'_*(X'X)^{-1}x_* $$

thus $$ \hat{Y}_* $$ ~ $$ N(x'_*\hat{\beta}, \sigma^2x'_*(X'X)^{-1}x_*) $$

So the $$100(1-\alpha)$$% confidence interval is

$$ \hat{Y}_* \pm t_{n-p, \alpha/2} \sqrt{MSE} \sqrt{x'_*(X'X)^{-1}x_*} $$

# Prediction Intervals
If we want to predict new values, we incur additional error. 
$$ Y_0 = x'_0\beta + \epsilon_0 $$

We assume that $$ e_0 $$ ~ $$ N(0, \sigma^2) $$ and $$ e_0 \perp Y $$ 
Let $$ x'_0 = (1, x_{00}, ..., x_{0p}) $$

The expected value of Y is
$$ E(Y) = \hat{Y}_0 + 0 = x'_0\hat{\beta} $$

The variance of our estimate is
$$ Var(\hat{Y}_0) = Var(x'_0\hat{\beta} + \epsilon) = \sigma^2x'_0(X'X)^{-1}x_0 + \sigma^2 = \sigma^2 (x'_0(X'X)^{-1}x_0 + 1) $$

Thus the $$100(1-\alpha)$$% confidence interval is

$$ \hat{Y}_* \pm t_{n-p, \alpha/2} \sqrt{MSE} \sqrt{x'_*(X'X)^{-1}x_* + 1} $$

# Example
The plot below displays the fitted line (black), 95% confidence interval (blue), and 95% prediction intervals (green) for the estimated Y. Notice that the prediction intervals are much wider than the confidence intervals to account for prediction error. Also note that the bands are tighter around the $$\bar{x}$$ and wider at points farther away from $$\bar{x}$$. 

![plot of chunk unnamed-chunk-2](/nhuyhoa/figure/source/2015-10-21-Regression-Intervals/unnamed-chunk-2-1.png) 

