---
layout: post
title: "Survival Analysis and Cox Regression"
date: "January 23, 2016"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}




Survival analysis refers to the analysis of the occurance and timing of discrete events or failures. It lets yu analyze the rates of occurance of events over time, without assuming the rates are constant. Failures can vary depending on the application. 

# Goals of Survival Analysis

Several questions

* What is the cumulative event rate from randomization until some fixed time(s)? (estimation)
* Do the events differ by treatment? (hypothesis testing)
* What is the relative difference between treatment groups? (estimation)

# Definitions

* $$T \ge 0$$ is the failure time
* $$f(t)$$ is the pdf of $$T$$
* $$F(t) = P(T \le t) = \int^t_0 f(u)du$$ is the cdf

* $$S(t) = 1 - F(t) = P(T > t)$$ is the **survival function**, the probability of being event free through time $$t$$

* $$\lambda(t) = \lim_{h \rightarrow 0} \frac{P(T \in [t, t+h) \vert T > t)}{h}= \frac{f(t)}{1 - F(t)} = \frac{f(t)}{S(t)}$$ is the **hazard function**, the conditional probability of failing in a small interval following time $$t$$ per unit of time, given the subject has not failed up to time $$t$$ (instantaneous event rate at a particular time point $$t$$)
* $$\Lambda(t) = \int^t_0 \lambda (u)du = \int^t_0 \frac{f(u)du}{1 - F(u)} = -\log[1 - F(t)] = -\log[S(t)]$$, is the **cumulative hazard function**, the expected number of failures through time $$t$$

# Censoring
One feature of survival analysis is censoring, which is when the event of interest is not observed during the period of study for some subjects. Assume that the event will occur in all subjects given sufficient follow up. Subjects without events are those for whom the event will occur in the future, although the time of event is unknown. Assume that censoring is independent of failure time.

Censoring may occur in several ways. 

* No event after study has ended
* Subjects may be lost to followup - cannot be contacted
* Subject withdraws consent and revokes participation

# One Sample Survival Curves

## Kaplan-Meier Estimate of S(t)
Consider the following data assuming no censoring 

