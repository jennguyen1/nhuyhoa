---
layout: post
title: "Classification: Discriminant Analysis & Naive Bayes"
date: "December 29, 2015"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}




# Classification Techniques
There are a number of classification techniques. We had covered logistic and multinomial regression in a previous post. Here we will discuss naive bayes and linear/quadratic discriminant analysis.

# Probability Review

* Conditional Probability: $$P(A \vert B) = \frac{P(AB)}{P(B)}$$

* Independence: $$P(AB) = P(A)P(B)$$ or $$P(A) = P(A \vert B)$$

* Chain Rule: $$P(ABCD) = P(A \vert B, C, D) P(B \vert C, D) P(C \vert D) P(D) $$

* Bayes Rule: $$ P(A \vert B) = \frac{P(B \vert A) P(A)}{ P(B)} $$

* Conditional Addition: $$P(B) = P(B \vert C) P(C) + P(B \vert C^c) P(C^c) $$

# Discriminant Analysis
Discriminant analysis seeks to model the distribution of X in each of the classes separately. Bayes theorem is used to flip the conditional probabilities to obtain $$P(Y \vert X)$$. The approach can use a variety of distributions for each class. The techniques discussed will focus on normal distributions.

## Linear Discriminant Analysis

**For p = 1:**
Recall the pdf for the Gaussian distribution:

$$f_k(x) = \frac{1}{\sigma_k \sqrt{2\pi}} e^{-\frac{1}{2}(\frac{x - \mu_k}{\sigma_k})^2}$$

Then we get
$$P(Y = k \vert X = x) = \frac{\pi_k \frac{1}{\sigma_k \sqrt{2\pi}} exp \left( -\frac{1}{2} (\frac{x - \mu_k}{\sigma})^2 \right)}{\Sigma^K_{l = 1}\pi_l\frac{1}{\sigma \sqrt{2\pi}}exp\left(-\frac{1}{2} (\frac{x - \mu_l}{\sigma})^2\right)}$$

Similar to Naive Bayes, we can simplify by taking logs and simplifying.
$$log \left( P(Y = k \vert X = x) \right) = \frac{log \left( \frac{1}{ \sigma \sqrt{2\pi}}\right) + log(\pi_k) - \frac{x^2 - 2x\mu_k + \mu^2_k}{2\sigma^2}}{log \left( \Sigma^K_{l = 1}\pi_l\frac{1}{\sigma \sqrt{2\pi}}exp\left(-\frac{1}{2} (\frac{x - \mu_l}{\sigma})^2\right) \right)} $$

Since we are concerned with maximizing, we can remove all constants (terms that do not depend on $$k$$) to obtain the discriminant score.

$$\delta_k(x) = log \left( P(Y = k \vert X = x) \right) = x\frac{\mu_k}{\sigma^2} - \frac{\mu^2_k}{2\sigma^2} + log(\pi_k) $$

We assign $$x$$ to the class with the largest discriminant score.

**For p > 1:**
The pdf for the multivariate Gaussian distribution:

$$f(x) = \frac{1}{(2\pi)^{p/2} \vert \Sigma \vert^{1/2}} e^{-\frac{1}{2} (x - \mu)^T \Sigma ^{-1} (x - \mu)} $$

The discriminant function is

$$\delta_k(x) = x^T \Sigma^{-1} \mu_k - \frac{1}{2} \mu_k^T \Sigma^{-1} \mu_k + log(\pi_k)$$ 

Note that here we assume that the covariance matrix $$\Sigma$$ is the same for each class.

## Estimating Parameters
We can estimate the model parameters using the training data.

.$$ \hat{\pi}_k = \frac{n_k}{n} $$

.$$ \hat{\mu}_k = \frac{1}{n_k}\Sigma_{i: y_i = k} x_i$$

$$ \hat{\sigma}^2 = \frac{1}{n - K} \Sigma^K_{k = 1} \Sigma_{i: y_i = k} (x_i - \hat{\mu}_k)^2  = \Sigma^K_{k = 1} \frac{n_k - 1}{n - K} \hat{\sigma}^2_k$$ 
where $$\sigma^2_k$$ is the usual formula for estimated variance for the $$k^{th}$$ class. 

## Response Probabilities
We can compute the class probabilities with our discriminant function

$$ P(Y = k \vert X = x) = \frac{e^{\hat{\delta}_k}}{\Sigma^K_{l = 1} e^{\hat{\delta}_l}}$$

## Quadratic Discriminant Analysis
In quadratic discriminant analysis, we don't make the assumption that the covariance marix $$\Sigma_k$$ is the same for each class. 

