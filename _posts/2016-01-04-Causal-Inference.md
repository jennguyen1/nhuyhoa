---
layout: post
title: "Causal Inference"
date: "January 04, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}

# Rubin Causal Model
The Rubin Causal Model is a conceptual model that defines causal effects in terms of unobservable  questions. 

Imagine that, giveen two possible treatments $$A$$, $$B$$, each subject $$u$$, has two potential outcomes

* $$Y_A(u)$$ - response if subject were to receive $$A$$
* $$Y_B(u)$$ - response if subject were to receive $$B$$

Then the Causal Effect of $$B$$ relative to $$A$$ for subject $$u$$ is 

$$D(u) = Y_B(u) - Y_A(u)$$

Let a larger $$Y$$ be "better", then 

* $$D(u) > 0$$ give subject $$u$$ treatment $$B$$
* $$D(u) < 0$$ give subject $$u$$ treatment $$A$$
* $$D(u) = 0$$ give subject $$u$$ either treatment $$A$$ or $$B$$

Unfortunately, it is is impossible to observe both $$Y_A(u)$$ and $$Y_B(u)$$ in the same subject (unless we had clones. That is we can never know the effect of the treatment in a single subject.

Instead we can examine the Population Average Causal Effect of $$B$$ relative to $$A$$. 

$$D = E[D(u)] = E[Y_B(u) - Y_A(u)] = E[Y_B(u)] - E[Y_A(u)]$$

We can estimate $$E[Y_B(u)]$$, $$E[Y_A(u)]$$ using different sets of subjects. 

We can then test the null hypothesis 

$$H_0: D = 0$$

# Design of Experiments

## Randomization
Random assignments of subjects to treatment groups is important for causal experiments. Randomization ensures that

* .$$E[Y(u) \vert T(u) = A] = E[Y_A(u)]$$
* .$$E[Y(u) \vert T(u) = B] = E[Y_B(u)]$$

so that 

$$E[Y(u) \vert T(u) = B] - E[Y(u) \vert T(u) = A] = E[Y_B(u)] - E[Y_A(u)] = D$$

We eliminate potential biases and ensure that we can conduct valid causal inference. 

Essentially we randomize so that the responses we see are independent of the treatment type. 

## Replication
Replication allows researchers to obtain precise (less variable) estimates of the mean. Increasing the number of replicates is one way of reducing the random error.

There is a difference between technical replicates (subsamples) and biological replicates (experimental units or EU). Technical replicates can reduce measurement error by averaging within a single EU. Biological replication reduces the standard error of parameter estimates of the biological population. Technical replication tells us a lot about a single unit, while biological replication tells us a lot about the population. Thus, it is better to increase the number of EUs than the technical replicates.  

## Blocking
Blocking accounts for nuisance factors that may contribute to the random error. By accounting for block variability, we can decrease the unaccounted error variability and make tests more powerful. 

## Confounding
If we do not randomize experiments, we may have confounding. Confounding occurs when additional (observed or unobserved) factors ($$Z$$) that are associated with both $$X$$ and $$Y$$ and induce misalignment between the observed association and the true causal relationship. 

![Confounding](http://jnguyen92.github.io/nhuyhoa/figure/images/confounding.png)

Specifically, if $$X$$ has a causal effect on $$Y$$, but $$Z$$  has causal effects on both $$X$$ and $$Y$$, then the observed assiciation between $$X$$ and $$Y$$ wil reflect the net effect of $$X$$ and the effect of $$Z$$ on $$X$$ and $$Y$$. In some cases $$X$$ may not have a causal effect on $$Y$$, but the confounding variable may make it seem like there is. 

To deal with confounding variables, we can either randomize or adjust for the variable. Generally, it is best to randomize and adjust for key variables (age, sex, etc). We cannot adjust for everything (expensive), which is why randomization is so important.

Sometimes when building complex experiments, we may use confounding to our advantage. We may confound things that we are not interested in order to have more efficient experiments for the things we are interested in. For example, in fractional factorial experiments we may confound the interactions so that we can estimate the main effects while reducing sample size and cost. 

## Analysis-Based Design
Analyses should be analyzed based on how the data was designed. Failing to do so may lead to biased results. 

# Missing Data

Missing data falls into a number of categories

* **Missing completely at random**: probability of missingness same for all units
* **Missingness at random**: pattern of missing data can be attributed to variables that are observed
* **Missinginess that depends on unobserved predictors**: missing data are informative, will bias results
* **Missingness that depends on missing value**: censoring

It is generally impossible to know whether data is really missing at random or it is due to unobserved predictors. We generally make assumptions or check with other studies. 

We cannot deal statistically with missing data. It is important to note that data is missing and interpret results with this taken into account. 

With missing data, there are a number of things we can do to proceed with analysis

* Complete-case analysis: drop all cases with missing data
* Available-case analysis: study different subsets of data where data is fully available
* Simple imputation: replace with mean, last available value, etc
* Indicator variables for missing predictors: replace missing data with 0, include interactions with predictor
* Regress other predictors on missing variable and predict missing data (either point estimate or incorporating error)
* Bayesian imputation: model the missing data points (alongside the responses)

Imputation methods assume that missing data is missing at random. 

## Modling Imputation

**KNN**

1. Replace every missing data point with the mean of the non-missing points for each feature
2. Replace missing values with mean of K nearest neighbors

**SVD**

1. Replace every missing data point with the mean of the non-missing points for each feature
2. Replace the missing values with the J (found via cross-validation) SVD approximation of X
3. Repeat until convergence

**Regression**

1. Remove rows of X that have missing values for column j
2. Fit regression on column of j using other columns of X; if other columns of X are missing, initally impute with mean
3. Using model, predict the missing values of column j
4. Repeat for other columns until convergence
