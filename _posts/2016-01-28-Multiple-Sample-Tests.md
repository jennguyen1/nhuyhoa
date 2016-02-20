---
layout: post
title: "Multiple Sample Tests"
date: "January 28, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# One Sample Tests

## Z-Test and T-Test
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

### Wilcoxon Signed Rank Test
If we have non-normality or outliers, parametric tests are not ideal. Nonparametric tests are more robust to violoations of these assumptions. 

The **wilcoxon signed rank test** is a test that makes 2 assumptions. 

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
4. Determine the value of $$W = \sum^n_i Z_i R_i$$ where $$Z_i = sign(X_i - m_0)$$
5. Determine if the observed $$W$$ is extreme under $$H_0$$

The distribution is available in software and in tables. We can also compute the exact distribution or look at the distribution of permutations (for $$>1$$ samples). For small sample sizes, the distribution of $$W$$ can be derived from the sample size. In large sample sizes, the value 

$$W' = \frac{\sum^n_{i = 1} Z_iR_i - \frac{n(n + 1)}{4}}{\sqrt{\frac{n(n + 1)(2n + 1)}{24}}}$$ 

is approximately distributed $$N(0, 1)$$

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

which is a weighted average of the sample variances.

The statistic $$T$$ ~ $$t_{n_1 + n_2 - 2}$$.

**Unequal Variance**
If the variances are not equal

$$\hat{Var}(\hat{Y}_1 - \hat{Y}_2) = \frac{s^2_x}{n_1} + \frac{s^2_y}{n_2}$$

The statistic $$T$$ ~ $$t_{r}$$ where

$$r = \frac{\left( \frac{s^2_x}{n_1} + \frac{s^2_y}{n_2} \right)^2}{\frac{(s^2_x/n_1)^2}{n_1 - 1} + \frac{(s^2_y/n_2)^2}{n_2 - 1}}$$

## Paired T-Test
Suppose that instead of randomly assigning treatments to each subject, we have some sort of pairing. (A "pair" can refer to one or two subjects). While pairs are independent, there is dependency or correlation within pairs. The more dependency there is within a pair, the more noise reduction.

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
With nonparametric tests, we do not make the assumption of normality. In addition to permutations, we have several tests to compare two samples. 

### Mann Whitney Wilcoxon Test
For this test, we make the following assumptions

* Independent samples
* Continuous variable
* Equal variances
* Identical (but non-normal) distributions

We want to know whether one distribution is shifted relative to the other.  In other words, we wish to test

$$H_0: F_1(x) = F_2(x)$$

$$H_1: F_1(x) \ge F_2(x) or F_1(x) \le F_2(x)$$

The procedure for the **wilcoxon rank sum test** are: 

1. Combine the $$m+n$$ observations into one group and rank the observations from smallest to largest. Compute rank sum $$W$$ of treatment 1
2. Find all possible permutation of the ranks. For each permutation find $$W'$$
3. Determine the p-value

$$p.val = \frac{no. rank sums \le W_{obs}}{\binom{m + n}{n}}$$

Rather than doing a permutation test, one can compare to the exact distribution using tables. 

An equivalent test is called the **Mann-Whitney U test**. 

Let $$T_B = \sum^{n_b}_{i = 1} R_{iB}$$. 

Under $$H_0$$

* .$$E[T_B] = n_B \frac{n_A + n_B + 1}{2}$$
* .$$Var(T_B) = \frac{n_A n_B}{n_A + n_B - 1} \left( \frac{1}{n_A + n_B} \sum_{i, j} R^2_{ij} - \frac{(n_A + n_B + 1)^2}{4} \right)$$
* $$Var(T_B) = \frac{n_A n_B(n_A+n_B+1)}{12}$$ when there are no ties
* .$$U = T_B - E[T_B]$$

The statistic

$$\frac{(T_B - E[T_B])^2}{Var(T_B)}$$

is approximately distributed $$\chi^2_1$$. 

To conduct this test, we can use `wilcox.test()` in R. 

We can also define 

$$U =$$ $ of pairs of $$(X_i, Y_j)$$ for which $$X_i < Y_j$$.

We can use this to computes a confidence interval based on the shift of the two distributions. This value is the difference between two means or medians. 

