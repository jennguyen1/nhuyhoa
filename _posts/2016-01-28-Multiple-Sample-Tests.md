---
layout: post
title: "Multiple Sample Tests"
date: "January 28, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# One Sample Tests

## Parametric Test
Suppose our sample is randomly drawn from a normally distributed population. We want to test the population mean against a known standard (say $$\mu_0$$). So our null hypothesis is

$$H_0: \mu_1 = \mu_0$$

$$H_1: \mu_1 \ne \mu_0$$

There's two ways to do this. 

**Assume $$\sigma^2$$ Known**
We know that by the CLT $$\bar{X}$$ ~ $$N(\mu, \sigma^2)$$.  

We can calculate the test statistic 

$$Z = \frac{\bar{X} - \mu_0}{\sqrt{\sigma^2/n}}$$

where $$Z$$ ~ $$N(0, 1)$$ under the null hypothesis. We can compute the p-value to test $$H_0$$.

**Assume $$\sigma^2$$ Unknown**
Suppose the population variance is not known. Since we don't know $$\sigma^2$$, we can estimate it with the sample variance $$s^2$$. We can derive our test statistic from [probability theory][stat_theory_link]{:target = "_blank"}. 

Let $$Z$$ ~ $$N(0, 1)$$ and $$\frac{(n - 1)s^2}{\sigma^2}$$ ~ $$X^2_{n-1}$$

$$T = \frac{\frac{\bar{X} - \mu_0}{\sqrt{\sigma^2/n}}}{\sqrt{\frac{(n - 1)s^2}{\sigma^2}/(n-1)}} = \frac{\bar{X} - \mu_0}{\sqrt{s/n}}$$

where $$T$$ ~ $$t_{n - 1}$$ under the null hypothesis. We can compute the p-value to test $$H_0$$. 

## Nonparametric Test

If we have non-normality or outliers, parametric tests are not ideal. Nonparametric tests are more robust to violoations of these assumptions. 

The wilcoxon signed rank test is a test that makes 2 assumptions. 

1. RV $$X$$ is continuous
2. The pdf of X is symmetric

We wish to test the median

$$H_0: m = m_0$$

against the potential alternative hypotheses

$$ H_1: m > m_0$$ or $$H_1: m < m_0$$ or $$H_1: m \ne m_0$$

We can perform this test as follows:

1. Calculate $$X_i - m_0$$
2. Calculate $$\vert X_i - m_0 \vert$$
3. Determine rank, $$R_i$$ of the absolute values in ascending order according to magnitude
4. Determine the value of $$W = \sum^n_i Z_i R_i$$ where $$Z_i = I(X_i - m_0 > 0)$$
5. Determine if the observed $$W$$ is extreme under $$H_0$$

The distribution is available in software and in tables. We can also compute it for ourselves. For small sample sizes, the distribution of $$W$$ can be derived from the sample size. In large sample sizes, the value 
$$W' = \frac{\sum^n_{i = 1} Z_iR_i - \frac{n(n + 1)}{4}}{\sqrt{\frac{n(n + 1)(2n + 1)}{24}}}$$ is approximately distributed $$N(0, 1)$$

# Two Sample Tests
Suppose we want to test two population means where both populations are normally distributed. Let $$\mu_1$$ and $$\mu_2$$ represent population mean responses for $$trt.1$$ and $$trt.2$$. 

We want to test

$$H_0: \mu_1 = \mu_2$$

$$H_1: \mu_1 \ne \mu_2$$

It is crucial that data is analyzed according to how the experiment was designed otherwise our results may be lead to invalid results (inaccurately estimate variance).

T-tests can be fit in R with the `t.test()` function. 

## Unpaired T-Test
Suppose we randomly assign the treatments to a subject so that each subjects can receive either of the two treatments. 

We compute a test statistic

$$T = \frac{\bar{Y}_1 - \bar{Y}_2}{\sqrt{\hat{Var}(\hat{Y}_1 - \hat{Y}_2)}}$$