This changes our discriminant function to 

$$\delta_k(x) = -\frac{1}{2}(x - \mu_k)^T \Sigma^{-1}_k(x - \mu_k) + log(\pi_k)$$ 

## Strengths and Weaknesses

Strengths:

* When $$n$$ is small and the distribution of predictors are normal, LDA is more stable than logistic regression
* Good for when classes are well-separated
* Popular for multinomial responses, provides a low-dimensional view of the data


# Naive Bayes
Naive Bayes is a classification technique that uses Bayesian statistics. We make the assumption that all features ($$X_i$$) are conditionally independent of each other given its class ($$Y$$). That is, $$P(X_i \vert X_j, Y) = P(X_i \vert Y)$$ where $$i \ne j$$. The goal is to find the value of $$Y$$ that is most likely given evidence $$X_i$$.
$$ argmax_y P(Y = y \vert X_i) $$
$$ argmax_y \frac{P(Y = y) \Pi_{i = 1}^p P(X_i \vert Y = y)}{P(X_i)} $$

Since the denominator is constant across all values of $$y$$, we can just focus on the numerator. Thus our goal is to find (our discriminant function)

$$ argmax_y P(Y = y) \Pi_{i = 1}^p P(X_i = x_i \vert Y = y)$$

Since we are dealing with probabilities, we may be multiplying very small values. So to prevent underflow, we can use logs.

$$ argmax_y log( P(Y = y) ) \Sigma_{i = 1}^p log(P(X_i = x_i \vert Y = y))$$

## Laplace Estimates
In some cases when we estimate the probabilities from the data, our estimates are vulnerable to unseen events. This is a problem especially when the the data set is small. For example, if we flip a coin 3 times and we get all heads, does this mean it is a one-sided coin? Probably not. 

So the solution to this is to do Laplace estimates, where we add 1 to all counts. This smoothing step's effect is great when data sets are small and is irrelevant when data sets are large (doesn't affect your calculations in any way).

This effect changes the probability calculations to 
$$P(a) = \frac{n_a + 1}{\Sigma_i (n_i + 1)}$$

## Example
Say we are given training data that looks like this.

|fruit  | long| sweet| yellow| total|
|:------|----:|-----:|------:|-----:|
|apple  |    0|   215|     50|   265|
|banana |  400|   215|    400|  1015|
|other  |  100|    70|     50|   220|
|total  |  500|   500|    500|  1500|

From this data, we have all the information we need to compute the conditional and marginal probabilities. 

However, we see that there are $$0$$s in the data. This is concerning because multiplying anything by zero automatically cancels it out. We can use Laplace estimates to adjust the counts (add 1 to all counts). Thus we account for very rare occurances that may not occur in this training data set. 


|fruit  | long| sweet| yellow| total|
|:------|----:|-----:|------:|-----:|
|apple  |    1|   216|     51|   268|
|banana |  401|   216|    401|  1018|
|other  |  101|    71|     51|   223|
|total  |  503|   503|    503|  1509|

Now say we are given information of a fruit that is long, sweet and yellow. Given this information we can predict what class this fruit belongs to.

$$P(apple \vert long, sweet, yellow)$$
$$ = P(long \vert apple)P(sweet \vert apple)P(yellow \vert apple)P(apple) $$
$$ = 0.0037 * 0.81 * 0.19 * 0.18$$
$$ = 0.0001$$


$$P(banana \vert long, sweet, yellow)$$
$$ = P(long \vert banana)P(sweet \vert banana)P(yellow \vert banana)P(banana)$$
$$ = 0.39 * 0.21 * 0.39 * 0.67$$
$$ = 0.021$$


$$P(other \vert long, sweet, yellow)$$
$$ = P(long \vert other)P(sweet \vert other)P(yellow \vert other)P(other)$$
$$ = 0.45 * 0.32 * 0.23 * 0.15$$
$$ = 0.005$$

Based off the evidence, we assume that this sweet, long, and yellow fruit is a banana. 

## Gaussian Naive Bayes
Gaussian naive Bayes assumes that each $$\Sigma_k$$ is diagonal. Thus

$$\delta_k(x) \propto log \left( \pi_k \Pi^p_{j = 1} f_{kj}(x_j) \right) = -\frac{1}{2} \Sigma^p_{j = 1} \frac{(x_j - \mu_{kj})^2}{\sigma^2_{kj}} + log(\pi_k) $$


## Strengths and Weaknesses

Strengths:

* Simple to understand and build
* Useful when $$p$$ is large
* Can work really well despite naive assumptions

Weakenesses:

* Assumes (naively) that the features are independent


