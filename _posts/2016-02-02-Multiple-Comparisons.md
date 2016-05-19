---
layout: post
title: "Multiple Comparisons"
date: "February 2, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# Type 1 and Type 2 Error Rates

* Type 1 Error: $$P($$reject $$H_0$$, given $$H_0$$ is true$$) = \alpha$$, aka false positive rate
* Type 2 Error: $$P($$do not reject $$H_0$$, given $$H_0$$ is false$$) = \alpha$$, aka false negative rate
* Power: $$1 -$$ $$Type$$ $$2$$ $$Error$$ $$Rate$$

# Why It's Needed
When conducting multiple (independent) tests, it is important to account for the number of tests. Assume that each test has a type I error rate of $$\alpha = 0.05$$. 

If $$p$$ number of tests are conducted, the probability that no error is made on on any of those tests is $$(1 - \alpha)^p$$. From this, the probability of making an error if $$p$$ tests are conducted is 

Number of Tests | P(Type 1 Error) = 1 - P(rejection)
----------------|-----------------------------------
    $$1$$       |   $$1 - (1 - \alpha)^1$$
    $$2$$       |   $$1 - (1 - \alpha)^1$$
    ...         |   ...
    $$p$$       |   $$1 - (1 - \alpha)^p$$

<p></p>

<img src="/nhuyhoa/figure/source/2016-02-02-Multiple-Comparisons/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

The error rates rapidly increases. The type 1 error rate is approximately $$50$$% when $$13$$ tests are conducted. Thus it is important have a way to correct for these multiple tests to ensure that the Type 1 error rate remains low.

# Multiple Comparisons for Continuous Data
Note that what number and what specific comparisons should be determined in advance (prior to receiving results) to eliminate bias.

Also note that the assumptions of the overall test (ex: ANOVA) also apply to these tests. 

## Fischer's Least Significant Difference (LSD)
Fischer's LSD method first performs the ANOVA $$F$$ test and proceeds with pairwise comparisons if the $$F$$ test is significant. 

For balanced groups, the groups are significantly different if $$\vert \bar{y}_{i.} - \bar{y}_{i'.} \vert \ge T_{dfE, \alpha / 2} s_{\epsilon} \sqrt{2 / n}$$. 

For unbalanced groups, this is a series of t-tests taking into account the sample sizes, comparing $$\vert \bar{y}_{i.} - \bar{y}_{i'.} \vert \ge T_{dfE, \alpha / 2} s_{\epsilon} \sqrt{1 / n_i + 1/n_{i'}}$$. 

Fischer's LSD method ignores the multiple comparisons problem and does not correct for multiple tests. It uses a predetermined $$\alpha$$ value for all tests, even though it may result in high type 1 error rates. Therefore this test is quite liberal. In increasing the type 1 error rate, type 2 error rate decreases. Therefore, Fischer's LSD method results in maximizing power. 

In the non-parametric Kruskal-Wallis test, reject if $$\vert \bar{R}_i - \bar{R}_j \vert \ge z_{\alpha / 2} \sqrt{\frac{N(N + 1)}{12} (1 / n_i + 1/n_j)}$$.

## Dunnett's Method

When comparing treatment levels to a control, Dunnett's mean comparsion method can be used. There is a special table to obtain the critical values for the $$k-1$$ pairwise tests. This test provides more power compared to a test using the full set of all pairwise comparisons.

## Bonferroni Correction

