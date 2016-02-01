---
layout: post
title: "Multiple Comparisons"
date: "January 20, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# Type 1 and Type 2 Error Rates

* Type 1 Error: $$P($$reject $$H_0$$, given $$H_0$$ is true$$) = \alpha$$, aka false positive rate
* Type 2 Error: $$P($$do not reject $$H_0$$, given $$H_0$$ is false$$) = \alpha$$, aka false negative rate
* Power: $$1 -$$ $$Type$$ $$2$$ $$Error$$ $$Rate$$

# Why It's Needed
When we want to conduct multiple (independent) tests, we need account for the number of tests. Assume that each test has a type I error rate of $$\alpha = 0.05$$. 

If we conduct $$p$$ number of tests, the probability that we don't make an error on any of those tests is $$(1 - \alpha)^p$$. From this we can easily compute the probability of making an error if we conducted $$p$$ tests. 

Number of Tests | P(Type 1 Error) = 1 - P(rejection)
----------------|-----------------------------------
    $$1$$       |   $$1 - (1 - \alpha)^1$$
    $$2$$       |   $$1 - (1 - \alpha)^1$$
    ...         |   ...
    $$p$$       |   $$1 - (1 - \alpha)^p$$

<p></p>

<img src="/nhuyhoa/figure/source/2016-01-20-Multiple-Comparisons/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

Our error rates rapidly increases. The type 1 error rate is approximately $$50$$% when we conduct $$13$$ tests. Thus we have to find a way to correct for these multiple tests to ensure that our Type 1 error rate remains low.

# How to Do It
Note that what number and what specific comparisons should be determined in advance (prior to receiving results) to eliminate experimenter bias.

Also note that the assumptions of the overall test (ex: ANOVA) also apply to these tests. 

## Fischer's Least Significant Difference (LSD)
Fischer's LSD method ignores the problem and does not correct for multiple tests. It states to use the predetermined $$\alpha$$ value for all tests, even though it may result in high type 1 error rates.

In increasing the type 1 error rate, we decrease the type 2 error rate. Therefore, Fischer's LSD method results in maximizing power. 

## Bonferroni Correction

Say you want to do a select $$n$$ tests (don't have to compare all groups). Let $$A^c$$ be a type I error event. Then,

.$$P(\cap^n_{i=1} A_i) = 1 - P(\cup^n_{i=1} A^c_i) \ge 1 - \Sigma^n_{i = 1} P(A^c_i) $$

so if we were to set $$P(A^c_i) = \alpha / n$$, then our overall error rate would be $$ \alpha$$. 

So Bonferroni's method for correcting for multiple tests states that if you want an overall type I error rate of $$\alpha$$, set 

$$\alpha_i = \alpha / n$$ 

where $$n$$ is the number of tests and $$\alpha_i$$ is the type I error rate for each individual test. 

Example:

* Want an overall error rate of $$ \alpha = 0.05 $$ with $$20$$ tests. 
* For each individual test we use $$ \alpha_i = 0.05 / 20 = 0.0025 $$.
* With bonferroni correction, overall type 1 error rate is just under $$0.05$$

$$P($$overall type 1 error$$) = 1 - (1 - 0.0025)^{20} = 0.0488$$

* Without bonferroni correction, overall type 1 error rate is $$0.64$$

$$P($$overall type 1 error$$) = 1 - (1 - 0.05)^{20} = 0.64$$

* In R, `pairwise.t.test(y, x, p.adjust.method = "bonferroni")` or use quantile derivation with bonferroni $$\alpha$$

Using bonferroni's correction, we are guaranteed a overall type 1 error rate of $$0.05$$. Unfortunately in doing so, the bonferroni method is very conservative, in which the type 2 error rate is very high and power is very low for each individual test.

Note that Bonferroni's correction is valid for equal and unequal sample sizes.

In R, the bonferroni method can be implemented by passing the p-values into `p.adjust()`.

## Tukey Method
Tukey's method is done post-ANOVA. It must be used to examine all pairwise comparisons, where each group must have equal sample sizes. With Tukey's method, the overall type 1 error is equal to $$\alpha$$.

Tukey's method is uses the studentized range distribution. The studentized range is defined as 
$$q_{m, df} = \frac{w}{s}$$

where the observations $$Y_i$$ ~ $$iidN(\mu, \sigma^2)$$, $$w$$ is the range of the observations, and $$s$$ is the estimated standard deviation. The distribution parameters are $$m = $$ number of groups and $$df = $$ degrees of freedom for $$s^2$$, the estimate of $$\sigma^2$$.

Procedure:

* Fit an ANOVA: `a <- aov(Petal.Length ~ Species, data = iris)`
* Compute pairwise tests: `TukeyHSD(a)`
* The studentized range distribution quantiles in R: `qtukey(p, m, df)/sqrt(2)` (if you want to do them by hand)

With unequal sample sizes, one can use the Tukey-Kramer Method (not discussed here).

## Scheffe's Method
Scheffe's method applies to all possible contrasts (not just pairwise comparisons) and is the preferred method when many or all contrasts are of interest. A contrast is a linear function of the group means. Thus with Scheffe's test, one can measure whether a group of means is significantly different from another group of means.

Procedure:

* An arbitrary contrast $$C = \Sigma^r_{i = 1} c_i \mu_i$$ where $$\Sigma^r_{i = 1} c_i = 0$$. There can be an infinite number of contrasts
* $$C$$ is estimated with $$\hat{C} = \Sigma^r_{i = 1} c_i \bar{Y}_i$$ 
* The variance of the estimate $$\hat{C}$$ is $$s_{\hat{C}}^2 = \sigma^2_e \Sigma^r_{i = 1} \frac{c^2_i}{n_i}$$

Thus the $$(1-\alpha) 100$$% simultaneous confidence interval for all comparisons are

$$ \hat{C} \pm \sqrt{(m - 1)F_{\alpha; m - 1, N - m}} * s_{\hat{C}} $$

where $$m$$ is the number of groups and $$N$$ are the total number of observations.

## Summary

{% highlight text %}
## Error in function_list[[k]](value): could not find function "nhuyhoa_df_present"
{% endhighlight %}

<p></p>

* The Scheffe method is preferred when many or all contrasts are of interest.
* The Tukey method preferred (over Scheffe) when only (all) pairwise comparisons are to be considered.
* If only a subset of pairwise comparisons are needed, one should contrast the Bonferroni and Tukey methods and choose the one that has greater power (smaller multiplier). 
* If one does not care about type 1 error rate and would like to maximize power, then go with Fischer's LSD method.

Note that here "best/preferred" refers to the method that gives the smallest confidence intervals.
