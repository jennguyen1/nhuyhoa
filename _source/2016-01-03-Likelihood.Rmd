---
layout: post
title: "Likelihood"
date: "January 3, 2016"
categories: ['statistics', 'probability and inference']
---

* TOC
{:toc}

# Likelihood
Likelihood is a common staitstical approach for analyzing data and conducting inference. 

Suppose we observe iid responses $$Y_i$$ for $$i = 1, ...n$$. Let the density of $$Y_i$$ be $$f(y \vert \mu)$$. 

Then the joint density for $$Y_1, ..., Y_n$$ is 
$$f(y_1, ..., y_n \vert \mu) = \Pi^n_{i = 1} f(y_i \vert \mu)$$

The likelihood function is then
$$L(\mu) = \Pi^n_{i = 1} f(Y_i \vert \mu)$$

The maximum likelihood estimate (MLE) of $$\mu$$ is the value of $$\mu$$ that maximizes $$L(\mu)$$. To calculate this we can take the first derivate and set it equal to 0. Often we maximize the \log likelihood $$\log(L(\mu))$$ for simpler calculations. 

Example:

Consider the one-sample iid normal case: $$Y_i$$ ~ $$N(\mu, \sigma^2)$$ where we assume that $$\sigma^2$$ is known. We want to find the MLE of $$\mu$$.

The density for $$Y_i$$ is 
$$f(y \vert \mu) = \frac{1}{\sigma \sqrt{2\pi}} exp \left( -\frac{(y - \mu)^2}{2\sigma^2}\right)$$

The joint density for $$Y_1, ... Y_n$$ is
$$f(y_1, ..., y_n \vert \mu) = \Pi^n_{i = 1} \frac{1}{\sigma \sqrt{2\pi}} exp \left( -\frac{(y_i - \mu)^2}{2\sigma^2}\right)$$

Then the likelihood function is
$$L(\mu) = \Pi^n_{i = 1} \frac{1}{\sigma \sqrt{2\pi}} exp \left( -\frac{(Y_i - \mu)^2}{2\sigma^2}\right)$$

It is easier to maximize the log likelihood

-----------|--------------------------
$$l(\mu)$$ | $$ = \sum^n_{i = 1} \log \big[ \frac{1}{\sigma \sqrt{2\pi}} exp \left( -\frac{(Y_i - \mu)^2}{2\sigma^2}\right) \big]$$
           | $$ = n * \log \left( \frac{1}{\sigma \sqrt{2\pi}}\right) - \frac{1}{2\sigma^2} \sum^n_{i = 1} (Y_i - \mu)^2$$

To maximize we take the derivative with respect to $$\mu$$

-----------|--------------------------
$$l'(\mu)$$| $$ = - \frac{2}{2 \sigma^2} \sum^n_{i = 1} (Y_i - \mu) = 0$$
$$0 $$     | $$= - n \mu + \sum^n_{i = 1} Y_i$$
$$n\mu $$  | $$ = \sum^n_{i = 1} Y_i$$

$$\hat{\mu} = \frac{1}{n} \sum^n_{i = 1} Y_i = \bar{Y}$$

# Score Function and Fischer Information
We can derive additional statistics from the likelihood equation.

The log likelihood is defined as 

$$l(\mu) = \log(L(\mu))$$

The score function is defined as

$$U(\mu) = \frac{\partial}{\partial \mu} l(\mu)$$

The fischer infromation is defined as 

$$I(\mu) = Var[U(\mu)] = - \frac{\partial}{\partial \mu} U(\mu) \approx \frac{1}{Var(\hat{\mu})}$$

# Three Likelihood Tests
Generally the score test is preferred because it does not require that we find the MLE estimate. 

## Likelihood Test

$$ G(\theta_0) = -2 \log \left( \frac{L(\theta_0)}{L(\hat{\theta})} \right) = -2[l(\theta_0) - l(\hat{\theta})]$$ ~ $$\chi^2_1$$

## Score Test

$$ \frac{U(\theta_0)^2}{I(\theta_0)} $$ ~ $$\chi^2_1$$

## Wald Test

$$\frac{(\hat{\theta} - \theta_0)^2}{Var[\hat{\theta}]}$$ ~ $$\chi^2_1$$

# Beyond One-Sample Data

## Likelihood Tests for 2 Sample Tests
The application of the 3 likelihood tests to one-sample tests is relatively straightforward. It involves a little bit more work for two samples. 

Suppose $$Y_j$$ ~ $$f(Y \vert \theta_j)$$ and $$z = 0, 1$$ be the treatment groups.

* For group 0: $$\theta_0 = \alpha$$
* For group 1: $$\theta_1 = \alpha + \beta z$$

We want to test $$H_0: \beta = 0$$

The log likelihood function is
$$l(\theta_0, \theta_1) = l(\theta_0) + l(\theta_1) $$

in which we can do a change of variables transformation to get $$l(\alpha, \beta)$$.

The score gradient vector has 2 components

* .$$U_{\alpha}(\alpha, \beta) = \frac{\partial}{\partial \alpha} l(\alpha, \beta)$$
* .$$U_{\beta}(\alpha, \beta) = \frac{\partial}{\partial \beta} l(\alpha, \beta)$$

So we calculate $$\hat{\alpha}$$ with 
$$U_{\alpha}(\alpha, 0) = 0$$

The likelihood ratio test is

$$ -2[l(\hat{\alpha}_0, 0) - l(\hat{\alpha}, \hat{\beta})] $$ ~ $$\chi^2_1$$

The score test is

$$\frac{U_{\beta}(\hat{\alpha}_0, 0)^2}{Var[U_{\beta} (\hat{\alpha}_0, 0)]}$$ ~ $$\chi^2_1$$

The wald test is
$$ \frac{\hat{\beta}^2}{Var[\hat{\beta}]} $$ ~ $$\chi^2_1$$

We see that for the score test, we do not need to compute the MLE for $$\beta$$. This makes it computationally easier and preferred.

Example calculations are available [here][likelihood_calc]{:target = "_blank"}. 

## Likelihood Test for Stratified Data
The score test is preferred when the data is stratified (split out across different categorical variables) because it doesn't require estimates of $$\theta$$.

For the score test:

* $$U_k(\theta)$$ is the score function for stratum $$k$$
* global score function is $$U(\theta) = \sum_k U_k(\theta)$$
* global Fischer information is $$I(\theta) = \sum_k I(\theta)$$
* global score test of $$H_0: \theta = 0$$ is $$\frac{U(0)^2}{I(0)} = \frac{(\sum_k U_k(0))^2}{\sum_k I_k(0)}$$

[likelihood_calc]:https://drive.google.com/file/d/0B5VF_idvHAmMMlFrYUg5Q0ttVXM/view?usp=sharing