The difference in the two distributions can be written as

$$F_1(x) = F_2(x - \Delta)$$

The confidence interval is computed as interval where

$$pwd(k_a) < \Delta \le pwd(k_b)$$

where $$k$$ is the pair between group 1 and group 2 and
$$pwd$$ is a function denoting the pairwise distance between a point in group 1 and a point in group 2. 

We can derive the confidence interval from

$$P(k_a < U < k_b) = 1 - \alpha$$

where under large samples, $$U$$ is distributed $$N(0, 1)$$.

### Kologorov Smirnov Test
For this test, we make the following assumptions

* Independent samples
* Identical (but non-normal) distributions

Note that we do not assume equal variance. So we want to compare two identically distributed populations that have both different means and variances. 

We test

$$H_0:$$ the distributions are the same
$$H_1:$$ the distributions are not the same

The Kolmogorov-Smirnov statistic is

$$KS = max_x \vert \hat{F}_1(x) - \hat{F}_2(x) \vert$$

This test is upper-tailed. The idea is to rank the combined data,  compute the CDF for each treatment, and then find the absolute difference. The maximum of those differences can be compared to permutations or known tables to obtain a p-value. 

In R, we can run this test using `ks.test()` or fit emprical cdfs with `ecdf()`.

### Wilcoxon Signed Ranks Test
This test can be used to analyze paired two-sample tests.

For this test, we make the following assumptions

* Differences are continuous
* Distribution of differences is symmetric
* Differences are mutually independent
* Differences all have the same median

To conduct the wilcoxon signed rank test for paired samples by computing the differences and running the procedure defined above. 

In R, we can run this test with `wilcox.test()`.

# K-Sample Tests

## ANOVA
In R, ANOVA can be fit with the `lm()` and `anova()` or `aov()` commands.

**Assumptions**

Regardless of the type, ANOVAs have the same assumptions:

1. Independence: within and across treatments
2. Normality: $$Y_{ij}$$ ~ $$N(\mu_i, \sigma^2_i)$$
3. Equal Variance: $$\sigma^2_1 = ... = \sigma^2_k$$

### Single Factor ANOVA 

**Model Formulations**

Consider a design with $$k$$ groups where there are $$n_i$$ observations on the $$i^{th}$$ treatment. Let $$y_{ij}$$ denote the $$j^{th}$$ observation on the $$i^{th}$$ treatment. 

$$Y_{ij} = \mu_i + \epsilon_{ij}$$ 

where $$\epsilon_{ij}$$ ~ iid$$N(0, \sigma^2_{\epsilon})$$

$$Y_{ij} = \mu + \alpha_i + \epsilon_{ij}$$ 

where $$\epsilon_{ij}$$ ~ iid$$N(0, \sigma^2_{\epsilon})$$. We assume $$\sum \alpha_i = 0$$ if $$H_0$$ is true.

**ANOVA Table**

We have the following terms

* treatment sum: $$y_{i.} = \sum^{n_i}_{j = 1} y_{ij}$$
* treatment mean: $$\bar{y}_{i.} = y_{i.}/n_i$$
* overall sum: $$y_{..} = \sum^k_{i = 1} \sum^{n_i}_{j = 1} y_{ij}$$
* overall mean: $$\bar{y}_{..} = y_{..} / N$$

Source| Sum of Squares | Degrees of Freedom | Mean Square | F 
------|----------------|--------------------|-------------|---------
Trt   | $$\sum^k_{i = 1} n_i(\bar{y}_{i.} - \bar{y}_{..})^2$$ | $$k-1$$ | $$\frac{SSTrt}{dfTrt}$$ | $$\frac{MSTrt}{MSE}$$ 
Error | $$\sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{i.})^2 = \sum^k_{i = 1} (n_i - 1) s_i^2$$ | $$N-k$$ | $$\frac{SSE}{dfE}$$ |
Total | $$\sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{..})^2 = \sum_{all.obs} (y_{ij} - \bar{y}_{..})$$ | $$N-1$$ | | 

<p></p>
 
where $$F$$ ~ $$F_{dfTrt, dfErr}$$. When $$F$$ is large, we say that the group effect is large so we reject the null hypothesis that the groups are the same.

