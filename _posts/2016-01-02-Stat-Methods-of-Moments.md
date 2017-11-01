---
layout: post
title: "Methods of Moments Estimation"
date: "January 2, 2016"
categories: Statistics
tags: Probability and Inference
---

* TOC
{:toc}



# Moments

* $$E[X^k]$$ is the $$k^{th}$$ theoretical moment of the distribution (about the origin)
* $$E[(X - \mu)^k]$$ is the $$k^{th}$$ theoretical moment of the distribution (about the mean)
* $$M_k = \frac{1}{n} \sum^n_i X^K_i$$ is the $$k^{th}$$ sample moment
* $$M^*_k = \frac{1}{n} \sum^n_i (X_i - \bar{X})^k$$ is the $$k^{th}$$ sample moment about the mean

# Methods of Moments Estimator

**Procedure 1:**

1. Equate the first sample moment about the origin $$M_1$$ to the first theoretical moment $$E[X]$$
2. Equate the second sample moment about the origin $$M_2$$ to the second theoretical moment $$E[X^2]$$
3. Continue equating sample moments about the origin $$M_k$$ to the corresponding theoretical moments $$E[X^k]$$ until there are as many equations as parameters
4. Solve for parameters

**Example**

Find the MOM estimators for the $$N(\mu, \sigma^2)$$ distribution.

$$E[X_i] = \mu$$ and $$E[X_i^2] = \sigma^2 + \mu^2$$

Set $$M_1 = E[X] \rightarrow \bar{X} = \mu$$

$$\hat{\mu}_{MOM} = \bar{X}$$

Set $$M_2 = E[X^2] \rightarrow \frac{1}{n} \sum_i X_i^2 = \sigma^2 - \mu^2$$

$$\hat{\sigma}^2_{MOM} = \frac{1}{n} \sum^n_i X_i^2 - \mu^2 = \frac{1}{n} \sum^n_i (X_i - \bar{X})^2$$

**Procedure 2:**

1. Equate the first sample moment about the origin $$M_1$$ to the first theoretical moment $$E[X]$$
2. Equate the second sample moment about the mean $$M^*_2$$ to the second theoretical moment about the mean $$E[(X-\mu)^2]$$
3. Continue equating sample moments about the mean $$M^*_k$$ to the corresponding theoretical moments $$E[(X-\mu)^k]$$ until there are as many equations as parameters
4. Solve for parameters

**Example**

Find the parameters for the $$Gamma(\alpha, \theta)$$ distribution

$$E[X_i] = \alpha \theta$$ and $$Var(X_i) = E[(X_i - \mu)^2] = \alpha \theta^2$$


Set $$M_1 = E[X] \rightarrow \bar{X} = \alpha \theta \rightarrow \alpha = \frac{ \bar{X} }{ \theta }$$

Set $$M^*_2 = Var(X) \rightarrow \frac{1}{n} \sum_i (X_i - \bar{X})^2 = \alpha \theta^2$$

Substitute to get $$\alpha \theta^2 = \left( \frac{\bar{X}}{\theta} \right) \theta^2 = \bar{X} \theta = \frac{1}{n} \sum_i (X_i - \bar{X})^2$$

$$\hat{\theta}_{MOM} = \frac{1}{n\bar{X}} \sum_i (X_i - \bar{X})^2$$

Back substitute to get 

$$\hat{\alpha}_{MOM} = \frac{\bar{X}}{\hat{\theta}_{MOM}} = \frac{n \bar{X}^2 }{ \sum_i (X_i - \bar{X})^2 }$$
