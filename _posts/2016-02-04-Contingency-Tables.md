---
layout: post
title: "Contingency Tables"
date: "February 4, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# Goodness of Fit Tests

## Two Statistics
Let $$Y_1$$ ~ $$Bin(n, p_1)$$. Then $$E[Y_1] = np_1$$ and $$Var(Y_1) = np_1(1 - p_1)$$. For large samples ($$np_1 \ge 5$$ and $$n(1 - p_1) \ge 5$$), the CLT yields the normal distribution approxiation to the binomial distribution. 

$$Z = \frac{Y_1 - np_1}{\sqrt{np_1(1 - p_1)}}$$

where $$Z$$ ~ $$N(0, 1)$$. 

Squaring $$Z$$ we get

$$Z^2 = X^2 = \frac{(Y_1 - np_1)^2}{np_1(1 - p_1)}$$ 

where $$X^2$$ ~ $$\chi^2_1$$. 

We can rearrange to get

--------|------------------
$$X^2$$ | $$= \frac{(Y_1 - np_1)^2}{np_1(1 - p_1)} * ((1 - p_1) + p_1)$$
        | $$= \frac{(Y_1 - np_1)^2 (1 - p_1)}{np_1(1 - p_1)} + \frac{(Y_1 - np_1)^2 p_1}{np_1(1 - p_1)}$$
        | $$ = \frac{(Y_1 - np_1)^2}{np_1} + \frac{(Y_1 - np_1)^2}{n(1 - p_1)}$$
        | $$= \frac{(Y_1 - np_1)^2}{np_1} + \frac{(n - Y_2 - n(1 - p_2))^2}{np_2}$$
        | $$= \frac{(Y_1 - np_1)^2}{np_1} + \frac{(-(Y_2 - np_2))^2}{np_2}$$
        | $$= \frac{(Y_1 - np_1)^2}{np_1} + \frac{((Y_2 - np_2))^2}{np_2}$$
        | $$= \sum^2_{i = 1} \frac{(Y_i - np_i)^2}{np_i}$$
        | $$= \sum^2_{i = 1} \frac{(Obs - Exp)^2}{Exp}$$

Thus we obtain the $$X^2$$ goodness of fit statistic. 

Consider the following table

Categories   | 1       | 2       | ... | |k - 1         | |k
-------------|---------|---------|-----|-|--------------|-|------------
**Observed** | $$Y_1$$ | $$Y_2$$ | ... | |$$Y_{k - 1}$$ | |$$n-Y_1-Y_2-...-Y_{k - 1}$$
**Expected** | $$np_1$$| $$np_2$$| ... | |$$np_{k - 1}$$| |$$1 - np_k$$


The chi-square statistic for a $$k$$ category table is

$$X^2 = \sum^k_{i = 1} \frac{Y_i - np_i}{np_i}$$

where $$X^2$$ ~ $$\chi^2_{k - 1}$$.

The deviance statistic is derived from the likelihood ratio test

$$G^2 = 2 \sum^k_{j = 1} X_j \log \left( \frac{X_j}{n \hat{p_j}} \right) = 2 \sum_j O_j \log \left( \frac{O_j}{E_j} \right)$$

For large sample sizes, $$X^2$$ and $$G^2$$ are equivalent. 

## Application
It is important to note that

* We require CLT so that the expected number of each category is $$\ge 5$$; if needed, we may want collapse cells to achieve this
* The degrees of freedom of $$X^2$$ depends on the number of independent counts
* We reject the $$H_0$$ if the observed counts are very different from the expected counts (thus a greater $$X^2$$)

How do we obtain the probabilities? One way is for it to be given to us. We might also be interested in testing whether a data set follows a specific probability distribution. Generally these probability distributions have parameters that are unspecified (Poisson, Binomial, etc). In this case, to conduct chi-square goodness of fit tests, 

1. Estimate the parameters using the maximum likelihood method
2. Calculate the chi-square statistic using the obtained estimates
3. Compare the chi-square statistic to a $$X^2_{k - 1 - d}$$ distribution where $$d = $$ number of parameters estimated