We can derive this distribution from [probability theory][stat_theory_link]{:target = "_blank"}. The value $$\frac{df * MS}{\sigma^2}$$ is distributed $$X^2$$. So 

$$F = \frac{ \frac{df * MS}{\sigma^2} / df }{ \frac{dfErr * MSErr}{\sigma^2} / dfErr } = \frac{ MSTrt }{ MSErr }$$ 

is distributed $$F_{df, dfErr}$$. 

Another way to look at this is to consider if $$H_0$$ is true

* .$$\sum_i \alpha_i = 0$$
* .$$E[MSTrt] = \sigma^2_{\epsilon} + \frac{n}{k - 1} \sum^k_i \alpha_i^2$$
* .$$E[MSE] = \sigma^2_{\epsilon}$$

Then 

$$\frac{E[MSTrt]}{E[MSE]} = 1 + \frac{1}{k - 1} \frac{n \sum^k_i \alpha^2_i}{\sigma^2_{\epsilon}}$$ 

Note that if $$\sum \alpha_i \approx 0$$, then this ratio $$\approx 1$$. The power of the $$F$$ test is a monotone function of $$\frac{n \sum^k_i \alpha^2_i}{\sigma^2_{\epsilon}}$$.

### Two Factor ANOVA

**Model Formulations**

$$Y_{ijl} = \mu + \alpha_i + \beta_j + (\alpha \beta)_{ij} + \epsilon_{ijl}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$j = 1, ..., b$$ denotes the levels of factor B
* $$l = 1, ..., n$$ denotes replicates of each factor combination
* $$\epsilon_{ijl}$$ ~ $$N(0, \sigma^2_{\epsilon})$$ represents the plot error


