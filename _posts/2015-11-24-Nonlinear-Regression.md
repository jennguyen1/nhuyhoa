---
layout: post
title: "Nonlinear Regression"
date: "November 24, 2015"
categories: Statistics
tags: Regression
---

* TOC
{:toc}



The methods described here apply to all types of GLMs. 

# Polynomial Regresion
Adding nonlinear terms such as interactions and powers to the original predictors is polynomial regression. This type of model follows the principals of  regression. The hierarchy principle requires that lower ordered terms must be included when higher ordered terms are used (unless there are good reasons not to include them). For example if $$X^2$$ is in the model, $$X$$ must also be in the model. 

In R, fit terms with

* interaction: `:` or `*`
* powers: `poly(x, degree = n)`

# Piecewise Functions
Piecewise functions fit different functions in regions defined by knots. The more knots are introduced, the more flexible the function becomes. 

Often these types of functions provide more stable estimates and better results compared to polynomial functions. 

## Splines
Splines are piecewise polynomial functions that add constraints of continuity at the knots. Cubic splines are popular.

![Piecewise Polynomials](http://jennguyen1.github.io/nhuyhoa/figure/images/piecewise_and_splines.png)

Various piecewise polynomials. (Hastie et. al)

## Natural Splines 
Splines have the disadvantage of having high variance at the outer range of predictors. The natural spline adds additional boundary constraints, requiring that the function be linear at the outer ranges. Doing so generally produces more stable estimates at the boundaries. 

![Natural Spline](http://jennguyen1.github.io/nhuyhoa/figure/images/natural_spline.png)

Comparisons of a cubic spline to a natural spline. The main differences are at the endpoints. (Hastie et. al)

## Knot Placement
The best places to place knots are in regions that seem to vary most rapidly. 

Often it is hard to choose, so one can specify the desired degrees of freedom and let software place the knots. Cross-validation can also be used to find the best value for degrees of freedom. 

## Smoothing Splines
Smoothing splines attempt to <br>
$$minimize_{g \in S} \Sigma^n_{i = 1} (y_i - g(x_i))^2 + \lambda \int g''(t)^2dt$$

The second term is a roughness penalty that controls how wiggly $$g(x)$$ is with the second derivative. (Large magnitudes of $$g''$$ means $$g$$ more wiggly).

* Small $$\lambda$$ means a more wiggly function
* As $$\lambda \rightarrow \infty$$, $$g(x)$$ becomes linear

The value of $$\lambda$$ can be chosen via cross-validation. This method does not require the placements of knots.

Rather than specifying $$\lambda$$, one can specify the effective degrees of freedom. The greater the degrees of freedom, the more flexible the smoothing spline. 

## In R

* splines of any degree: `splines::bs()`
* natural splines: `splines::ns()`
* smoothing splines: `smooth.spline()`

# Local Regression
Local regression, otherwise known as loess, is a non-parametric techniquethat combines multiple regression and k-nearest neighbors. 

The idea is generate a linear model at target point $$x_0$$ using only the nearby training observations. 

**Algorithm:**

* Gather the fraction $$s = k/n$$ of training points whose $$x_i$$ are closest to $$x_0$$. The parameter $$s$$ is a tuning parameter chosen via cross-validation. Smaller spans are more flexible. 
* Assign weight $$K_{i0} = K(x_i, x_0)$$ to each point in the neighborhood so that the point furthest from $$x_0$$ has weight $$0$$ and the closest has the highest weight. All but these $$k$$ nearest neighbors get weight $$0$$
* Fit a weighted least squares regression of the $$y_i$$ on the $$x_i$$ using the aforementioned weights
* Fitted value at $$x_0$$ is given by $$\hat{f}(x_0) = \hat{\beta}_0 + \hat{\beta}_1 x_0$$

One good resource is Wolfram Demonstrations Project on [how loess works][loess_link]{:target = "_blank"}.

Another good link is the [PH525 series][ph525_link]{:target = "_blank"}.

In R, fit a loess curve with the function `loess()` or `splines::lo()`.

**Advantages:**

* Very flexible and simple
* Extension from linear regression

**Disadvantages:**

* Requires large, dense data sets
* Does not reproduce a regression function easily represented by a mathematical formula
* Computationally intensive

# Generalized Additive Models
Generalized additive models combines the nonlinear equations of several variables into one linear model. The idea is to fit a model to each variable separately. Any variety can be used (OLS, splines, loess, etc). Those models are then combined into a single general additive model. Even though GAMS are additive, lower order interactions can be included easily as well. 

In R, fit this model in R by combining the other nonlinear methods. 

* Fit with `gam(Y ~ s(X1, ...) + bs(X2, ...) + X3 + ns(X4) + lo(X5, ...) + ...)`
* View the plots with `plot.gam()`

[loess_link]: http://demonstrations.wolfram.com/HowLoessWorks/
[ph525_link]: http://genomicsclass.github.io/book/pages/smoothing.html