**Example:**
We want to know whether the data below is consistent with a Poisson model?

**no. of calls** | 0 | 1 | 2 | 3 | 4 | 5
-----------------|---|---|---|---|-------
**count**        | 19| 26| 29| 13| 10| 3

$$\hat{\lambda} = \frac{19(0) + 26(1) + 29(2) + 13(3) + 10(4) + 3(5)}{100} = 1.78$$

The Poisson pmf is $$P(X = x) = \frac{\lambda^x e^{-\lambda}}{x!}$$, thus $$E[Y_i] = 100 * P(X = x)$$. We also want to collapse the last two counts to obtain values greater than $$5$$. 

**no. of calls** | 0 | 1 | 2 | 3 | 4 | 5
-----------------|---|---|---|---|-------
**count**        | 19| 26| 29| 13| 10| 3
**expect**       | 16.86 | 30.02 | 26.72 | 15.85 | 10.55

We would have $$X^2 = 2.08$$ and $$G^2 = 2.09$$. This multinomial model has $$k - 1$$ parameters and we estimate $$1$$ parameter $$\lambda$$. Thus the degrees of freedom is $$k - 1 - 1 = 3$$

We comnare these statistics to $$\chi^2_3$$ and obtain a p-value of $$0.56$$. Thus we conclude that the Poisson model fits well. 6

## Residuals
When results show that observed counts don't match expected counts, we may do additional analysis on the residuals to assess what could have gone wrong. 

The residuals are the square root of the components that sum up to the $$X^2$$ and the $$G^2$$ statistics. (For example, in $$X^2$$ it is $$r_j = \frac{O_j - E_j}{\sqrt{E_j}}$$). 

If the model is true, $$E[X^2] = E[G^2] = df$$ and the typical size of a single $$r_j = df / k$$. So if $$\vert r_j \vert >> \sqrt{df / k}$$, the model does not appear to fit well for cell $$j$$. 


# I x J Contingency Tables

(In the examples below, I present the $$X^2$$ test statistic. The deviance statistic is generated similar to the formula defined above).

## Homogeneity
The test for homogeneity tests whether two or more multinomial distributions are equal. That is, we hold the row totals fixed. 

We want to test

$$H_0: p_{11} = p_{21} and p_{12} = p_{22} ... p_{1k} = p_{2k}$$
$$H_1: not H_0$$

Category | c1                           | | ... | | cj                           | | Fixed Total
---------|------------------------------|-|-----|-|-----------------------------|-|------------
**Pop1**     | $$y_{11}$$ ($$\hat{p}_{11}$$)| |...  | | $$y_{1k}$$ ($$\hat{p}_{1J}$$)| |$$n_1 = \sum^k_j y_{1j}$$
**Pop2**     | $$y_{21}$$ ($$\hat{p}_{21}$$)| |...  | | $$y_{2k}$$ ($$\hat{p}_{2J}$$)| |$$n_2 = \sum^k_j y_{2j}$$
**Total**    | $$y_{11} + y_{21}$$ ($$\hat{p}_{1}$$) | |... | | $$y_{1k} + y_{2k}$$ ($$\hat{p}_{k}$$) | |$$n_1 + n_2$$

Each cell denotes the number falling into the $$j^{th}$$ category of the $$i^{th}$$ sample. Under the null hypothesis, $$E[Y_{ij}] = n_i \hat{p}_j$$. The estimate $$\hat{p}_j$$ is the pooled estimate for each column (under $$H_0$$, $$p_{xi} = p_{yi}$$). 

The test statistic is

$$X^2 = \sum^I_{i = 1} \sum^J_{j = 1} \frac{(y_{ij} - n_i \hat{p}_j)^2}{n_i \hat{p}_j}$$

We have $$I(J - 1)$$ df (each row is multinomial so $$n_i$$ is fixed) and estimate $$(J - 1)$$ parameters ($$\hat{p}_j$$). So $$df  = IJ - I - J + 1 = (I - 1)(J - 1)$$

