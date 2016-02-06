---
layout: post
title: "Correlation"
date: "February 5, 2016"
categories: ['statistics', 'experimental design']
---

* TOC
{:toc}



# Pearson

Recal that correlation is defined as

$$\rho = \frac{cov(X, Y)}{\sqrt{Var(X)Var(Y)}}$$

Properties:

* .$$-1 \le \rho \le 1$$
* If $$\vert \rho \vert = 1$$, then there is a perfect linear relationship
* If $$\rho = 0$$ there is no linear relationship

We can estimate this value with 

$$r = \frac{1}{n - 1} \sum^n_{i = 1} \left( \frac{x_i - \bar{x}}{s_x} \right) \left( \frac{y_i - \bar{y}}{s_y} \right)$$

Assuming that $$(X_i, Y_i)$$ is a random sample from a bivariate normal distribution, we can test $$H_0: \rho = 0$$. The statistic

$$t_{corr} = \sqrt{\frac{n - 2}{1 - r^2}}r$$

is distributed $$t_{n - 2}$$. 

If we don't want to make that assumption, we can run a permutation test. By scrambling the assignment of group $$X$$ or $$Y$$, we can calculate $$r$$ for each permutation. From there we can calculate the one or two-sided p-value. 

Pearson's correlation coefficient measures the linear relationship between $$X$$ and $$Y$$. 

# Spearman
Spearman's rank correlation is useful when the relationship between our variables are not linear. 

We compute spearman's correlation by ranking the $$X$$ values, ranking the $$Y$$ values, and then finding the correlations between the ranks. 

# Large Sample Approximation

When we have large samples, under $$H_0$$ of no association

$$E(r) = 0$$
$$Var(r) = \frac{1}{n - 1}$$

The statistic 

$$Z = r \sqrt{n - 1}$$

is approximately $$N(0, 1)$$.