where $$\hat{Var}(\hat{Y}_1 - \hat{Y}_2)$$ depends on the estimated variances of the two treatment groups.

**Equal Variance**
We have independence between $$Y_1$$ and $$Y_2$$. If the variances are equal

$$\hat{Var}(\hat{Y}_1 - \hat{Y}_2) = s^2_p \left(\frac{1}{n_1} + \frac{1}{n_2} \right)$$
 
where

$$s^2_p = \frac{(n_1 - 1)s^2_1 + (n_2 - 1) s^2_2}{n_1 - 1 + n_2 - 1}$$

which is a weighted average of the sample means.

The statistic $$T$$ ~ $$t_{n_1 + n_2 - 2}$$.

**Unequal Variance**
If the variances are not equal

$$\hat{Var}(\hat{Y}_1 - \hat{Y}_2) = \frac{s^2_x}{n_1} + \frac{s^2_y}{n_2}$$

The statistic $$T$$ ~ $$t_{r}$$ where

$$r = \frac{\left( \frac{s^2_x}{n_1} + \frac{s^2_y}{n_2} \right)^2}{\frac{(s^2_x/n_1)^2}{n_1 - 1} + \frac{(s^2_y/n_2)^2}{n_2 - 1}}$$

## Paired T-Test
Suppose that instead of randomly assigning treatments to each subject, we have some sort of pairing. (A "pair" can refer to one or two subjects). While pairs are independent, there is dependency within pairs. The more dependency there is within a pair, the more noise reduction.

For example, suppose we want to compare two shoe types. We could conduct a paired experiment where one subject receives $$trt.1$$ on their left foot and $$trt.2$$ on their right foot. This is preferred over an unpaired study because a person's activity can vary widely across the population and unpaired designs would introduce unecessary noise to the data. 

This is a more restrictive randomization scheme than for the unpaired experiment.

We compute the test statistic

$$T = \frac{\bar{D}}{\sqrt{\hat{Var}(\bar{D})}} = \frac{\bar{D}}{s^2_D / n}$$

where 

$$s^2_D = \sum (D_i - \bar{D})^2/(n - 1)$$ the sample variance of the differences and $$D$$ is the differences between the paired treatments.

The statistic $$T$$ ~ $$t_{n - 1}$$.

## Experimental Design vs Analysis
Suppose two scenarios where we assume equal variance

1. We design an unpaired experiment
2. We design a paired experiment

For both these scenarios, suppose we analyze the data using a paired analysis.

For the unpaired design, we know that "pairs" are indpendent (this is built in). So

$$Var(D_i) = Var(Y_1) + Var(Y_2) = 2\sigma^2$$
$$Var(\bar{D}) = \frac{2\sigma^2}{n}$$

For the paired design, we don't necessarily know that the "pairs" are independent. So

$$Var(D_i) = Var(Y_1) + Var(Y_2) - 2cov(Y_1, Y_2) = 2\sigma^2(1 - p)$$
$$Var(\bar{D}) = \frac{2\sigma^2(1 - p)}{n}$$

Thus this tells us that if the groups were positively correlated, the paired design will have smaller variance and greater power in a paired analysis. This difference may have lead to differing results when it comes to the p-value.

This stresses the importance of analyzing the data based off the experimental design.

## Nonparametric Tests

### Wilcoxon /Mann-Whitney Test

# Multi-Sample Tests

## ANOVA

Consider a design with $$k$$ groups where there are $$n_i$$ observations on the $$i^{th}$$ treatment. Let $$y_{ij}$$ denote the $$j^{th}$$ observation on the $$i^{th}$$ treatment. 

We have the following terms

* treatment sum: $$y_{i.} = \sum^{n_i}_{j = 1} y_{ij}$$
* treatment mean: $$\bar{y}_{i.} = y_{i.}/n_i$$
* overall sum: $$y_{..} = \sum^k_{i = 1} \sum^{n_i}_{j = 1} y_{ij}$$
* overall mean: $$\bar{y}_{..} = y_{..} / N$$