So the statistic $$X^2$$ ~ $$\chi^2_{(I - 1)(J - 1)}$$

## Independence
Now consider that we hold the total sample size fixed (but not the marginal totals). Then we cross-classify each subject into one and only one of the mutually exclusive and exhaustive $$A_i \cap B_i$$. 

We wish to test
$$H_0: A \perp B; P(AB) = P(A)P(B)$$
$$H_1: A not \perp B$$

.       | |$$B_1$$                 | | ... | |$$B_J$$                 | **Total**
--------|-|-----------------------|-|-----|-|------------------------|-------
$$A_1$$ | |$$Y_{11}$$ ($$p_{11}$$) | | ... | |$$Y_{1J}$$ ($$p_{1J}$$) | ($$p_{1.}$$)
...     | |                        | | ... | |                        |
$$A_I$$ | |$$Y_{I1}$$ ($$p_{I1}$$) | | ... | |$$Y_{IJ}$$ ($$p_{IJ}$$) | ($$p_{I.}$$)
**Total**| | ($$p_{.1}$$)           | | ... | | ($$p_{.J}$$)           | $$n$$

Each cell $$Y_{ij}$$ denotes the frequency of $$A_i \cap B_j$$. Under the null hypothesis, $$E[Y_{ij}] = P(A_i)P(B_j)n = \frac{y_{i.}}{n} * \frac{y_{.j}}{n} * n = \frac{y_{i.} y_{.j}}{n} $$. 

The test statistic is

$$X^2 = \sum^I_{i = 1} \sum^J_{j = 1} \frac{(y_{ij} - \frac{y_{i.} y_{.j}}{n})^2}{\frac{y_{i.} y_{.j}}{n}}$$

We have $$(IJ - 1)$$ df (only grand total $$n$$ is fixed) and estimate $$(I + J - 2)$$ parameters (marginal probabilities). So $$df  = IJ - 1 + - I - J + 2 = IJ - I - J + 1 = (I - 1)(J - 1)$$

So the statistic $$X^2$$ ~ $$\chi^2_{(I - 1)(J - 1)}$$

## Sensitivity Analysis
A test statistic or p-value is a measure of the evidence against $$H_0$$ that depends on the effect size. An effect size should not change if $$n$$ is arbitrarily increased. 
 
Measures of association should not change if cell counts $$n_{ij}$$ are replaced by $$kn_{ij}$$ for some constant factor $$k$$. Sensitivity analsysis should be done to check that this is the case in analyses. 

## Fischer's Exact Test
When the row totals and column totals are fixed by design, we have hypergeometric sampling. We can assess these types of tables with exact tests. We can also use exact when sample sizes are small and asymptotic approximations are violated. 

Consider the following table

.     | **draw** | **no draw** | .
**a** | $$k$$    | $$D - k$$   | $$D$$
**b** | $$n - k$$| $$N+k-n-D$$ | $$N - D$$
      | $$n$$    | $$N - n$$   | $$N$$

Using the hypergeometric distribution, 

$$P(k, N, D, n) = \frac{\binom{D}{k} \binom{N - D}{n - k}}{\binom{N}{n}}$$

where $$k = 1, ..., n$$

Using this definition, we can map out the exact distribution of $$k$$ and compare that to our observed $$k$$ to obtain a p-value. 

Extensions to $$I x J$$ tables are implenented in statistical software.


# Point Estimators

## Difference in Proportions
We wish to test

$$H_0: p_1 = p_2$$

$$H_1: p_1 \ne p_2$$

The difference in proportions is defined as

$$\delta = p_1 - p_2$$

This value can be estimated with

$$\hat{\delta} = \frac{n_{11}}{n_{1+}} + \frac{n_{21}}{n_{2+}} = \hat{p}_1 - \hat{p}_2$$

The variance of this estimate is

$$Var(\delta) = Var(p_1 - p_2) = Var(p_1) + Var(p_2) = \frac{p_1(1 - p_1)}{n_{1+}} + \frac{p_2(1 - p_2)}{n_{2+}}$$

