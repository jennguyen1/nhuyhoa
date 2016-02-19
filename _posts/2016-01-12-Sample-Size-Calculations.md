---
layout: post
title: "Sample Size Calculations"
date: "January 12, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



When we run experiments, we want to make sure that we gather enough samples to have a reasonable amount of power to detect differences of a reasonable size. While we don't necessarily know what the size differences are, we can decide on what kind of a size difference we want to detect and calculate a sample size that has a chance of detecting it.

Larger sample sizes increase power (the probability of rejecting when there is a true difference) and reduces the false discovery rate (Type 1 error). However, we cannot gather an unlimited number of samples because we may be restricted by limited resources. Maintaining this balance is why we need to carefully consider sample size calculations.

# Basic Idea
Consider the observations $$Y_i$$ ~ $$N(\mu, \sigma^2)$$ for $$i = 1, ..., n$$ and assume $$\sigma^2$$ is known. 

Then 
$$\bar{Y} = \frac{1}{n} \sum_i y_i$$

We would reject $$H_0: \mu \le 0$$ if $$\bar{Y} > C_n$$ for some $$C_n$$. In standardized form, we reject $$H_0$$ if $$Z = \sqrt{\frac{n}{\sigma^2}} \bar{Y} \ge Z_{1 - \alpha/2}$$. Therefore $$C_n = \sqrt{\frac{\sigma^2}{n}} Z_{1 - \alpha /2}$$. 

![Null and Alternative Distributions](http://jnguyen92.github.io/nhuyhoa/figure/images/null_and_alternative_dist.png)

Diagrams of the null (left) and alternative (right) distributions.

![Distribution for Sample Size](http://jnguyen92.github.io/nhuyhoa/figure/images/sample_size_calc_diagram.png)

Distribution of null & alternative distribution for sample size calculations.

So with this example, we see that to obtain the $$\alpha$$ and $$\beta$$ value we desire, we need 
$$Z_{1 - \alpha/2} + Z_{1 - \beta} = \sqrt{\frac{n}{\sigma^2}} \mu_1$$
$$n = \frac{(Z_{1 - \alpha/2} + Z_{1 - \beta})^2 \sigma^2}{\mu_1^2}$$

# Sample Size Calculations for Exponential Families
Let $$\theta$$ be the parameter of interest. From this, we have 

* score function $$U(\theta)$$
* information $$I(\theta)$$

In large samples, we have $$E_{\theta}[U(0)] = I(0) \theta$$. 

The test statistic for $$H_0: \theta = 0$$ is 

$$E[Z(0)] = E_{\theta} \left( \frac{U(0)}{\sqrt{I(0)}} \right) = \sqrt{I(0)} \theta$$

To obtain sample sizes, we have

$$Z_{1 - \alpha/2} + Z_{1 - \beta} = \sqrt{E_{\theta}[I(0)]} \theta_1$$

So the required Fischer information is

$$f(n) = E_{\theta}[I(0)] = \frac{(Z_{1 - \alpha/2} + Z_{1 - \beta})^2}{\theta_1^2}$$

From here we can calculate $$E[I(0)]$$, which is a function of required sample $$n$$ (required sample size), and solve for $$n$$. We can assume that $$E_{H_0}[I(0)] = E_{H_1}[I(0)]$$.

For one-sided tests, change the $$Z_{1 - \alpha/2}$$ to $$Z_{1 - \alpha}$$.
 
# Examples
Let $$\epsilon_1 = n_1 / n$$ and $$\epsilon_2 = n_2 / n$$. 

* Two-sample normal data:

$$n = \frac{\sigma^2(Z_{1 - \alpha/2} + Z_{1 - \beta})^2}{\epsilon_1 \epsilon_2 \theta_1^2}$$

* Two-sample binomial data where $$\theta$$ is the log odds ratio

$$n = \frac{(Z_{1 - \alpha/2} + Z_{1 - \beta})^2}{\epsilon_1 \epsilon_2 \bar{p} (1 - \bar{p}) \theta_1^2}$$

* Two-sample binomial data where $$\theta$$ proportion difference

$$n = \frac{(Z_{1 - \alpha/2} + Z_{1 - \beta})^2 \bar{p} (1 - \bar{p})}{\epsilon_1 \epsilon_2  (p_0 - p_1)^2}$$
 
* Survival data assuming proportional hazards

$$n\bar{p} = \frac{(Z_{1 - \alpha/2} + Z_{1 - \beta})^2}{\epsilon_1 \epsilon_2 \theta_1^2}$$

where $$\bar{p}$$ is the probability of an observed event.

# In R
R has several functions to calculate desired power and sample sizes. 

* `power.anova.test()`
* `power.t.test()`
* `power.prop.test()`