![Survival Times](http://jnguyen92.github.io/nhuyhoa/figure/images/survival_times.png)

Since all failure times $$T_i$$ are observed, so <br>
$$\hat{F}(t) = \frac{1}{n}$$ and <br>
$$\hat{S}(t) = 1 - \hat{F}(t)$$

The time axis can be broken into intervals of size $$\Delta t$$, $$0 = t_0 < t_1 < ... < t_K$$ and let <br>
$$d_k = $$ # of subjects with $$T_i \in (t_{k - 1}, t_k)$$

and then estimate <br>
$$\hat{f}(t_k) = \frac{d_k}{n \Delta t}$$

then since $$S(t) = 1 - \int^t_0 f(u)du$$ <br>
$$\hat{S}(0) = 1$$ <br>
$$\hat{S}(t_1) = \hat{S}(0) - \hat{f}(t_1)\Delta t = 1 - \frac{d_1}{n}$$ <br>
... <br>
$$\hat{S}(t_k) = \hat{S}(t_{k - 1}) - \hat{f}(t_k)\Delta t = 1 - \frac{d_1 + ... + d_k}{n}$$

Replace $$f(t)$$ with $$\lambda(t)$$. Estimate <br>
$$\hat{\lambda}(t_k) = \frac{d_k}{n_k \Delta T}$$

since $$f(t) = S(t)\lambda(t)$$ and $$S(t) = 1 - \int^t_0 S(u)\lambda (u)du$$ so <br>
$$\hat{S}(0) = 1$$ <br>
$$\hat{S}(t_1) = \hat{S}(0) - \hat{S}(0)\hat{\lambda}(t_1)\Delta t = 1 - \frac{d_1}{n_1}$$ <br>
$$\hat{S}(t_2) = \hat{S}(t_1) - \hat{S}(t_1)\hat{\lambda}(t_2)\Delta t =\left( 1 - \frac{d_1}{n_1} \right) \left( 1 - \frac{d_2}{n_2} \right) $$ <br>
... <br>
$$\hat{S}(t_k) = \hat{S}(t_{k - 1}) - \hat{S}(t_{k - 1})\hat{\lambda}(t_k)\Delta t  = \left( 1 - \frac{d_1}{n_1} \right) \left( 1 -\frac{d_2}{n_2} \right) ... \left( 1 - \frac{d_k}{n_k} \right)$$

Letting $$\Delta t  \rightarrow 0$$ gives the **Kaplan-Meier** estimate of $$S(t)$$

$$\hat{S}(t) = \prod_{k: t_k \le t} \left( 1 - \frac{d_k}{n_k}\right)$$

where $$t_i$$ are the distinct time failures, $$n_i$$ are the numbers at risk at $$t_i$$ and $$d_i$$ are the numbers of death at times $$t_i$$. 

## Estimating Variance
Use the relation $$\log (\hat{S}(t)) = - \hat{\Lambda}(t)$$ to obtain estimates of the standard errors.

$$\hat{\Lambda}(t) = -\sum_{k:t_k \le t} \log \left( 1 - \frac{d_k}{n_k} \right)$$

Assume $$d_k \sim Bin(n_k, p_k)$$ and estimate $$p_k = \frac{d_k}{n_k}$$ and use the delta method on $$\log(1 - \frac{d_k}{n_k})$$

--------------------------|-----------------------
$$Var(\log(1 - d_k/n_k))$$| $$ = \frac{1}{(1 - d_k/n_k)^2} Var(1 - d_k/n_k)$$
                          | $$ = \frac{1}{(1 - d_k/n_k)^2n_k^2} Var(d_k)$$
                          | $$ = \frac{n_k}{(n_k - d_k)^2} \frac{d_k}{n_k} \frac{n_k - d_k}{n_k}$$
                          | $$ = \frac{d_k}{n_k(n_k - d_k)}$$

The terms $$\log(1 - d_1/n_1)$$, $$\log(1 - d_2/n_2)$$, ... are not independent but they are uncorrelated so the variance of of their sum is the sum of their variances

$$Var(\hat{\Lambda}(t)) = \sum_{k: t_k \le t} \frac{d_k}{n_k(n_k - d_k)}$$

The delta method can be applied again

$$Var( \hat{S}(t) ) = \hat{S}(t)^2 \sum_{k: t_k \le t} \frac{d_k}{n_k (n_k - d_k)}$$

This can be used to generate confidence intervals around the survival estimates. 

## In R
Using this data, fit the survival curve and obtain survival estimates and confidence intervals. Note that censored information is available. Although it is not considered an "event", it is incorporated into the "at risk" count.

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> day </th>
   <th style="text-align:center;"> status </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div><p></p>


{% highlight r %}
library(survival)

# fit a survival curve: day is the time and status is event/censored info
survival <- survfit(Surv(day, status) ~ 1, conf.type = "plain")

# survival curve results
summary(survival)
{% endhighlight %}



{% highlight text %}
## Call: survfit(formula = Surv(day, status) ~ 1, conf.type = "plain")
## 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##     9     19       1    0.947  0.0512       0.8470        1.000
##    12     17       1    0.892  0.0724       0.7497        1.000
##    13     16       1    0.836  0.0867       0.6659        1.000
##    14     15       2    0.724  0.1050       0.5186        0.930
##    16     13       1    0.669  0.1108       0.4516        0.886
##    23      8       1    0.585  0.1245       0.3411        0.829
##    24      6       1    0.488  0.1367       0.2196        0.756
##    26      5       1    0.390  0.1399       0.1159        0.664
##    28      4       1    0.293  0.1347       0.0286        0.557
##    30      2       1    0.146  0.1234       0.0000        0.388
##    31      1       1    0.000     NaN          NaN          NaN
{% endhighlight %}

Plot the survival curve. The marked positions are the censored data.

{% highlight r %}
ggsurv(survival)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-23-Survival-Analysis/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

{% highlight r %}
# survminer::ggsurvplot(survival)
{% endhighlight %}

# Two Sample Survival Curves

Survival analysis can compare survival functions in differen groups. If you followed both groups until everyone died, both survival curves would end at 0%, but one group might have survived on average a lot longer than the other group. Survival analysis does this by comparing the hazard at different times over the observation period. Survival analysis doesn't assume that the hazard is constant but does assume that the ratio of hazards between groups is constant over time. 

Additional variables may be adjusted for using Cox regression (proportional hazards regression). It has the following form 

$$\log(\lambda(t)) = \log(\lambda_0(t)) + \beta z + \beta_1 x_1 + ... + \beta_p x_p$$

where $$z$$ is the treatment group and $$\beta$$ is the log hazard ratio and is independent of $$t$$.

If you exponentiate both sides of the equation and limit the RHS to just a single categorical exposure variable with two groups, the equation becomes

$$\lambda(t) = \lambda_0(t) + \exp{\beta z}$$

Rearranging the equation lets you estimate the **hazard ratio**, comparing the exposed to the unexposed individuals at time t

$$r = \frac{\lambda_1(t)}{\lambda_0(t)} = \frac{\lambda_0(t) \exp{\beta}}{\lambda_0(t)} = \exp{\beta}$$ 

The model shows that the hazard ratio is $$\exp{\beta}$$ and remains constant over time t. The $$\beta$$ values represent the $$log(HR)$$ for each unit increase of a corresponding predictor variable. A positive $$\beta$$ indicates worse survival and a negative $$\beta$$ indicates better survival.

## Log Rank Test
Consider small intervals around each survival time. At time $$t_k$$, the $$2x2$$ table

Compute the log rank test (score test) to test the null hypothesis that $$H_0: \beta = 0$$. 

The score function at $$H_0$$ is

$$ U_k(0) = D_{k1} - E[D_{k1} \vert H_0] = D_{k1} - \frac{D_k n_{k1}}{n_k}$$

The variance is

$$I_k(0) = \frac{D_k(n_k - D_k)n_{k0}n_{k1}}{n_k^2(n_k - 1)}$$

The log rank test sums over failure times $$t_k$$

$$U(0) = \sum_k U_k(0)$$

$$I(0) = \sum_k I_k(0)$$

The test statistic is $$\frac{U(0)^2}{I(0)} \sim X^2_1$$

## Weighted Log Rank Test
Failure times may also be weighted. Let $$w_k$$ be the weight for time $$t_k$$

$$U^w(0) = \sum_k w_k U_k(0)$$

$$I^w(0) = \sum_k w_k^2 I_k(0)$$

The test statistic is then $$\frac{U^w(0)^2}{I^w(0)} \sim X^2_1$$

One option for weights is the Gehan-Wilcoxon method, where
$$w_k = (n_{k0} + n_{k1})$$

## Proportional Hazards Assumption

The proportional hazard model (Cox regression) has an assumption of proportional hazards. In other words, the hazard for any individual is a fixed proportion of the hazard for any other individual. This assumption may be evaluated in several ways

* Graph $$\log(\hat{\Lambda}(t))$$ vs. $$t$$ for each group, the assumption is satisfed if the shapes of the curves are similar and the separation between curves remain proportional across analysis time (parallel curves).
* Test for a non-zero slope in a GLM regresion of the scaled Schoenfeld residuals on functions of time. A non-zero slope violates the proportional hazard assumption

## In R


Fit a survival function with two treatment groups

{% highlight r %}
# fit model
s <- survfit(Surv(days, status) ~ treatment, data = data)

# plot survival curves
ggsurv(s, cens.col = "black", xlab = "Days", main = "Survival by Treatment Group") + theme(legend.position = "bottom")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-23-Survival-Analysis/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

{% highlight r %}
# survminer::ggsurvplot(s)
{% endhighlight %}

Fit the cox proportional hazards model and obtain the estimate for $$\beta$$ and the log rank statistic

{% highlight r %}
coxph(Surv(days, status) ~ treatment + sex + age, data = data) %>% summary
{% endhighlight %}



{% highlight text %}
## Call:
## coxph(formula = Surv(days, status) ~ treatment + sex + age, data = data)
## 
##   n= 622, number of events= 238 
## 
##                coef exp(coef)  se(coef)      z Pr(>|z|)
## treatment -0.337584  0.713492  0.133585 -2.527  0.01150
## sexm       0.082668  1.086181  0.173959  0.475  0.63463
## age        0.021732  1.021970  0.007538  2.883  0.00394
## 
##           exp(coef) exp(-coef) lower .95 upper .95
## treatment    0.7135     1.4016    0.5491     0.927
## sexm         1.0862     0.9207    0.7724     1.527
## age          1.0220     0.9785    1.0070     1.037
## 
## Concordance= 0.572  (se = 0.02 )
## Rsquare= 0.023   (max possible= 0.99 )
## Likelihood ratio test= 14.54  on 3 df,   p=0.002257
## Wald test            = 14.23  on 3 df,   p=0.002613
## Score (logrank) test = 14.31  on 3 df,   p=0.002512
{% endhighlight %}
The hazard ratio is significantly less than 1 even after adjusting for age and sex, indicating that the hazard of the treatment group is significantly less than the control group. (The hazard is the probability that if a person survives to time $$t$$, they will experience the event in the next instant).

Obtain an adjusted likelihood-ratio statistic by doing the following

{% highlight r %}
# fit model with and without treatment
hr2 <- coxph(Surv(days, status) ~ treatment + sex + age, data = data)
hr3 <- coxph(Surv(days, status) ~ sex + age, data = data)

# compute adjusted likelihood ratio statistic
anova(hr2, hr3, test = "Chisq")
{% endhighlight %}



{% highlight text %}
## Analysis of Deviance Table
##  Cox model: response is  Surv(days, status)
##  Model 1: ~ treatment + sex + age
##  Model 2: ~ sex + age
##    loglik  Chisq Df P(>|Chi|)
## 1 -1422.8                    
## 2 -1426.1 6.5277  1   0.01062
{% endhighlight %}

Assess the assumption of proportional hazards in two ways

{% highlight r %}
# plotting curve
plot(survfit(Surv(days,status) ~ treatment, data = data), lty=1:2, fun="cloglog")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-23-Survival-Analysis/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

{% highlight r %}
# test residuals
cox.zph(coxph(Surv(days,status) ~ treatment + age + sex, data = data))
{% endhighlight %}



{% highlight text %}
##               rho   chisq     p
## treatment  0.0296 0.20868 0.648
## age        0.0024 0.00132 0.971
## sexm      -0.0154 0.05721 0.811
## GLOBAL         NA 0.27726 0.964
{% endhighlight %}

Neither method indicates that the proportional hazards assumption is violated.