The values $$p_1$$ and $$p_2$$ can be estimated with $$\hat{p_1}$$ and $$\hat{p_2}$$ from the data. This variance estimate is generally used in confidence intervals. We can use the normal approximation to the bionomial distribution.

For hypothesis testing under $$H_0: p_1 = p_2$$, so we can obtain a more efficient estimate of $$Var(\hat{\delta})$$ using the pooled proportion $$\hat{p} = \frac{n_{11} + n_{21}}{n_{1+} + n_{2+}}$$. 

$$Var(\hat{\delta}) = \hat{p}(1 - \hat{p}) \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}$$

The statistic $$Z = \frac{\hat{\delta}}{\sqrt{Var(\hat{\delta})}} $$ is approximately distributed $$N(0, 1)$$.

## Relative Risk
The relative risk is defined as 

$$ \rho = \frac{P(Z = 1 \vert Y = 1)}{P(Z = 1 \vert Y = 2)}$$

This value can be estimated with 

$$\hat{\rho} = \frac{n_{11} / n_{1+}}{n_{21} / n_{2+}}$$

Since this value is non-negative, we take the $$\log$$ of $$\rho$$ to obtain a more normal distribution. 

The approximate variance of $$\rho$$ (using the Delta method) is

--------------------|------------------------------
$$Var(\log(\rho))$$ | $$= Var(\log(p_1) - \log(p_2))$$
                    | $$ = Var(\log(p_1)) + Var(\log(p_2))$$
                    | $$ = \frac{1}{p_1^2} \frac{p_1 (1 - p_1)}{n_{1+}} + \frac{1}{p_2^2} \frac{p_2 (1 - p_2)}{n_{2+}} $$
                    | $$ = \frac{(1 - p_1)}{p_1 n_{1+}} + \frac{(1 - p_2)}{p_2 n_{2+}} $$

Thus

$$Var(\log(\hat{\rho})) = \frac{(1 - n_{11} / n_{1+})}{n_{1+} n_{11} / n_{1+}} + \frac{(1 - n_{21} / n_{2+})}{n_{2+} n_{21} / n_{2+}} = \frac{1}{n_{11}} - \frac{1}{n_{1+}} + \frac{1}{n_{21}} - \frac{1}{n_{2+}}$$

The $$(1 - \alpha)100$$% confidence interval is

$$\exp \left( log(\hat{\rho}) \pm z_{\alpha/2} \sqrt{Var(\log(\hat{\rho}))} \right)$$

(Since this is the confidence interval is the odds ratio, we reject if $$1$$ is not in the interval).

## Odds Ratios
The odds is a ratio of success to failure. 

* If $$odds = 1$$, there is an equal chance of success and failure
* If $$odds > 1$$, success is more likely than failure
* If $$odds < 1$$, success is less likely than failure

The odds ratio is defined as 

$$OR = \frac{P(Z = 1 \vert Y = 1)/P(Z = 2 \vert Y = 1)}{P(Z = 1 \vert Y = 2)/P(Z = 2 \vert Y = 2)}$$

This value can be estimated with 

$$\hat{OR} = \frac{n_{11}n_{22}}{n_{12}n_{21}}$$

To estimate the variance, we again take the $$\log$$ and use the delta method

-----------------------|---------------------------------
$$Var(log(\hat{OR}))$$ | $$ = Var(\log(n_{11}) + \log(n_{22}) - \log(n_{12}) - \log(n_{21}))$$
                       | $$ = Var(\log(n_{11})) + Var(\log(n_{22})) - Var(\log(n_{12})) - Var(\log(n_{21}))$$
                       | $$ = \frac{1}{n_{11}} + \frac{1}{n_{22}} + \frac{1}{n_{12}} + \frac{1}{n_{21}}$$

Thus 

$$Var(log(\hat{OR})) = \frac{1}{n_{11}} + \frac{1}{n_{22}} + \frac{1}{n_{12}} + \frac{1}{n_{21}}$$ 

