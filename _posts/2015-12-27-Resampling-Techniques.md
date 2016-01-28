---
layout: post
title: "Resampling Techniques"
date: "January 28, 2016"
categories: ['statistics', 'probability and inference']
---

* TOC
{:toc}



# Bootstrapping
The bootstrap is a powerful statistical tool that can be used to quantify the uncertainty or variance of a given estimator. By doing this, we can easily obtain estimates of standard error or confidence intervals.

Rather than obtaining new data sets we can sample from our original data set. This process allows us to obtain new data sets without generating additional samples. From this, we can obtain an estimate of the variability of our point estimate. 

1. Obtain $$N$$ samples with replacement from the original data set
2. Compute the point estimate
3. Repeat step 1-2 $$B$$ (some large quantity) times
4. Compute the variance of the point estimates 

$$Var(\hat{x}) = \frac{1}{B - 1} \sum^B_{r = 1} (\hat{x} - \bar{\hat{x}})^2$$

Note that in order for this process to be valid, all observations must be independent and identically distributed. 

Since we are sampling with replacement, each bootstrap sample has significant overlap with the original data. About $$\frac{2}{3}$$ of the original data points appear in each bootstrapped sample. 

$$ lim_{N \rightarrow \infty} 1 - (1 - \frac{1}{N})^N = .63 $$

where $$(1 - \frac{1}{N})^N$$ is the probability that an observation is not chosen out of any of the $$N$$ draws. Thus $$1 - (1 - \frac{1}{N})^N$$ is the probability that an observation is chosen to be a part of the bootstrap sample. 

In R, the following function (in the `boot` package) will generate the bootstrap replicates. 
`boot(data, statistic, R, ...)`

The `statistic` argument is a function which computes the desired test statistic. This function should have at least two arguments that takes the original data set and a vector of indices which define the bootstrap sample. The function can take other arguments as well, which can also be passed along in the `boot` function. 

# Permutation Test
A permutation test randomizes the labels assigned to data points to obtain a distribution under the null hypothesis. The observed test statistic is compared to this distribution to assess significance. 

We have the following hypothesis

* $$H_0$$: groups have no affect (any rearrangement of groups would result in similar test statistic compared to that observed)
* $$H_1$$: evidence of a group effect 

**Algorithm:**

* Repeat a large number of times (idea is to obtain all possible permutations):
  * Shuffle/scramble the group assignments to each data point
  * Calculate test statistic for new group assignments
* Compare distribution of permuted test statistics with the observed test statistic
  * With histogram: where does observed test statistic fall on the distribution of permuted test statistics?
  * With p-value: what is the proportion of permuted test statistics is more extreme than the observed test statistic?

**Advantages:**

* Can be used when the statistical assumptions of parametric tests are not met; ie it is a good non-parametric method
* Can be used for unbalanced designs

**Disadvantages:**

* Requires assumption that data labels are exchangeable
