---
layout: post
title: "Hypothesis Testing and Confidence Intervals"
date: "January 7, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# Hypothesis Testing
In hypothesis testing we attempt to test a whether a population parameter is significantly different than some predefined hypothesis value. 

The steps for conducting a hypothesis test is

1. Set up 2 competing hypotheses: $$H_0$$ and $$H_1$$
2. Set some significance level $$\alpha$$
3. Calculate test statistic
4. Calculate p-value 
5. Make a test decision & state overall conclusion

We have Type 1 and Type 2 errors with hypothesis testing. 

<table class = "presenttab">
 <thead>
  <tr>
   <th style="text-align:left;">  </th>
   <th style="text-align:left;"> Reality </th>
   <th style="text-align:left;">  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Decision </td>
   <td style="text-align:left;"> H0 is true </td>
   <td style="text-align:left;"> H0 is false </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Reject H0 </td>
   <td style="text-align:left;"> Type 1 error </td>
   <td style="text-align:left;"> Correct </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Accept H0 </td>
   <td style="text-align:left;"> Correct </td>
   <td style="text-align:left;"> Type 2 error </td>
  </tr>
</tbody>
</table>
<p></p>

If we reject $$H_0$$ when $$H_0$$ is true, we commit a Type I error. The probability of a Type 1 error is denoted $$\alpha$$.

If we accept $$H_0$$ when $$H_0$$ is false, we commit a Type II error. The probability of a Type II error is denoted $$\beta$$. 

## Derivation
Derivation of a test statistic is based off distributions of known values. Often we employ several theorems, such as the central limit theorem, which helps us to generate these statistics.

See individual tests for more information.

## Interpretation
Hypothesis tests generate a p-value. The p-value calculate may depend on the alternative hypothesis

* For right tailed tests, we compute $$P(X > X*)$$
* For left tailed tests, we compute $$P(X < X*)$$ 
* For two-sided tests, we compute $$2*P(X > \vert X* \vert)$$

The p-value is defined as the probability of obtaining a result greater than or more extreme than the one observed, given that the null hypothesis is not true. 

$$ p.value = P(X > x | H_0) $$

One can deduce (carefully) that since the result is unlikely to occur under the null hypothesis, the data had to have been generated from another probability distribution. 

There are a lot of potentially dangerous ways to interpret p-values. Assumptions should be assessed prior to drawing a final conclusion,  and multiple corrections should be adjusted for. P-values should be assessed, not just taken at face value.

# Confidence Intervals

## Derivation
Confidence intervals are used to convey the amount of uncertainty associated with a sample estimate of a population parameter. In other words, we want to obtain the shaded region in the diagram below. (For this example, we want to find the two-sided confidence interval. We can adjust these for one sided tests easily by removing one of the sides.)

<img src="/nhuyhoa/figure/source/2016-01-07-Hypothesis-Testing-Confidence-Intervals/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

To generate a $$(1-\alpha)100$$% confidence interval, we start with the test statistic. The test statistic may vary depending on its distribution, but the process is the same.

**Example 1:**

For this example, I will use the t-statistic, which we know is distributed $$t$$. We wish to obtain an interval around $$\bar{X}$$ which satisifies

$$P(-t_{\alpha/2} < \frac{\bar{X} - \mu}{SE} < t_{\alpha/2}) = 1 - \alpha$$

Let $$SE$$ be the standard error. So we have

$$-t_{\alpha/2} < \frac{\bar{X} - \mu}{SE} < t_{\alpha/2}$$

$$-t_{\alpha/2} * SE < \bar{X} < t_{\alpha/2} * SE$$

$$\mu - t_{\alpha/2} * SE < \bar{X} < \mu + t_{\alpha/2} * SE$$

So finally we have

$$\bar{X} \pm t_{\alpha/2} * SE$$

**Example 2:**

For this example, consider the confidence interval for the ratio of two variances $$\frac{\sigma^2_y}{\sigma^2_x}$$. We know that $$\frac{(n-1)s^2}{\sigma^2}$$ is distributed $$X^2_{n - 1}$$ and $$\frac{X^2_p / p}{X^2_q / q}$$ is distributed $$F_{p, q}$$. So we wish to compute

$$P(F_{p, q, 1 - \alpha/2} < \frac{\frac{(n - 1) s^2_x}{\sigma_x^2} / (n - 1)}{\frac{(m - 1) s^2_y}{\sigma_y^2} / (m - 1)} < F_{p, q, \alpha/2}) = 1 - \alpha$$

So we have

$$F_{p, q, 1 - \alpha/2} <\frac{\frac{(n - 1) s^2_x}{\sigma_x^2} / (n - 1)}{\frac{(m - 1) s^2_y}{\sigma_y^2} / (m - 1)} <F_{p, q, \alpha/2}$$

$$F_{p, q, 1 - \alpha/2} <\frac{\frac{s^2_x}{\sigma_x^2}}{\frac{s^2_y}{\sigma_y^2}} <F_{p, q, \alpha/2}$$

$$F_{p, q, 1 - \alpha/2} \frac{s^2_y}{s^2_x} < \frac{\sigma^2_y}{\sigma^2_x} < F_{p, q, \alpha/2}\frac{s^2_y}{s^2_x}$$


## Interpretation
Confidence intervals are used to convey the amount of uncertainty associated with a sample estimate of a population parameter. Data is collected and the results are used to generate a point estimate and a confidence interval. How does one interpret the confidence interval?

Say we generated a $$(1 - \alpha) 100$$% confidence interval. This interval means that if we were to replicate the data collection and analysis process many times, $$(1 - \alpha) 100$$% of the generated intervals would contain the true value of the population parameter. 



Say the true value of $$\mu = 0$$. Here we see, per the definition above, that $$95/100$$ intervals contain the true value of $$\mu$$. 

<img src="/nhuyhoa/figure/source/2016-01-07-Hypothesis-Testing-Confidence-Intervals/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

It is important to note that the true value of the population parameter is fixed, so any single confidence interval will either contain the population parameter or not. Thus we cannot interpret the confidence interval as the probability that the true value is in the interval. 

So say we want to test a null hypothesis that $$\mu = 0$$ with a 95% confidence interval. If $$\mu$$ falls within that confidence interval, we say that if we were to repeat the process many times, $$95$$% of the time $$\mu$$ will fall inside the confidence intervals. Thus we can conclude that our data does not indicate a significant difference from $$\mu = 0$$. 
