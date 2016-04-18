---
layout: post
title: "Multiple Sample Tests part 1"
date: "January 28, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# ANOVA

**Assumptions**

Regardless of the type, ANOVAs have the same assumptions:

1. Independence: within and across treatments
2. Normality: $$Y_{ij} \sim N(\mu_i, \sigma^2_i)$$
3. Equal Variance: $$\sigma^2_1 = ... = \sigma^2_k$$

## Factorial Designs
Factorial designs refer to designs in which all possible combinations of factors are applied to the experimental units.

### Completely Randomized Single Factor ANOVA 

**Model Formulations**

Consider a design with $$k$$ groups where there are $$n_i$$ observations on the $$i^{th}$$ treatment. Let $$y_{ij}$$ denote the $$j^{th}$$ observation on the $$i^{th}$$ treatment. 

$$Y_{ij} = \mu_i + \epsilon_{ij}$$ 

where $$\epsilon_{ij}$$ ~ iid$$N(0, \sigma^2_{\epsilon})$$

$$Y_{ij} = \mu + \alpha_i + \epsilon_{ij}$$ 

where $$\epsilon_{ij}$$ ~ iid$$N(0, \sigma^2_{\epsilon})$$. 

We assume $$\sum \alpha_i = 0$$ if $$H_0$$ is true.

**ANOVA Table**

We have the following terms

* treatment sum: $$y_{i.} = \sum^{n_i}_{j = 1} y_{ij}$$
* treatment mean: $$\bar{y}_{i.} = y_{i.}/n_i$$
* overall sum: $$y_{..} = \sum^k_{i = 1} \sum^{n_i}_{j = 1} y_{ij}$$
* overall mean: $$\bar{y}_{..} = y_{..} / N$$

Source| Sum of Squares | Degrees of Freedom | Mean Square | E[MS] | F 
------|----------------|--------------------|-------------|-------|---
Trt   | $$\sum^k_{i = 1} n_i(\bar{y}_{i.} - \bar{y}_{..})^2$$ | $$k-1$$ | $$\frac{SSTrt}{dfTrt}$$ | $$\sigma^2_{\epsilon} + \frac{n}{k - 1} \sum^k_i \alpha_i^2$$ | $$\frac{MSTrt}{MSE}$$ 
Error | $$\sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{i.})^2$$ | $$k(n-1)$$ | $$\frac{SSE}{dfE}$$ | $$\sigma^2_{\epsilon}$$ |
Total | $$\sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{..})^2$$ | $$kn-1$$ | | 

<p></p>
 
where $$F \sim F_{dfTrt, dfErr}$$. When $$F$$ is large, we say that the group effect is large so we reject the null hypothesis that the groups are the same.

We can derive this distribution from [probability theory][stat_theory_link]{:target = "_blank"}. The value $$\frac{df * MS}{\sigma^2}$$ is distributed $$X^2$$. So 

$$F = \frac{ \frac{df * MS}{\sigma^2} / df }{ \frac{dfErr * MSErr}{\sigma^2} / dfErr } = \frac{ MSTrt }{ MSErr }$$ 

is distributed $$F_{df, dfErr}$$. 

Another way to look at this is to consider if $$H_0$$ is true. Then 

$$\frac{E[MSTrt]}{E[MSE]} = 1 + \frac{1}{k - 1} \frac{n \sum^k_i \alpha^2_i}{\sigma^2_{\epsilon}}$$ 

Note that if $$\sum \alpha_i \approx 0$$, then this ratio $$\approx 1$$. The power of the $$F$$ test is a monotone function of $$\frac{n \sum^k_i \alpha^2_i}{\sigma^2_{\epsilon}}$$.

### Completely Randomized Two Factor ANOVA

**Model Formulations**

$$Y_{ijl} = \mu + \alpha_i + \beta_j + (\alpha \beta)_{ij} + \epsilon_{ijl}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$j = 1, ..., b$$ denotes the levels of factor B
* $$l = 1, ..., n$$ denotes replicates of each factor combination
* $$\epsilon_{ijl} \sim N(0, \sigma^2_{\epsilon})$$ represents the plot error

