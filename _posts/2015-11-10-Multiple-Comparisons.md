---
layout: post
title: "Multiple Comparisons"
date: "November 10, 2015"
categories: statistics
---

* TOC
{:toc}



# Why It's Needed
When we want to conduct multiple pairwise tests, we need account for the number of tests. Assume that each pairwise test has a type I error rate of $$\alpha = 0.05$$. 

If we conduct $$p$$ number of tests, the probability that we don't make an error on any of those tests is $$(1 - \alpha)^p$$. 

|num_tests |prob_no_error |
|:---------|:-------------|
|1         |(1 - a)^1     |
|2         |(1 - a)^2     |
|...       |...           |
|p         |(1 - a)^p     |

From this we can easily compute the probability of making an error if we conducted $$p$$ tests. 

|num_tests |prob_error    |
|:---------|:-------------|
|1         |1 - (1 - a)^1 |
|2         |1 - (1 - a)^2 |
|...       |...           |
|p         |1 - (1 - a)^p |

<img src="/nhuyhoa/figure/source/2015-11-10-Multiple-Comparisons/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

Our error rates rapidly increases. The type 1 error rate is approximately $$50$$% when we conduct $$13$$ tests. Thus we have to find a way to correct for these multiple tests to ensure that our Type 1 error rate remains low.

# How to Do It
