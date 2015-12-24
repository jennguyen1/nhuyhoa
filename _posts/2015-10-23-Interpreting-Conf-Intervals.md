---
layout: post
title: "Interpreting Confidence Intervals"
date: "October 23, 2015"
categories: ['statistics', 'other']
---

* TOC
{:toc}



Confidence intervals are used to convey the amount of uncertainty associated with a sample estimate of a population parameter. Data is collected and the results are used to generate a point estimate and a confidence interval. How does one interpret the confidence interval?

Say we generated a $$(1 - \alpha) 100$$% confidence interval. This interval means that if we were to replicate the data collection and analysis process many times, $$(1 - \alpha) 100$$% of the generated intervals would contain the true value of the population parameter. 



Say the true value of $$\mu = 0$$. Here we see, per the definition above, that $$95/100$$ intervals contain the true value of $$\mu$$. 

<img src="/nhuyhoa/figure/source/2015-10-23-Interpreting-Conf-Intervals/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

It is important to note that the true value of the population parameter is fixed, so any single confidence interval will either contain the population parameter or not. Thus we cannot interpret the confidence interval as the probability that the true value is in the interval. 

So say we want to test a null hypothesis that $$\mu = 0$$ with a 95% confidence interval. If $$\mu$$ falls within that confidence interval, we say that if we were to repeat the process many times, $$95$$% of the time $$\mu$$ will fall inside the confidence intervals. Thus we can conclude that our data does not indicate a significant difference from $$\mu = 0$$. 