If $$H_0$$ is true, then $$\sum \alpha_i = 0$$, $$\sum \beta_j = 0$$, $$\sum_i (\alpha \beta)_{ij} = 0$$, and $$\sum_j (\alpha \beta)_{ij} = 0$$.

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | MS | E[MS]
------|----------------|--------------------|----|-------
A     | $$bn\sum^a_{i = 1} (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$a-1$$ | $$MSA$$ | $$\sigma^2_{\epsilon} + \frac{bn}{a - 1} \sum \alpha^2_i$$
B     | $$an\sum^b_{j = 1} (\bar{y}_{.j.} - \bar{y}_{...})^2$$ | $$b-1$$ | $$MSB$$ | $$\sigma^2_{\epsilon} + \frac{an}{b - 1} \sum \beta^2_j$$
AB    | $$n \sum^a_{i = 1} \sum^b_{j = 1} (\bar{y}_{ij.} - \bar{y}_{i..} - \bar{y}_{.j.} + \bar{y}_{...})^2$$ | $$(a-1)(b-1)$$ | $$MSAB$$ | $$\sigma^2_{\epsilon} + \frac{n}{(a - 1)(b - 1)} \sum (\alpha \beta)^2_{ij}$$
Error | $$\sum^a_{i = 1} \sum^b_{j = 1} \sum^n_{l = 1} (y_{ijl} - \bar{y}_{ij.})^2$$ | $$ab(n - 1)$$ | $$MSE$$ | $$\sigma^2_{\epsilon}$$
Total | $$\sum^a_{i = 1} \sum^b_{j = 1} \sum^n_{l = 1} (y_{ijl} - \bar{y}_{...})^2$$ | $$abn - 1$$ 

<p></p>

Note that we have three separate $$F$$ tests with the error as the demonimator (similar to the single factor case) to assess the $$A_{main}$$, $$B_{main}$$, and $$AB_{int}$$ effects. 

**Contrasts**

Let $$\bar{ab}$$ denote the mean of the high-high group, $$\bar{a}$$ denote the mean of high-low group, $$\bar{b}$$ denote the mean of the low-high group, and $$\bar{1}$$ denote the mean of the low-low group. We have

* .$$A_{main} = \frac{1}{2} [(\bar{ab} - \bar{b}) + (\bar{a} - \bar{1})]$$
* .$$B_{main} = \frac{1}{2} [(\bar{ab} - \bar{a}) + (\bar{b} - \bar{1})]$$
* .$$AB_{int} = \frac{1}{2} [(\bar{ab} - \bar{b}) - (\bar{a} - \bar{1})]$$

We can assess these effects by generating an interaction plot. By assessing the trends and parallelism of lines, we can determine whether there may be evidence of an interaction effect. We can also test these effects with a contrast test.

### Completely Randomized Three Factor ANOVA

**Model Formulations**

$$Y_{ijkl} = \mu + \alpha_i + \beta_j + \gamma_k + (\alpha \beta)_{ij} + (\alpha \gamma)_{ik} + (\beta \gamma)_{jk} \epsilon_{ijkl}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$j = 1, ..., b$$ denotes the levels of factor B
* $$k = 1, ..., c$$ denotes the levels of factor C
* $$l = 1, ..., n$$ denotes replicates of each factor combination
* $$\epsilon_{ijkl} \sim N(0, \sigma^2_{\epsilon})$$ represents the plot error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom 
------|----------------|--------------------
A     | $$bcn\sum^a_{i = 1} (\bar{y}_{i...} - \bar{y}_{....})^2$$ | $$a-1$$ 
B     | $$acn\sum^b_{j = 1} (\bar{y}_{.j..} - \bar{y}_{....})^2$$ | $$b-1$$ 
C     | $$abn\sum^b_{k = 1} (\bar{y}_{..k.} - \bar{y}_{....})^2$$ | $$c-1$$
AB    | $$cn \sum^a_{i = 1} \sum^b_{j = 1} (\bar{y}_{ij..} - \bar{y}_{i...} - \bar{y}_{.j..} + \bar{y}_{....})^2$$ | $$(a-1)(b-1)$$ 
AC    | $$bn \sum^a_{i = 1} \sum^c_{k = 1} (\bar{y}_{i.k.} - \bar{y}_{i...} - \bar{y}_{..k.} + \bar{y}_{....})^2$$ | $$(a-1)(c-1)$$ 
BC    | $$an \sum^b_{j = 1} \sum^c_{k = 1} (\bar{y}_{.jk.} - \bar{y}_{.j..} - \bar{y}_{..k.} + \bar{y}_{....})^2$$ | $$(b-1)(c-1)$$ 
ABC   | $$n \sum_{ijkl} (y_{ijk.} - \bar{y}_{ij..} - \bar{y}_{i.k.} - \bar{y}_{.jk.} + \bar{y}_{i...} + \bar{y}_{.j..} + \bar{y}_{..k.} - \bar{y}_{....})^2$$ | $$(a-1)(b-1)(c-1)$$ 
Error | $$\sum_{ijkl} (y_{ijkl} - \bar{y}_{ijk.})^2$$ | $$abc(n - 1)$$ 
Total | $$\sum_{ijkl} (y_{ijk.} - \bar{y}_{...})^2$$ | $$abcn - 1$$ 

<p></p>

Note that we have many separate $$F$$ tests with the error as the demonimator (similar to the single factor case).

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

### Randomized Complete Block Design (One Factor) ANOVA

Blocking is a generalization of the paired analysis in t-tests. We expect there to be block to block variability, a nuisance factor. The observations in the same block share a block effect and are less variable than observations in other blocks. By accounting for the block variability, we decrease the unaccounted variability and make the test for treatment more powerful. 

A single block should be homogeneous. To ensure this homogeneity, we want to make sure blocks are small enough that

* all treatments are contained with a block but
* there are no duplicated treatments within a block

**Model Formulations**

$$Y_{ij} = \mu + \alpha_i + \beta_j + \epsilon_{ij}$$

where

* $$i = 1, ..., k$$ denotes the levels of treatment
* $$j = 1, ..., b$$ denotes the levels of blocks
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ represents the plot error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom 
------|----------------|--------------------
Blocks| $$k\sum^b_{j = 1} (\bar{y}_{.j} - \bar{y}_{..})^2$$ | $$b-1$$ 
Trt   | $$b\sum^k_{i = 1} (\bar{y}_{i.} - \bar{y}_{..})^2$$ | $$k-1$$ 
Error | $$\sum_{ij} (y_{ij} - \bar{y}_{i.} - \bar{y}_{.j} + \bar{y}_{..})^2$$ | $$(k-1)(b-1)$$ 
Total | $$\sum_{ij} (y_{ij} - \bar{y}_{..})^2$$ | $$kb - 1$$ 

<p></p>

We can assess the effect of treatment with an $$F$$ test with the error in the denominator. 

Note that we can ignore the $$F$$ test for the effect of blocks. The blocks were used in order to account for variability. (If we want to test for a specific effect, we should include it in the model as a factor and randomize its assignment). A significant test would indicate that we were right to block. If we did not find a significant block effect, we should not pool the block with error and analyze the data as a completely randomized design! We need to analyze the data as we have designed it, otherwise we would bias our tests. 

We notice several things from this table. One is that this table is reminiscent of the ANOVA table for two-factor ANOVA where $$n = 1$$. Another similarity is that the $$SS$$ and $$df$$ for error is similar to the $$SS$$ and $$df$$ for the interaction term in the two-factor case. This is because we assume an additive model and so the error that is normally given to the interaction is transferred to the error. We say that the interaction term is confounded with the error.

Thus RCBD with one factor is the same as a completely randomized two-factor ANOVA where $$n = 1$$.

### Randomized Complete Block Design (Two Factor) ANOVA

**Model Formulations**

$$Y_{ijk} = \mu + \alpha_i + \beta_k +  \gamma_j + (\alpha \gamma)_{ij} +
\epsilon_{ij}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$j = 1, ..., b$$ denotes the levels of blocks
* $$k = 1, ..., c$$ denotes the levels of factor C
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ represents the plot error

**ANOVA Table**

Source| Degrees of Freedom 
------|---------------------
Blocks| $$b-1$$
A     | $$a-1$$
C     | $$c-1$$
AC    | $$(a-1)(c-1)$$
Error | $$(b-1)(ac-1)$$

<p></p>

Again, notice that the $$df$$ for the error can be rewritten as $$(b-1)(ac-1) = (a - 1)(b - 1)(c - 1) + (b - 1)(c - 1) + (a - 1)(b - 1)$$. This is the pooled $$df$$ from the $$AB$$, $$BC$$, and $$ABC$$ interaction; we assume there are no interactions with block and use those terms as the error. 

### Latin Squares

Latin squars are experimental designs that block in two directions. These designs require the number of row blocks = number of column blocks = number of treatment levels. 

In Latin Square designs, there are not values for every combination of $$i$$, $$j$$, $$k$$. The means include only the $$y_{ijl}$$ terms that exist. There will be $$k^2$$ of them. 

**Model Formulations**

$$Y_{ijl} = \mu + \alpha_i + r_j + c_l + \epsilon_{ij}$$

where

* $$i = 1, ..., k$$ denotes the levels of treatment
* $$j = 1, ..., k$$ denotes the levels of row blocks
* $$l = 1, ..., k$$ denotes the levels of column blocks
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ represents the plot error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom 
------|----------------|--------------------
Row   | $$k \sum^k_j (\bar{y}_{.j.} - \bar{y}_{...})^2$$ | $$k-1$$ 
Column| $$k \sum^k_l (\bar{y}_{..l} - \bar{y}_{...})^2$$ | $$k-1$$ 
Trt   | $$k \sum^k_i (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$k-1$$ 
Error | By subtraction | $$(k-1)(k-2)$$ 
Total | $$\sum_{ijl} (y_{ijl} - \bar{y}_{...})^2$$ | $$k^2 - 1$$ 

<p></p>

We can assess the effect of treatment with an $$F$$ test with the error in the denominator. 

## Random Effects and Mixed Models

### Simple Random Effect Model

**Model Formulations**

$$Y_{ij} = \mu + A_i + \epsilon_{ij}$$

where

* $$i = 1, ..., k$$ denotes the levels of treatment
* $$j = 1, ..., n$$ denotes the experimental units for each treatment
* $$A_i \sim N(0, \sigma^2_A)$$ corresponds to the random effect (group variation)
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ represents the error within each group

Note that this is quite similar to the fixed effects (previous models) that were covered. However, $$A_i$$ represents a sample from some population $$N(0, \sigma^2_A)$$ which we are interested in (rather than specific distinct group). 


**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | E[MS]
------|----------------|--------------------|-------------|---------
Trt   | $$\sum^k_{i = 1} n_i(\bar{y}_{i.} - \bar{y}_{..})^2$$ | $$k-1$$ | $$MSTrt$$ | $$\sigma^2_{\epsilon} + n \sigma^2_A$$ 
Error | $$\sum^k_{i = 1} \sum^{n_i}_{j = 1} (y_{ij} - \bar{y}_{i.})^2 = \sum^k_{i = 1} (n_i - 1) s_i^2$$ | $$k(n-1)$$ | $$MSE$$ | $$\sigma^2_{\epsilon}$$
Total | $$\sum_{ij} (y_{ij} - \bar{y}_{..})^2 = \sum_{all.obs} (y_{ij} - \bar{y}_{..})$$ | $$kn-1$$ | | 

<p></p>

We test $$H_0: \sigma^2_A = 0$$ vs. $$H_A: \sigma^2_A > 0$$ with $$F = \frac{MSTrt}{MSE}$$. 

**Variance Components**

Based off this ANOVA table, we use $$\hat{\sigma}^2_{\epsilon} = MSE$$ and $$\hat{\sigma}^2_A = \frac{MSTrt - MSE}{n}$$.

Another important quantity is the intraclass correlation coefficient

$$ICC = \frac{s^2_{b/n trt}}{s^2_{b/n trt} + s^2_{within trt}}$$

This value is the correlation between the observations within the group. Small values indicate large spread of values at each level of treatment. Large values indicate little spread at each level of treatment.

**Other**

Note that a confidence interval would be $$\bar{y}_{..} \pm t_{\alpha/2, k-1} \sqrt{MSTrt/(nk)}$$.

We can use the expected MS to find the variance of $$Y$$.

----------------|----------------
$$Var(Y_{ij})$$ | $$= \sigma^2_A + \sigma^2_{\epsilon}$$
$$Var(\bar{y}_{..})$$ | $$= Var(\mu + \hat{A}_. + \hat{\epsilon})$$
                | $$=\frac{\sigma^2_A}{k} + \frac{\sigma^2_{\epsilon}}{nk}$$
                | $$=\frac{n\sigma^2_A + \sigma^2_{\epsilon}}{nk}$$
                
Note that $$Var(\bar{y}_{..})$$ $$\rightarrow 0$$ as $$k \rightarrow \infty$$ and $$\rightarrow \sigma^2_{\epsilon} / k$$ as $$n \rightarrow \infty$$. Thus it is better to increase the number of experimental units rather than the number of subsamples. 

### Models with Subsampling

To understand models with subsampling, we define the following:

An **experimental unit** is the group to which a treatment is applied in a single trial of the experiment. We may also call an experimental unit "a plot". 

A **sampling unit** is a subunit within (nested inside) an experimental unit. When analyzing experimental data, we either have to adjust for a sampling unit in the model or average sampling units for each experimental unit prior to analysis. Treating sampling units as experimental units can inflate the error $$df$$. 

Consider a one-sample test with subsampling. The model is written as

$$Y_{ij} = \mu + \epsilon_i + \delta_{ij}$$ 

where $$\epsilon_i \sim N(0, \sigma^2_{\epsilon})$$ and $$\delta_{ij} \sim N(0, \sigma^2_{\delta})$$. In this setting $$\epsilon$$ represents the experimental units, while $$\delta$$ represents the subsamples.

One interesting note is that this model will give equivalent results if one were to average the subsamples (technical replicates) and run a regular ANOVA. In other words,

$$\bar{Y}_{ij.} = \mu + \alpha_i + \epsilon_{ij} + \bar{\delta}_{ij.} = \mu + \alpha_i + e_{ij}$$

Models with subsampling are essentially the same as models that average those subsamples for each experimental unit. Thus even though the $$SS$$ and $$MS$$ for these models are different, the $$F$$ statistic, degrees of freedom, and p-value for effects are all the same. If we decide not to average subsamples, we need to appropriately account for them. 

### Completely Randomized Design with Subsampling

Consider an experiment where the treatments are fixed but we take subsamples which are random. This is an example of a mixed model.

**Model Formulations**

$$Y_{ijl} = \mu + \alpha_i + \epsilon_{ij} + \delta_{ijl}$$

where

* $$i = 1, ..., k$$ denotes the levels of treatment
* $$j = 1, ..., n$$ denotes the experimental units for each treatment
* $$l = 1, ..., s$$ denotes the subsample within each experimental unit
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ corresponds to the error within experimental units
* $$\delta_{ijl} \sim N(0, \sigma^2_{\delta})$$ represents the subsample error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | E[MS]
------|----------------|--------------------|-------------|---------
Trt   | $$sn \sum^k_{i} (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$k-1$$ | $$MSTrt$$ | $$\sigma^2_{\delta} + s \sigma^2_{\epsilon} + ns \sum^k_i \frac{\alpha_i^2}{k - 1}$$ 
Plot Error | $$s \sum^k_{i} \sum^{n}_{j} (\bar{y}_{ij.} - \bar{y}_{i..})^2$$ | $$k(n-1)$$ | $$MSPE$$ | $$\sigma^2_{\delta} + s\sigma^2_{\epsilon}$$
Subsample Error | $$\sum_{ijl} (y_{ijl} - \bar{y}_{ij.})^2$$ | $$kn(s-1)$$ | $$MSSSE$$ | $$\sigma^2_{\delta}$$
Total | $$\sum_{ijl} (y_{ijl} - \bar{y}_{...})^2$$ | $$kns-1$$ | | 

<p></p>

Notice that the expected MS are a little different. To conduct our $$F$$ test for treatment, we compute $$F = \frac{MSTrt}{MSPE}$$, where $$E[F] = 1 + 1 + ns \sum^k_i \alpha^2_i / (k - 1)$$. 

The guideline here is that when testing any source of variability for significance, we look for a denominator for the $$F$$ test that contains all the elements of the $$E[MS]$$ except the source of interest.

To calculate the differences of mean $$y$$ for different treatments, we can calculate

$$Var(\bar{y}_{i..} - \bar{y}_{i'..}) = MSPE \left(\frac{1}{ns} + \frac{1}{ns} \right)$$

### Randomized Complete Block Design with Subsampling

**Model Formulations**

$$Y_{ijl} = \mu + \alpha_i + \beta_j + \epsilon_{ij} + \delta_{ijl}$$

where

* $$i = 1, ..., k$$ denotes the levels of treatment
* $$j = 1, ..., b$$ denotes the blocks
* $$l = 1, ..., s$$ denotes the subsample within each plot
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ corresponds to the plot error
* $$\delta_{ijl} \sim N(0, \sigma^2_{\delta})$$ represents the subsample error

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | E[MS]
------|----------------|--------------------|-------------|---------
Blocks| $$ks \sum_j (\bar{y}_{.j.} - \bar{y}_{...})^2$$ | $$b-1$$ | $$MSBlk$$ | $$\sigma^2_{\delta} + s \sigma^2_{\epsilon} + ks \sum^b_j \frac{\beta_j^2}{b - 1}$$ 
Trt   | $$bs \sum^k_{i} (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$k-1$$ | $$MSTrt$$ | $$\sigma^2_{\delta} + s \sigma^2_{\epsilon} + bs \sum^k_i \frac{\alpha_i^2}{k - 1}$$ 
Plot Error | $$s \sum_{ij} (\bar{y}_{ij.} - \bar{y}_{i..} - \bar{y}_{.j.} +\bar{y}_{...})^2$$ | $$(k-1)(b-1)$$ | $$MSPE$$ | $$\sigma^2_{\delta} + s\sigma^2_{\epsilon}$$
Subsample Error | $$\sum_{ijl} (y_{ijl} - \bar{y}_{ij.})^2$$ | $$kb(s-1)$$ | $$MSSSE$$ | $$\sigma^2_{\delta}$$
Total | $$\sum_{ijl} (y_{ijl} - \bar{y}_{...})^2$$ | $$kbs-1$$ | | 

<p></p>

Notice that the degrees of freedom for the whole plot error can also be considered the interaction between $$A$$ and $$B$$. This is because we assume no interaction and those degrees of freedom are transferred to the error. 

## Many Options of Mixed Models

We can have any number of designs (fixed, random, mixed, factorial, nested) with any number of factors. Different designs will lead to different $$F$$ tests. It is important to look at $$E[MS]$$ to determine the appropriate $$F$$ test construction. 

For fixed effects $$\sum effect = 0$$ and for random effects ~ $$N(0, \sigma^2)$$.

## Split Plot Designs

Split plot designs refer to experiments where multiple treatments are applied in a sequence. The levels of the first factor are randomly applied to experimental units. Then the levels of the second factor are applied to subunits within the application of the first factor. Another way to look at this is that an experimental unit used in the first factor is split to generate experimental units for the second factor. Think of it as each plot level being its own experiment. 

### Completely Randomized Split Plot Design

**Model Formulations**

$$Y_{ijk} = \mu + \alpha_i + \epsilon_{ij} + \gamma_{k} + (\alpha \gamma)_{ij} + \delta_{ijk}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$k = 1, ..., c$$ denotes the levels of factor C
* $$j = 1, ..., b$$ denotes experimental units (whole plot) for each factor of A
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ corresponds to the whole plot error 
* $$\delta_{ijk} \sim N(0, \sigma^2_{\delta})$$ represents the subplot error
* $$\epsilon_{ij}$$ is independent of $$\delta_{ijk}$$

**ANOVA Table**

Source| Sum of Squares | Degrees of Freedom | Mean Square | E[MS]
------|----------------|--------------------|-------------|---------
A     | $$bc \sum_i (\bar{y}_{i..} - \bar{y}_{...})^2$$ | $$a-1$$ | $$MSA$$ | $$\sigma^2_{\delta} + c\sigma^2_{\epsilon} + \frac{bc\sum_i \alpha_i^2}{a - 1}$$ 
WP Error  | $$c \sum_{ij} (\bar{y}_{ij.} - \bar{y}_{i..})^2$$ | $$a(b-1)$$ | $$MSWP$$ | $$\sigma^2_{\delta} + c\sigma^2_{\epsilon}$$
C     | $$ab\sum_k (\bar{y}_{..k} - \bar{y}_{...})^2$$ | $$c - 1$$ | $$MSC$$ | $$\sigma^2_{\delta} + \frac{ab\sum_k \gamma_k^2}{c - 1}$$
AC    | $$b \sum_{ik} (\bar{y}_{i.k} - \bar{y}_{i..} - \bar{y}_{..k} + \bar{y}_{...})^2$$ | $$(a-1)(c-1)$$ | $$MSAC$$ | $$\sigma^2_{\delta} + \frac{b \sum_{ik} (\alpha \gamma)_{ik}^2}{(a - 1)(c - 1)}$$
SP Error  | $$\sum_{ijk} (y_{ijk} - \bar{y}_{i..} - \bar{y}_{..k} + \bar{y}_{...})^2$$ | $$a(b-1)(c-1)$$ | $$MSSP$$ | $$\sigma^2_{\delta}$$
Total | $$\sum_{ijk} (y_{ijk} - \bar{y}_{...})^2$$ | $$abc-1$$ | | 

<p></p>

Again as with mixed models, we look at $$E[MS]$$ to determine the appropriate $$F$$ test construction.


We can obtain the following variance estimates for comparisons

* Comparisons within the same whole plot treatment: $$Var(\bar{Y}_{1.1} - \bar{Y}_{1.2}) = \frac{2\sigma^2_{\delta}}{b}$$
* Comparisons across whole plot treatments: $$Var(\bar{Y}_{1.1} - \bar{Y}_{2.1}) = \frac{2(\sigma^2_{\delta} + c\sigma^2_{\epsilon})}{b}$$
* Comparisons of whole plot treatment means: $$Var(\bar{Y}_{1..} - \bar{Y}_{2..}) = \frac{2(\sigma^2_{\delta} + c\sigma^2_{\epsilon})}{bc}$$
* Comparisons of subplot treatment means: $$Var(\bar{Y}_{..1} - \bar{Y}_{..1}) = \frac{2\sigma^2_{\delta}}{ab}$$


### Randomized Complete Block Split Plot Designs

**Model Formulations**

$$Y_{ijk} = \mu + \alpha_i + \beta_j + \epsilon_{ij} + \gamma_{k} + (\alpha \gamma)_{ik} + \delta_{ijk}$$

where

* $$i = 1, ..., a$$ denotes the levels of factor A
* $$k = 1, ..., c$$ denotes the levels of factor C
* $$j = 1, ..., b$$ denotes blocks at the whole plot
* $$\epsilon_{ij} \sim N(0, \sigma^2_{\epsilon})$$ corresponds to the whole plot error 
* $$\delta_{ijk} \sim N(0, \sigma^2_{\delta})$$ represents the subplot error
* $$\epsilon_{ij}$$ is independent of $$\delta_{ijk}$$

**ANOVA Table**

Source | Degrees of Fredom | E[MS]
-------|-------------------|------
Block  | $$b-1$$ | $$\sigma^2_{\delta} + c \sigma^2_{\epsilon} + \frac{ab \sum_j \beta^2_j}{b - 1}$$
A      | $$a-1$$ | $$\sigma^2_{\delta} + c \sigma^2_{\epsilon} + \frac{bc \sum_i \alpha^2_i}{a - 1}$$
WP Error | $$(a-1)(b-1)$$ | $$\sigma^2_{\delta} + c \sigma^2_{\epsilon}$$
C      | $$c-1$$ | $$\sigma^2_{\delta} + \frac{ab \sum_k \gamma^2_k}{c - 1}$$
AC     | $$(a-1)(c-1)$$ | $$\sigma^2_{\delta} + \frac{b \sum_{ik} (\alpha \gamma)_{ik}}{(a-1)(c-1)}$$
SP Error | $$a(b-1)(c-1)$$ | $$\sigma^2_{\delta}$$
Total  | $$abc-1$$ |

Notice that the $$df$$ for the wholeplot error is essentially the interaction between $$AB$$. The $$df$$ for the subplot error can be rewritten as $$a(b-1)(c-1) = (b-1)(c-1) + (a-1)(b-1)(c-1)$$. These are the pooled $$df$$ from the $$BC$$ and $$ABC$$ interaction. 

## Statistical Software

In R, ANOVA can be fit with the `lm()` and `anova()` or `aov()` commands. Confirm that the predictors are factors.

In SAS, ANOVA can be fit with the `proc glm` or `proc mixed` commands.


{% highlight r %}
proc glm;
  # these are the categorical variables
  class x1 x2; 
  # model statement with option for no intercept, Type 1 SS, Type 3 SS
  model y = x1 x2 x1*x2 / noint e1 e3; 
  # conducts a test on x1 factor using interaction as error (useful for mixed models)
  test h = x1 e = x1*x2; 
  random x1*x2 / test;

  # lsmeans and pairwise comparisons/contrasts
  lsmeans x1 x2 / tdiff pdiff cl adjust = tukey;
  # can also define contrasts
  contrast "name" x1 1 1 -1 -1 / e;
  # output the model diagnostics for plotting and whatnot
  output out = outfile p = yhat r = resid rstudent = rstud;
run;
{% endhighlight %}

Some notes on terms

* Type 1 SS takes takes into account fitting order given by model
* Type 3 SS is the SS of that variable when fit last
* LSMEANS is the mean after other variables in the model has been accounted for (blocks, etc)
* If there are missing data or unbalanced designs, it is best to use Type 3 SS and LSMEANS


{% highlight r %}
# Fitting Mixed Models: 2 ways

proc glm;
  class wholeplot subplot;
  model y = A B A*B field(A); 
  random field(A) / test; 
run;

proc mixed method = type3;
  class A B Field;
  model response = A B A*B;
  random field(A);
run;
{% endhighlight %}

Some notes on terms

* `b(a)` means $$b$$ is nested within $$a$$
* `proc glm` requires the plot error to be in the model term as well as the random term, `proc mixed` doesn't

[stat_theory_link]: http://jnguyen92.github.io/nhuyhoa//2015/10/Distribution-Facts.html