The $$(1 - \alpha)100$$% confidence interval is

$$\exp \left( log(\hat{OR}) \pm z_{\alpha/2} \sqrt{Var(\log(\hat{OR}))} \right)$$

(Since this is the confidence interval is the odds ratio, we reject if $$1$$ is not in the interval).

# Ordinal Categories
In some cases, our tables may contain ordinal categories. If this is the case, we would want to know if there exists a linear trend or correlation among the levels of the characteristics. 

The Mantel-Haenszel statistic ($$M^2$$) applies to both Pearson and Spearman correlation. 

We wish to test

$$H_0: \rho = 0$$

$$H_1: \rho \ne 0$$

The Mantel-Haenszel statistic is

$$ M^2 = (n - 1)r^2$$

where $$M^2$$ ~ $$X^2_1$$. 

* If the two variables are independent, $$\rho = 0, M^2 = 0$$
* If the two variables are perfectly associated, $$\rho = 1, M^2 = (n - 1)$$

In order to compute $$r$$, we need to assign scores or numerical values to the categorical rows and columns. We have several options

* Equal spacing integers
* Midranks
* Midpoints
* Domain knowledge

Once these scores are assigned, we can deaggregate the relationships and compute the correlation ($$r$$).

# Dependence
Matched pairs are two samples that are statistically dependent. We want to know if the margins of the table are the same. 

Suppose we survey people at two time points and want to measure whether their categorization stays the same over time.

In other words, we wish to test 

$$H_0: p_{12} = p_{21}$$

We can use McNemar's test to test for marginal homogeneity and symmetry. 

Suppose that $$n_{12} + n_{21}$$ is fixed. Under the null hypothesis, we would expect the frequency of counts in $$n_{12}$$ as in $$n_{21}$$. Thus $$n_{12}$$ ~ $$Bin(n_{12} + n_{21}, 0.5)$$. 

Assuming that $$n_{12} + n_{21}$$ is large, we would have the test statistic

$$Z = \frac{\frac{n_{12}}{n_{12} + n_{21}} - 0.5 }{\sqrt{\frac{0.5(1 - 0.5)}{n_{12} + n_{21}}}} = \frac{n_{12} - n_{21}}{\sqrt{n_{12} + n_{21}}}$$

where $$Z$$ is approximately $$N(0, 1)$$ if cell counts are large ($$\ge 5$$) or distributed $$Bin(n_{12} + n_{21}, 0.5)$$.

We can square the above value to get

$$X^2 = \frac{(n_{12} - n_{21})^2}{\sqrt{n_{12} + n_{21}}}$$

where $$X^2$$ ~ $$\chi^2_1$$. This test is valid when $$n$$ is fixed (but not $$n_{12} + n_{21}$$). 

We can obtain confidence intervals on the difference between the marginal proportions

$$d = p_{1+} - p_{+1} = p_{12} - p_{21}$$

We can estimate that with

$$\hat{d} = \frac{n_{12}}{n} + \frac{n_{21}}{n}$$

We can calculate

-----------------|-----------------
$$Var(\hat{d})$$ | $$ = n^{-2} Var(n_{12} - n_{21})$$
                 | $$ = n^{-2} \left( Var(n_{12}) + Var(n_{21}) - 2Cov(n_{12}, n_{21}) \right)$$
                 | $$ = n^{-2} \left( p_{12}(1 - p_{12}) + p_{21} (1 - p_{21}) + 2 p_{12} p_{21} \right)$$

We estimate the variance as

$$ \hat{Var}(\hat{d}) = \frac{1}{n} \left( \frac{n_{12}}{n}(1 - \frac{n_{12}}{n}) + \frac{n_{21}}{n}(1 - \frac{n_{21}}{n}) + 2 \frac{n_{21}n_{12}}{n^2} \right)$$

The $$(1 - \alpha)100$$% confidence interval is 

$$\hat{d} \pm z_{\alpha/2} \sqrt{\hat{Var}(\hat{d})}$$

# Three-Way Contingency Tables

# Log Linear Models