Say there are $$r$$ tests (don't have to compare all groups). Let $$A^c$$ be a type I error event. Then, <br>
$$P(\cap^r_{i=1} A_i) = 1 - P(\cup^r_{i=1} A^c_i) \ge 1 - \Sigma^r_{i = 1} P(A^c_i) $$

To control the family-wise Type 1 error rate (the probability of making one or more Type 1 errors in a family/set of tests) set

$$\alpha = FWER = P(reject any H_0 | H_0)$$ 

by setting $$P(A^c_i) = \alpha / r$$.

So Bonferroni's method for correcting for multiple tests states that if an overall type I error rate of $$\alpha$$ is desired, set 

$$\alpha_i = \alpha / r$$ 

where $$r$$ is the number of tests and $$\alpha_i$$ is the type I error rate for each individual test. 

The bonferroni p-value is

$$p_{bonf} = min(n * p, 1)$$

Using bonferroni's correction, it is guaranteed an overall type 1 error rate of $$0.05$$. Unfortunately, the bonferroni method is very conservative, in which the type 2 error rate is very high and power is very low for each individual test.

Note that Bonferroni's correction is valid for equal and unequal sample sizes.

**Example**

* Want an overall error rate of $$ \alpha = 0.05 $$ with $$20$$ tests. 
* For each individual test use $$ \alpha_i = 0.05 / 20 = 0.0025 $$.
* With bonferroni correction, overall type 1 error rate is just under $$0.05$$

$$P($$overall type 1 error$$) = 1 - (1 - 0.0025)^{20} = 0.0488$$

* Without bonferroni correction, overall type 1 error rate is $$0.64$$

$$P($$overall type 1 error$$) = 1 - (1 - 0.05)^{20} = 0.64$$

## Holm-Bonferroni

The procedure for the Holm-Bonferroni method is as follows:

* Put adjusted p-values in order from smallest to largest: $$p_{(1)} \le p_{(2)} \le ... \le p_{(r)}$$
* If $$p_{(1)} > \alpha / r$$ then accept all $$H_0$$
* If $$p_{(1)} < \alpha / r$$ then reject corresponding $$H_0$$ then look at $$p_{(2)}$$
* If $$p_{(2)} > \alpha / (r - 1)$$ then accept all remaining $$H_0$$ 
* If $$p_{(2)} < \alpha / (r - 1)$$ then reject corresponding $$H_0$$ then look at $$p_{(3)}$$
* In general at the $$i$$th stage, compare $$p_{(i)}$$ to $$\alpha / (r - i + 1)$$

The Holm-Bonferroni p-value is

$$p_{H(i)} = min((r - i + 1)p_{(i)}, 1)$$

## Tukey Method
Tukey's method is done post-ANOVA. It must be used to examine all pairwise comparisons, where each group must have equal sample sizes. With Tukey's method, the overall type 1 error is equal to $$\alpha$$.

Tukey's method is uses the studentized range distribution. The studentized range is defined as 

$$q_{m, df} = \frac{w}{s}$$

where the observations $$Y_i \sim iidN(\mu, \sigma^2)$$. The value $$w$$ is the range of the observations and $$s$$ is the estimated standard deviation. The distribution parameters are $$m = $$ number of groups and $$df = $$ degrees of freedom for $$s^2$$.

Procedure:

* Fit an ANOVA: `a <- aov(Petal.Length ~ Species, data = iris)`
* Compute pairwise tests: `TukeyHSD(a)`

For balanced designs, compare $$\vert \bar{y}_{i.} - \bar{y}_{i'.} \vert$$ to $$Q_{k, dfE, \alpha} s_{\epsilon} \sqrt{1/n}$$ where $$k$$ denotes the number of treatments.

For unbalanced designs, compare to $$Q_{k, dfE, \alpha} s_{\epsilon} \sqrt{1/2 (1/n_i + 1/n_{i'})}$$. This is known as the Tukey-Kramer method.

In the non-parametric Kruskal-Wallis test, reject if $$\vert \bar{R}_i - \bar{R}_j \vert \ge Q_{k, \infty, \alpha} \sqrt{\frac{N(N + 1)}{24} (1 / n_i + 1/n_j))}$$.

Tukey's method can also be applied to contrasts. The $$(1-\alpha) 100$$% simultaneous confidence interval for all comparisons are

$$ \hat{C} \pm Q \frac{s_{\epsilon}}{\sqrt{n}} \sum^k_1 \frac{\vert c_i \vert}{2}$$

## Hayter Method

This method is similar to Fischer's LSD. Hayter's method first performs the ANOVA $$F$$ test and proceeds with pairwise comparisons if the $$F$$ test is significant. 

For balanced groups, the groups are significantly different if $$\vert \bar{y}_{i.} - \bar{y}_{i'.} \vert \ge Q_{\alpha, k - 1, dfE} s_{\epsilon} \sqrt{1 / n}$$. 

## Scheffe's Method
Scheffe's method applies to all possible contrasts (not just pairwise comparisons) and is the preferred method when many or all contrasts are of interest. A contrast is a linear function of the group means. Thus with Scheffe's test, one can measure whether a group of means is significantly different from another group of means.

Procedure:

* An arbitrary contrast $$C = \Sigma^r_{i = 1} c_i \mu_i$$ where $$\Sigma^r_{i = 1} c_i = 0$$. There can be an infinite number of contrasts
* $$C$$ is estimated with $$\hat{C} = \Sigma^r_{i = 1} c_i \bar{Y}_i$$ 
* The variance of the estimate $$\hat{C}$$ is $$s_{\hat{C}}^2 = \sigma^2_e \Sigma^r_{i = 1} \frac{c^2_i}{n_i}$$

Thus the $$(1-\alpha) 100$$% simultaneous confidence interval for all comparisons are

$$ \hat{C} \pm \sqrt{(k - 1)F_{k - 1, dfE, \alpha}} * s_{\hat{C}} $$

where $$k$$ is the number of groups.

## False Discovery Rate (FDR)
This method states that for large $$r$$, not all null hypotheses are expected to be true. Rather than focusing on the family-wise error rate, the objective is to control 

$$\alpha = FDR = E \left( \frac{H_0 true}{n.significant}  \vert n.significant > 0 \right)$$

the expected proportion of Type 1 errors (false positives) among the rejected hypotheses. FDR cuts some slack for making correct rejections; by correctly rejecting a certain number of hypothesis, it gives a pass for one incorrect rejection.

This method is the Benjamini and Hochberg method. This procedure requires the tests to be independent. It may control FDR for certain types of correlation, but may fail for highly correlated data. This procedure is more powerful than the Bonferroni-Holmes procedure.

The p-value for an individual test is

$$p_{BH(i)} = min \left( \frac{rp_{(i)}}{i}, 1 \right)$$

Let $$\alpha$$ be the FDR. Let $$k$$ be the largest $$i$$ for which $$p_{(i)} \le \frac{i}{r}\alpha$$. Then reject tests with p-values smaller or equal to $$p_{(k)}$$. This is illustrated in the plot below ($$\alpha = 0.05$$)

<img src="/nhuyhoa/figure/source/2016-02-02-Multiple-Comparisons/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

Compare these values with the q-values (FDR) generated from `p.adjust()` using the FDR method. The cutoffs for the two methods agree. 

<img src="/nhuyhoa/figure/source/2016-02-02-Multiple-Comparisons/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

Using $$r$$ ensures that $$FDR < \alpha \forall r_0$$. This is a conservative estimate of $$r_0$$ which is the extreme case where every hypothesis test is null, $$r = r_0$$. 

**Obtaining an Estimate of $$r_0$$**

If the number of true $$H_0$$ tests were known, one could adjust for that ($$r_0$$) rather than $$r$$. Doing so will give larger cut-off values. If there are many tests, $$r_0$$ can be estimated and used to replace $$r$$. 

Consider the histogram of p-values testing samples with a combination of the same means and different means. Under the null hypothesis, p-values are expected to be uniformly distributed between $$0$$ and $$1$$. Under the alternative hypothesis, p-values are skewed towards $$0$$. So combined

<img src="/nhuyhoa/figure/source/2016-02-02-Multiple-Comparisons/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Obtain an estimate of $$r_0$$ from the histogram of p-values by 

* Selecting some cut-off $$\lambda$$ from the null distribution
* Expect $$r_0(1 - \lambda)$$ of p-values $$> \lambda$$ so count the number of $$r_{\lambda}$$ p-values $$> \lambda$$
* Estimate $$\hat{r}_0 = \frac{ r_{\lambda} }{1 - \lambda}$$

Generally $$\lambda = 0.5$$ tends to work quite well. Assume that the region where p-values $$> \lambda$$ are mostly cases in which the null hypothesis is true. And the region where p-values $$< \lambda$$ contain information regarding the true alternative hypotheses. 

If the distribution of p-values is not similar to one found above, then the test statistic does not have the assumed null distribution. The computed p-values are not valid. If this occurs, another statistical analysis pipeline needs to be developed. 

**Obtaining Value for $$q$$**

The estimate of estimate of $$\hat{r}_0$$ can be used to obtain an estimate of $$q$$. If the test rejects at $$\alpha$$, the number of type 1 errors are expcted to be $$\alpha r_0$$. So estimate $$q$$ 

* Sort p-values from smallest to largest
* Let $$R(\alpha)$$ be the number of rejections when if the test reject for all $$p \le \alpha$$
* Define
$$q_{(1)} = \frac{ p_{(1)} \hat{r_0} }{R(p_{(1)})}$$
$$q_{(i + 1)} = max \left( q_{(i)}, \frac{p_{(i + 1)}\hat{r}_0}{R(p_{(i + 1)})} \right)$$

Each test has a q-value, which is defined as the minimum FDR that can be attained when calling that test significant (and all other tests which are that significant and more). In other words, it is the expected proportion of false positives (for the set of all tests) incurred when calling that test significant. 

For example, consider a study where gene X has a q-value of 0.05. This means that 5% of genes that show p-values at least as small as gene X are false positives. 

Generally one picks a cut-off q-value and reject the null hypothesis for all tests with q-values less than or equal to the cut-off. 

## Summary
In terms of ranking methods from most liberal to most conservative

$$LSD < Dunnett < Tukey < Scheffe < Bonferroni$$

The right method depends on the application. It's best to use conservative tests when the consequences are severe. A liberal test is more appropriate when it is ok if Type 1 errors occur. When there are a large number of tests, FDR and q-values are best. 

## In R
In R, use `pairwise.t.test(y, x)`, `p.adjust()`. There is also a FDR method in `qvalue::qvalue()`. Different methods can be specified as well. Contrasts are tested using the `multcomp::glht()` function.

# Multiple Corrections for Count Data

Multiple testing assumptions assume that if a null hypothesis is true, then the p-values are uniform. This assumption is violated if there are small samples or low counts. When this occurs there are only a few possible p-values. If there is no true effect, p-values begin to pile up at very high values ($$p \approx 1$$). (When there are large samples or high counts, the CLT takes effect and the results look more continuous).

Thus to satisfy assumptions, filter out data with fewer than a certain number of samples (generally can use $$10$$). Following this adjustment, use the methods detailed above. 