**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | F 
------|----------------|--------------------|-------------|---------
A     | $$bn\sum^a_{i = 1} (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$a-1$$ | $$\frac{SSA}{dfA}$$ | $$\frac{MSA}{MSE}$$ 
B     | $$an\sum^b_{j = 1} (\bar{y}_{.j.} - \bar{y}_{...})^2$$ | $$b-1$$ | $$\frac{SSB}{dfB}$$ | $$\frac{MSB}{MSE}$$ 
AB    | $$n \sum^a_{i = 1} \sum^b_{j = 1} (\bar{y}_{ij.} - \bar{y}_{i..} - \bar{y}_{.j.} + \bar{y}_{...})^2$$ | $$(a-1)(b-1)$$ | $$\frac{SSAB}{dfAB}$$ | $$\frac{MSAB}{MSE}$$ 
Error | $$\sum^a_{i = 1} \sum^b_{j = 1} \sum^n_{l = 1} (y_{ijl} - \bar{y}_{ij.})^2$$ | $$ab(n - 1)$$ | $$\frac{SSE}{dfE}$$ | | 
Total | $$\sum^a_{i = 1} \sum^b_{j = 1} \sum^n_{l = 1} (y_{ijl} - \bar{y}_{...})^2$$ | $$abn - 1$$ | | 

<p></p>

Note that we have three separate $$F$$ tests (similar to the single factor case) to assess the $$A_{main}$$, $$B_{main}$$, and $$AB_{int}$$ effects. 

Assume $$H_0$$ is true so that

* $$\sum_i \alpha_i = 0$$, $$\sum_j \beta_j = 0$$ and $$\sum_i (\alpha \beta)_{ij} = \sum_j (\alpha \beta)_{ij} = 0$$
* .$$E[MSA] = \sigma^2_{\epsilon} + \frac{bn}{a - 1} \sum \alpha^2_i$$
* .$$E[MSB] = \sigma^2_{\epsilon} + \frac{an}{b - 1} \sum \beta^2_j$$
* .$$E[MSAB] = \sigma^2_{\epsilon} + \frac{n}{(a - 1)(b - 1)} \sum (\alpha \beta)^2_{ij}$$
* .$$E[MSE] = \sigma^2_{\epsilon}$$

We can test the main effects and interaction by comparing them to $$MSE$$ with an $$F$$ test.

**Contrasts**

Let $$\bar{ab}$$ denote the mean of the high-high group, $$\bar{a}$$ denote the mean of high-low group, $$\bar{b}$$ denote the mean of the low-high group, and $$\bar{1}$$ denote the mean of the low-low group. We have

* .$$A_{main} = \frac{1}{2} [(\bar{ab} - \bar{b}) + (\bar{a} - \bar{1})]$$
* .$$B_{main} = \frac{1}{2} [(\bar{ab} - \bar{a}) + (\bar{b} - \bar{1})]$$
* .$$AB_{int} = \frac{1}{2} [(\bar{ab} - \bar{b}) - (\bar{a} - \bar{1})]$$

We can assess these effects by generating an interaction plot. By assessing the trends and parallelism of lines, we can determine whether there may be evidence of an interaction effect. We can also test these effects with a contrast test.

### Randomized Complete Block Design ANOVA

Block designs are very similar to regular ANOVAs. Blocking is similar to a paired analysis in t-tests. By accounting for the block variability, we decrease the unaccounted variability and make the test for treatment more powerful. 

A single block should be homogeneous. To ensure this homogeneity, we want to make sure blocks are small enough that

* all treatments are contained with a block but
* there are no duplicated treatments within a block

**Model Formulations**

$$Y_{ij} = \mu + \alpha_i + \beta_j + \epsilon_{ij}$$

where

* $$i = 1, ..., k$$ denotes the levels of treatment
* $$j = 1, ..., b$$ denotes the levels of blocks
* $$\epsilon_{ij}$$ ~ $$N(0, \sigma^2_{\epsilon})$$ represents the plot error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | F 
------|----------------|--------------------|-------------|---------
Blokcs| $$k\sum^b_{j = 1} (\bar{y}_{.j} - \bar{y}_{..})^2$$ | $$b-1$$ | $$\frac{SSB}{dfB}$$ | $$\frac{MSB}{MSE}$$ 
Trt   | $$b\sum^k_{i = 1} (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$k-1$$ | $$\frac{SSA}{dfA}$$ | $$\frac{MSA}{MSE}$$ 
Error | $$\sum_{ij} (\bar{y}_{ij} - \bar{y}_{i.} - \bar{y}_{.j} + \bar{y}_{..})^2$$ | $$(k-1)(b-1)$$ | $$\frac{SSE}{dfe}$$ | 
Total | $$\sum_{ij} (y_{ij} - \bar{y}_{..})^2$$ | $$kb - 1$$ | | 

<p></p>

We can assess the effect of treatment with an $$F$$ test on $$k - 1$$ and $$(k - 1)(b - 1)$$ df. 

Note that we can ignore the $$F$$ test for the effect of blocks. The blocks were used in order to account for variability. A significant test would indicate that we were right to block. If we did not find a significant block effect, we should not pool the block with error and analyze the data as a completely randomized design! We need to analyze the data as we have designed it, otherwise we would bias our tests. 

We notice several things from this table. One is that this table is reminiscent of the ANOVA table for two-factor ANOVA where $$n = 1$$. Another similarity is that the SS for error is similar to the SS for the interaction term in the two-factor case. This is because we assume an additive model and so the error that is normally given to the interaction is transferred to the error.

Thus RCBD with one factor is the same as a completely randomized two-factor ANOVA where $$n = 1$$.

### Three Factor ANOVA

**Model Formulations**

$$Y_{ijkl} = \mu + \alpha_i + \beta_j + \gamma_k + (\alpha \beta)_{ij} + (\alpha \gamma)_{ik} + (\beta \gamma)_{jk} \epsilon_{ijkl}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$j = 1, ..., b$$ denotes the levels of factor B
* $$k = 1, ..., c$$ denotes the levels of factor C
* $$l = 1, ..., n$$ denotes replicates of each factor combination
* $$\epsilon_{ijkl}$$ ~ $$N(0, \sigma^2_{\epsilon})$$ represents the plot error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | F 
------|----------------|--------------------|-------------|---------
A     | $$bcn\sum^a_{i = 1} (\bar{y}_{i...} - \bar{y}_{....})^2$$ | $$a-1$$ | $$\frac{SSA}{dfA}$$ | $$\frac{MSA}{MSE}$$ 
B     | $$acn\sum^b_{j = 1} (\bar{y}_{.j..} - \bar{y}_{....})^2$$ | $$b-1$$ | $$\frac{SSB}{dfB}$$ | $$\frac{MSB}{MSE}$$ 
C     | $$abn\sum^b_{k = 1} (\bar{y}_{..k.} - \bar{y}_{....})^2$$ | $$c-1$$ | $$\frac{SSC}{dfC}$$ | $$\frac{MSC}{MSE}$$ 
AB    | $$cn \sum^a_{i = 1} \sum^b_{j = 1} (\bar{y}_{ij..} - \bar{y}_{i...} - \bar{y}_{.j..} + \bar{y}_{....})^2$$ | $$(a-1)(b-1)$$ | $$\frac{SSAB}{dfAB}$$ | $$\frac{MSAB}{MSE}$$ 
AC    | $$bn \sum^a_{i = 1} \sum^c_{k = 1} (\bar{y}_{i.k.} - \bar{y}_{i...} - \bar{y}_{..k.} + \bar{y}_{....})^2$$ | $$(a-1)(c-1)$$ | $$\frac{SSAC}{dfAC}$$ | $$\frac{MSAC}{MSE}$$ 
BC    | $$an \sum^b_{j = 1} \sum^c_{k = 1} (\bar{y}_{.jk.} - \bar{y}_{.j..} - \bar{y}_{..k.} + \bar{y}_{....})^2$$ | $$(b-1)(c-1)$$ | $$\frac{SSBC}{dfBC}$$ | $$\frac{MSBC}{MSE}$$ 
ABC   | $$n \sum_{ijkl} (y_{ijk.} - \bar{y}_{ij..} - \bar{y}_{i.k.} - \bar{y}_{.jk.} + \bar{y}_{i...} + \bar{y}_{.j..} + \bar{y}_{..k.} - \bar{y}_{....})^2$$ | $$(a-1)(b-1)(c-1)$$ | $$\frac{SSABC}{dfABC}$$ | $$\frac{MSABC}{MSE}$$
Error | $$\sum_{ijkl} (y_{ijkl} - \bar{y}_{ijk.})^2$$ | $$abc(n - 1)$$ | $$\frac{SSE}{dfE}$$ | | 
Total | $$\sum_{ijkl} (y_{ijk.} - \bar{y}_{...})^2$$ | $$abcn - 1$$ | | 

<p></p>

We need to consider the hierarchy principal when we consider these effects. If a higher order term is important, that means that a lower order term is important as well (and as in linear regression, should not be removed from the model). 

**Contrasts**

For contrasts, we have

* .$$A_{main} = \frac{1}{4} [(\bar{abc} - \bar{bc}) + (\bar{ab} - \bar{b}) + (\bar{ac} - \bar{c}) + (\bar{a} - \bar{1})]$$
* .$$B_{main} = \frac{1}{4} [(\bar{abc} - \bar{ac}) + (\bar{ab} - \bar{a}) + (\bar{bc} - \bar{c}) + (\bar{b} - \bar{1})]$$
* .$$C_{main} = \frac{1}{4} [(\bar{abc} - \bar{ab}) + (\bar{ac} - \bar{a}) + (\bar{bc} - \bar{b}) + (\bar{c} - \bar{1})]$$

* .$$AB_{int} = \frac{1}{4} [(\bar{abc} - \bar{bc}) - (\bar{ac} - \bar{c}) + (\bar{ab} - \bar{b}) - (\bar{a} - \bar{1})]$$
* .$$AC_{int} = \frac{1}{4} [(\bar{abc} - \bar{bc}) - (\bar{ab} - \bar{b}) + (\bar{ac} - \bar{c}) - (\bar{a} - \bar{1})]$$
* .$$BC_{int} = \frac{1}{4} [(\bar{abc} - \bar{ac}) - (\bar{ab} - \bar{a}) + (\bar{bc} - \bar{c}) - (\bar{b} - \bar{1})]$$

* .$$ABC_{int} = \frac{1}{4} [(\bar{abc} - \bar{bc}) - (\bar{ac} - \bar{c}) - (\bar{ab} - \bar{b}) - (\bar{a} - \bar{1})]$$

We can assess these effects by generating an interaction plot. We can also test these effects with a contrast test.

## Pairwise Comparisons and Contrasts

After rejecting a test that the means of the groups are not equal, we want to know exactly which ones are different. 

A contrast is a linear function of the group means. It can be used to compare two means or any set of groups of groups.

Procedure:

* An arbitrary contrast $$C = \Sigma^r_{i = 1} c_i \mu_i$$ where $$\Sigma^r_{i = 1} c_i = 0$$. There can be an infinite number of contrasts.
* $$C$$ is estimated with $$\hat{C} = \Sigma^r_{i = 1} c_i \bar{Y}_i$$ 
* The variance of the estimate $$\hat{C}$$ is $$s_{\hat{C}}^2 = \sigma^2_e \Sigma^r_{i = 1} \frac{c^2_i}{n_i}$$

We can test $$H_0: \sum c_i = 0$$ with 

$$T = \frac{\sum c_i \bar{y}_{i.}}{s_{\epsilon} \sqrt{\sum c_i^2 / n_i}}$$

which is distributed $$t_{dfE}$$ (two-sided test). Similarly a $$95$$% confidence interval can be created.

Note that when we have an ANOVA with $$k$$ treatments and a set of $$k - 1$$ orthogonal contrasts (ie $$c_i c_j = 0$$), then the SS will add up to $$SSTrt$$. One example of a set of orthogonal contrasts are linear, quadratic, cubic, etc contrasts.

When one is assessing multiple contrasts, it would be wise to control for [multiple comparisons][multiple_comp_link]{:target = "_blank"}. 

### Unbalanced ANOVAs

How do we assess effects when our designs are missing certain factor combinations? For this, contrasts can come in handy.

* Fit a one-way ANOVA as a combination of the factors 
* Fit a contrast to assess the effect you would like (perhaps the interaction)
* Use a MSE from the one-way ANOVA as an estimate of $$s^2_{\epsilon}$$

## Nonparametric Tests

### Ranked ANOVA
A nonparametric alternative to ANOVA requires a rank transformation. The procedure for this method is listed below.

1. Rank data set from largest to smallest
2. Analyze rank values in standard ANOVA

### Kruskal-Wallis Test
For this test, we make the following assumptions

* Independent samples
* Continuous variable
* Equal variances
* Identical (but non-normal) distributions

The steps for this test is as follows

1. Rank the combined data
2. Record the mean ranks for each group $$\bar{R}_i$$
3. Compute the test statistic

$$KW = (N - 1) \frac{\sum^k_{i = 1} n_i (\bar{R}_{i.} - \bar{R})^2}{\sum^k_{i = 1} \sum^{n_i}_{j = 1} (R_{ij} - \bar{R})^2}$$

where $$KW$$ is approximately distributed $$X^2_{k - 1}$$. When sample sizes are small, we can compare to permutations or distribution tables. 

### Friedman's Test
The nonparametric equivalent for the two-factor ANOVA is Friedman's test. We test the null hypothesis that each rank within each block is equally likely. 

The steps for this test is as follows

1. Rank the observations within each block
2. Record the mean ranks for each group $$\bar{R}_i$$ across blocks
3. Compute the test statistic

$$Q = N^2(k - 1) \frac{\sum^k_{i = 1} (\bar{R}_{i.} - \bar{R})^2}{\sum^k_{i = 1} \sum^{n_i}_{j = 1} (R_{ij} - \bar{R})^2}$$

where $$Q$$ is approximately distributed $$X^2_{k - 1}$$. When sample sizes are small, we can compare to permutations or distribution tables. 

# Tests of Equal Variance
**Levene's Test**

Levene's test is a formal test to assess $$H_0: \sigma^2_1 = ... = \sigma^2_k$$. 

Procedure:

1. Let $$d_{ij} = \| y_{ij} - \tilde{y_i} \|$$ where $$\tilde{y_i}$$ is the median of group $$i$$
2. Perform a one-way ANOVA on the $$d_{ij}$$
3. Reject $$H_0: \sigma^2_1 = ... = \sigma^2_k$$ if the $$F$$-test is significant

[stat_theory_link]: http://jnguyen92.github.io/nhuyhoa//2015/10/OLS-and-ANOVA.html
[multiple_comp_link]: http://jnguyen92.github.io/nhuyhoa//2016/02/Multiple-Comparisons.html
