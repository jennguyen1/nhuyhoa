---
layout: post
title: "Causal Inference"
date: "January 04, 2016"
categories: ['statistics', 'probability theory']
---

* TOC
{:toc}

# Rubin Causal Model
The Rubin Causal Model is a conceptual model that defines causal effects in terms of unobservable  questions. 

Imagine that, giveen two possible treatments $$A$$, $$B$$, each subject $$u$$, has two potential outcomes

* $$Y_A(u)$$ - response if subject were to receive $$A$$
* $$Y_B(u)$$ - response if subject were to receive $$B$$

Then the Causal Effect of $$B$$ relative to $$A$$ for subject $$u$$ is 

$$D(u) = Y_B(u) - Y_A(u)$$

Let a larger $$Y$$ be "better", then 

* $$D(u) > 0$$ give subject $$u$$ treatment $$B$$
* $$D(u) < 0$$ give subject $$u$$ treatment $$A$$
* $$D(u) = 0$$ give subject $$u$$ either treatment $$A$$ or $$B$$

Unfortunately, it is is impossible to observe both $$Y_A(u)$$ and $$Y_B(u)$$ in the same subject (unless we had clones. That is we can never know the effect of the treatment in a single subject.

Instead we can examine the Population Average Causal Effect of $$B$$ relative to $$A$$. 

$$D = E[D(u)] = E[Y_B(u) - Y_A(u)] = E[Y_B(u)] - E[Y_A(u)]$$

We can estimate $$E[Y_B(u)]$$, $$E[Y_A(u)]$$ using different sets of subjects. 

We can then test the null hypothesis 

$$H_0: D = 0$$

# Randomization
Random assignments of subjects to treatment groups is important for causal experiments. Randomization ensures that

* .$$E[Y(u) \vert T(u) = A] = E[Y_A(u)]
* .$$E[Y(u) \vert T(u) = B] = E[Y_B(u)]

so that 

$$E[Y(u) \vert T(u) = B] - E[Y(u) \vert T(u) = A] = E[Y_B(u)] - E[Y_A(u)] = D$$

and we can conduct valid causal inference. 

Essentially we randomize so that the responses we see are independent of the treatment type. 

## Confounding
If we do not randomize experiments, we may have confounding. Confounding occurs when additional (observed or unobserved) factors ($$Z$$) that are associated with both $$X$$ and $$Y$$ and induce misalignment between the observed association and the true causal relationship. 

![Confounding](http://jnguyen92.github.io/nhuyhoa/figure/images/confounding.png)

Specifically, if $$X$$ has a causal effect on $$Y$$, but $$Z$$  has causal effects on both $$X$$ and $$Y$$, then the observed assiciation between $$X$$ and $$Y$$ wil reflect the net effect of $$X$$ and the effect of $$Z$$ on $$X$$ and $$Y$$. In some cases $$X$$ may not have a causal effect on $$Y$$, but the confounding variable may make it seem like there is. 

To deal with confounding variables, we can either randomize or adjust for the variable. Generally, it is best to randomize and adjust for key variables (age, sex, etc). We cannot adjust for everything (expensive), which is why randomization is so important.