**Sum of Squares**

----------|-------------------
$$SSTot$$ | $$= \sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{..})^2 = \sum_{all.obs} (y_{ij} - \bar{y}_{..})$$
$$SSTrt$$ | $$ = \sum^k_{i = 1} n_i(\bar{y}_{i.} - \bar{y}_{..})^2$$
$$SSErr$$ | $$ = \sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{i.})^2 = \sum^k_{i = 1} (n_i - 1) s_i^2$$

**Degrees of Freedom**

----------|-------------
$$dfTot$$ | $$ = N-1$$
$$dfTrt$$ | $$ = k-1$$
$$dfErr$$ | $$ = N-k$$

**ANOVA table**

<table class = "presenttab">
 <thead>
  <tr>
   <th style="text-align:left;"> Source </th>
   <th style="text-align:left;"> df </th>
   <th style="text-align:left;"> SS </th>
   <th style="text-align:left;"> MS </th>
   <th style="text-align:left;"> F </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Treatment </td>
   <td style="text-align:left;"> dfTrt </td>
   <td style="text-align:left;"> SSTrt </td>
   <td style="text-align:left;"> MSTrt </td>
   <td style="text-align:left;"> MSTrt / MSErr </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Error </td>
   <td style="text-align:left;"> dfErr </td>
   <td style="text-align:left;"> SSErr </td>
   <td style="text-align:left;"> MSErr </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> dfTot </td>
   <td style="text-align:left;"> SSTot </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table>

<p></p>
 
where $$F$$ ~ $$F_{dfTrt, dfErr}$$

We can derive this distribution from [probability theory][stat_theory_link]{:target = "_blank"}. The value $$\frac{df * MS}{\sigma^2}$$ is distributed $$X^2$$. So 

$$F = \frac{ \frac{df * MS}{\sigma^2} / df }{ \frac{dfErr * MSErr}{\sigma^2} / dfErr } = \frac{ MSTrt }{ MSErr }$$ 

is distributed $$F_{df, dfErr}$$. 

**Model Formulations**

* $$Y_{ij} = \mu_i + \epsilon_{ij}$$ where $$\epsilon_{ij}$$ ~ iid$$N(0, \sigma^2_{\epsilon})$$
* $$Y_{ij} = \mu + \alpha_i + \epsilon_{ij}$$ where $$\epsilon_{ij}$$ ~ iid$$N(0, \sigma^2_{\epsilon})$$ and $$\sum \alpha_i = 0$$

In R, anovas can be fit with the `lm()` and `anova()` or `aov()` commands.

**Assumptions**

1. Independence: within and across treatments
2. Normality: $$Y_{ij}$$ ~ $$N(\mu_i, \sigma^2_i)$$
3. Equal Variance: $$\sigma^2_1 = ... = \sigma^2_k$$

**Levene's Test**
Levene's test is a formal test to assess $$H_0: \sigma^2_1 = ... = \sigma^2_k$$. 

Procedure:
1. Let $$d_{ij} = \| y_{ij} - \tilde{y_i} \|$$ where $$\tilde{y_i}$$ is the median of group $$i$$
2. Perform a one-way ANOVA on the $$d_{ij}$$
3. Reject $$H_0: \sigma^2_1 = ... = \sigma^2_k$$ if the $$F$$-test is significant

**Nonparametric Alternative**
A nonparametric alternative to ANOVA requires a rank transformation. The procedure for this method is listed below.

1. Rank data set from largest to smallest
2. Analyze rank values in standard ANOVA

## Nonparametric Tests

### Kruskal-Wallis

### Hodges-Lehman

[stat_theory_link]: http://jnguyen92.github.io/nhuyhoa//2015/10/OLS-and-ANOVA.html
