---
layout: post
title: "Regression Basics"
date: "October 20, 2015"
categories: statistics
---

* TOC
{:toc}

The regression equation:

$$ Y = X\beta + \epsilon $$

# Estimating Beta Coefficients
In least squares regression, we attemt to minimize the sum squared errors (SSE). 

Let $$Y$$ = observed responses and $$\hat{Y}$$ = fitted responses. $$\hat{Y}$$ lies on the column space of $$X$$, our design matrix. The idea is that there may not be a solution to $$Y = X\beta$$, so we project $$Y$$ onto the $$col(X)$$ in which we do have a solution. 

In order to minimize the SSEs, we have $$Y-\hat{Y}$$ is perpendicular to $$col(X)$$:

$$ X^T(Y-\hat{Y}) = 0 $$
$$ X^T\hat{Y} = X^TY $$
$$ X^TX\hat{\beta} = X^TY $$


$$ \hat{\beta} = (X^TX)^{-1}X^TY $$

# Residual Sum Squares
The residual is $$r = Y - \hat{Y} = Y - X\hat{\beta}$$.

In least squares, this the sum of the squared residuals are minimized. 

$$ RSS = r^Tr $$
$$ = (Y - X\hat{\beta})^T(Y - X\hat{\beta}) $$
$$ = Y^TY - 2\hat{\beta}^TX^TY + \hat{\beta}^TX^TX\hat{\beta} $$
$$ = Y^TY - \hat{\beta}^TX^TY + \hat{\beta}^T[X^TX\hat{\beta} - X^TY] $$

and since $$ X^TX\hat{\beta} = X^TY $$
$$ = Y^TY - \hat{\beta}X^TY $$

So...

$$ RSS = Y^TY - \hat{\beta}^TX^TX\hat{\beta} $$

From this we can derive the mean square error:

$$ MSE = \frac{RSS}{n - p} $$

Note that in least squares, we always minimize the RSS. So the sum of the residuals is always equal to 0.

$$ min( \Sigma (y - \hat{y})^2 ) $$
$$ 2 \Sigma (y - \hat{y}) = 0 $$

# Distribution of Beta Estimates
We know that 
$$ E[Y] = X\beta $$
$$ Var[Y] = \sigma^2 $$

The beta parameters are unbiased:
$$ E[\beta] = (X^TX)^{-1}X^TE[Y] $$
$$ = (X^TX)^{-1}X^TX\beta $$

$$ E[\beta] = \beta $$

The variance of the beta parameters:
$$ Var[\beta] = (X^TX)^{-1}X^TVar[Y]X(X^TX)^{-1} $$
$$ = \sigma^2 (X^TX)^{-1}X^TX(X^TX)^{-1} $$

$$ Var[\beta] = \sigma^2 (X^TX)^{-1} $$

Thus $$ \hat{\beta} ~ N(\beta, \sigma^2(X^TX)^{-1}) $$, and since we have to estimate $$\sigma^2$$, we use a t-distribution to determine the sigificance of the $$\hat{\beta}$$ parameter.
 


