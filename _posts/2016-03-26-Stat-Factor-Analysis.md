---
layout: post
title: "Factor Analysis"
date: "March 26, 2016"
categories: Statistics
tags: Multivariate_Analysis
---

* TOC
{:toc}




# Motivating Example
Consider a data set of test scores. There are $$n$$ test takers and test scores for $$6$$ subjects. There is high correlation across the subjects. 



From the correlation matrix, there is a grouping of STEM and humanities subjects in correlation. The left plot is the actual data where there is high correlation among the subjects and within fields. The right plot is a hypothetical plot of what independent data would look like (shown for comparison).


{% highlight text %}
##          Math Science   CS  Eng Hist Classics
## Math     1.00    0.67 0.64 0.34 0.29     0.28
## Science  0.67    1.00 0.65 0.29 0.29     0.26
## CS       0.64    0.65 1.00 0.35 0.30     0.29
## Eng      0.34    0.29 0.35 1.00 0.71     0.72
## Hist     0.29    0.29 0.30 0.71 1.00     0.68
## Classics 0.28    0.26 0.29 0.72 0.68     1.00
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-03-26-Stat-Factor-Analysis/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

This figure shows that there is correlation across subjects, revealing a potential underlying hidden factor (academic ability). There is also higher correlation within STEM fields and within humanities fields. This reveals a potential hidden factor that of STEM/humanities ability.

These hidden factors can be modeld with factor analysis. 

# Difference Between Factor Analysis and PCA

**Principal Components Analysis:**

* Components are calculated as linear combinations of original variables
* Goal is to explain as much of the total variance in the variables as possible
* Used to reduce the data into a smaller number of components

**Factor Analysis:**

* Original variables are defined as linear combination of the factors
* Goal is to explain the covariances/corelations between the variables
* Used to understand what constructs underlie the data

# Factor Model

Suppose there are $$p$$ variables ($$X_1$$, $$X_2$$, ..., $$X_p$$) measured on a sample of $$n$$ subjects, then the variable $$i$$ can be written as a linear combination of $$m$$ factors ($$f_1$$, $$f_2$$, ... $$f_m$$) where $$m < p$$.

$$\overrightarrow{X}_i = L_{pxm} \overrightarrow{f} + \overrightarrow{\epsilon}$$

where $$X_i$$ is a $$nx1$$ vector and $$L$$ is the matrix of factor loadings for variable $$i$$ and $$\overrightarrow{\epsilon}$$ is the portion of $$X_i$$ that cannot be explained by the factors.

For the example above $$\overrightarrow{f}$$ is a two element vector. The first element $$f_{1}$$ refers to the overall academic ability of that student and the second element $$f_{2}$$ is the difference in ability between STEM and humanities for that student. 


