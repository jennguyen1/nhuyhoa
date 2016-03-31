---
layout: post
title: "Bayesian Estimation"
date: "February 27, 2016"
categories: ['statistics', 'probability and inference']
---

* TOC
{:toc}


{% highlight text %}
## Error: package or namespace load failed for 'GGally'
{% endhighlight %}

# Frequentist vs Bayesian Statistics

There is a distinction between frequentist and Bayesian statistics. 

Consider tossing a coin 10 times to assess whether it is fair or not. Given an outcome, a frequentist would obtain the p-value $$P(\vert X \vert > 7 \vert fair) = 0.34$$ and conclude there is no evidence that the coin is not fair. In frequentist statistics, the population parameter is assumed to be fixed and constant. The coin is either fair or not fair. 

In Bayesian statistics, the information about the unknown parameter is summarized by a probability distribution. The parameter is not constant, rather it is a random variable. For example, coins on average are fair with high probability near $$0.5$$ and lower probability near $$0$$ or $$1$$. The probability distribution of a parameter is the prior distribution. A prior distribution is chosen prior to observing the data. Once the data is collected, the prior and the likelihood from the data are combined using Bayes' Theorem to obtain $$P(\theta \vert x)$$, otherwise known as the posterior distribution. 

# Bayesian Statistics

Recall Bayes' Theorem

$$P(X \vert Y) = \frac{P(Y \vert X)P(X)}{P(Y)}$$

We can reformat this to 

$$P(\theta \vert x) = \frac{f(x \vert \theta) f(\theta)}{f(x)} = \frac{f(x \vert \theta) f(\theta)}{\int f(x \vert \theta) f(\theta) d\theta}$$

where 

* $$f(\theta)$$ is the prior distribution
* $$f(x \vert \theta)$$ is the likelihood function
* $$f(\theta \vert x)$$ is the posterior distribution

Essentially the best estimate of $$\theta$$ for explaining the observed data $$x$$ can be found by combining information from the prior distribution and the likelihood. The more data or information we have, the less impact the prior has. We can obtain an estimate of $$\theta$$ by finding $$E[\theta \vert x]$$. A $$(1 - \alpha)100$$% confidence interval can be obtained by finding the $$\alpha/2$$ and $$1 - \alpha/2$$ percentile cutoffs from the posterior distribution. 

The pros and cons of the Bayesian approach come from choosing the prior distribution. On one hand, chosing the prior may be subjective. On the other hand, it is a natural way to incorporate true prior information perhaps from scientists or experts. One can also choose a vague prior distribution that may have a very small impact on the final inference given informative data. 

**Example**

Suppose $$X \sim Bin(n, \theta)$$ and $$\theta \sim Beta(\alpha, \beta)$$ (we would need to choose the parameters for $$\alpha$$ and $$\beta$$ but for this example, we keep it arbitrary).

$$f(x \vert \theta) = \binom{n, x} \theta^x (1 - \theta)^(n - x)$$

$$f(\theta) = \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \theta^{\alpha - 1} (1 - \theta)^{\beta - 1}$$

We have the numerator in the Bayes' formula

$$f(x, \theta) = f(x \vert \theta) f(\theta) = \binom{n}{x} \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \theta^{x + \alpha - 1} (1 - \theta)^{n - x + \beta - 1}$$

The marginal pdf of $$X$$ is

--------|--------------------------------
$$f(x)$$| $$= \binom{n}{x} \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \int^1_0 \theta^{x + \alpha - 1} (1 - \theta)^{n - x + \beta - 1} d\theta$$
        | $$= \binom{n}{x} \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \frac{\Gamma(x + \alpha) \Gamma(n - x + \beta)}{\Gamma(x + \alpha + n - x + \beta)} \int^1_0 \frac{\Gamma(x + \alpha + n - x + \beta)}{\Gamma(x + \alpha) \Gamma(n - x + \beta)} \theta^{x + \alpha - 1} (1 - \theta)^{n - x + \beta - 1} d\theta$$
        | $$= \binom{n}{x} \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \frac{\Gamma(x + \alpha) \Gamma(n - x + \beta)}{\Gamma(x + \alpha + n - x + \beta)}$$
        
<br>
We plug this in to Bayes' Theorem to get

----------------------|------------------------------
$$f(\theta \vert x)$$ | $$= \frac{\binom{n}{x} \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \theta^{x + \alpha - 1} (1 - \theta)^{n - x + \beta - 1}}{\binom{n}{x} \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha)\Gamma(\beta)} \frac{\Gamma(x + \alpha) \Gamma(n - x + \beta)}{\Gamma(x + \alpha + n - x + \beta)}}$$
                      | $$= \frac{\Gamma(n + \alpha + \beta)}{\Gamma(\alpha + x) \Gamma(n + \beta - x)} \theta^{x + \alpha - 1} (1 - \theta)^{n - x + \beta - 1}$$

<br>

So we have the posterior distribution 

$$f(\theta \vert x) \sim Beta(x + \alpha, n - x + \beta)$$

We obtain an estimate of $$\theta$$

$$E[f(\theta \vert x)] = \hat{\theta} = \frac{\alpha + x}{\alpha + n + \beta}$$

Note that 

$$E[f(\theta \vert x)] = \hat{\theta} = \left( \frac{\alpha + \beta}{\alpha + n + \beta} \right) \left( \frac{\alpha}{\alpha + \beta} \right) + \left( \frac{n}{\alpha + n + \beta} \right) \left( \frac{x}{n} \right)$$

Thus the posterior mean is a weighted average between the prior mean and the maximum likelihood estimate, where the weight depends on the sample size. As the sample size increases, the prior has less influence. 

Often times we don't have to solve the marginal pdf of $$X$$. We can just compute the numerator, extract all terms involving the parameter, and match that result to a kernal of a known distribution. 

# Probability Distributions

The following distributions are often used as prior distributions. 

* Beta : used for priors for berneoulli, binomial, negative binomial, and geometric distributions
* Dirchlet: used for priors for categorical and multinomial distributions
* For other potential prior distributions see the [Wikipedia page][conjugate_priors_link]{:target = "_blank"}. 

[conjugate_priors_link]: https://en.wikipedia.org/wiki/Conjugate_prior#Table_of_conjugate_distributions
