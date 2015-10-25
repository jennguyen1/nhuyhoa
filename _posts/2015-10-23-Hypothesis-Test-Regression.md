---
layout: post
title: "Hypothesis Testing in Regression"
date: "October 23, 2015"
categories: statistics
---

* TOC
{:toc}



# F Test
Suppose we want to compare 2 models, where one is nested in the other. Let H correspond to the simplified model with p - q parameters. Let A correspond to the full model with p parameters. Then we can compare the two models with an F test.

$$ F = \frac{(SSE_H - SSE_A)/ (DFA_A - DF_H)}{SSE_A/DF_A} $$

where $$ F $$ ~ $$ F_{q, n - p} $$ and SSE is the sum square errors and DF is the residual degrees of freedom corresponding to the specified model.

# Example

{% highlight r %}
set.seed(1)
y <- rnorm(50)
x <- runif(50)
z <- rexp(50, 1.5)

# by hand
modh <- lm(y ~ x)
moda <- lm(y ~ x + z)
RSSh <- anova(modh)["Sum Sq"][2,1]
RSSa <- anova(moda)["Sum Sq"][3,1]

F <- (RSSh - RSSa) / (1) / (RSSa/47)
pf(F, 1, 47, lower.tail = FALSE)
{% endhighlight %}



{% highlight text %}
## [1] 0.5634758
{% endhighlight %}



{% highlight r %}
# using built in R
anova(modh, moda)
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Model 1: y ~ x
## Model 2: y ~ x + z
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1     48 31.286                           
## 2     47 31.062  1   0.22372 0.3385 0.5635
{% endhighlight %}

Thus we conclude that for this data set, the full and simplified model are not significantly different frome each other. Thus the "best" model is the simplified model.
