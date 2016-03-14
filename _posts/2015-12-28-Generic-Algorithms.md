---
layout: post
title: "Generic Machine Learning Algorithms"
date: "December 28, 2015"
categories: ['statistics', 'probability and inference']
---

* TOC
{:toc}




These topics cover generic algorithms that can be applied to a variety of different machine learning algorithms. 

# Gradient Descent
Assume that we start with some intial $$\theta$$. The algorithm repeatedly takes a step in the direction of the steepest decrease of $$J$$ until it reaches a local minimum. 


There are two variants of the gradient descent algorithm

The batch gradient descent algorithm updates the parameters after examining every training observation.

**Repeat until convergence {**
  $$\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j}J(\theta)$$
**}**

Batch gradient descent can easily be parallelized for efficient computation. The summation related to the differentiation term could be split up across different sections and can be combined after computation.

The stochastic gradient descent algorithm updates the parameters after examining a single training observation. The outer loop can be repeated generally $$1-10x$$.

**Repeat{ for i = 1 to n: {**
      $$\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j}J(\theta)$$
**} }**

A compromise between the two is mini-batch gradient descent. For this method rather than adjusting $$\theta_j$$ after looking at $$1$$ training observation, we look at $$m$$ training observations where $$m < n$$. The for loop iterations from $$1$$ to $$n$$ in steps of $$m$$. 

The value $$\alpha$$ is the learning rate. Some care should be taken in choosing the value of $$\alpha$$. If $$\alpha$$ was too small, convergence may be slower. If $$\alpha$$ was too big, the algorithm may overshoot the minimum and fail to converge. 

The function $$J(\theta)$$ is the cost function. This can vary depending on the algorithm used. For example, for linear regression the cost function would be the SSE. 

# Newton-Raphson Method
In this method, the goal is to find the value of $$\theta$$ so that $$l(\theta) = 0$$. The algorithm is 

**Repeat{**
  $$\theta := \theta - H^{-1} \nabla_{\theta} l(\theta)$$
**}**

where $$ \nabla_{\theta} l(\theta)$$ is the vector of partial derivatives of $$l(\theta)$$ with respect to the $$\theta_i$$s and $$H$$ is the $$nxn$$ Hessian matrix where $$H_{ij} = \frac{\partial^2 l(\theta)}{\partial \theta_i \partial \theta_j}$$. 

This is the method used in fitting [GLMs][glm_basics_post]{:target = "_blank"} where $$l(\theta)$$ is the log likelihood function.

# Expectation Maximization
The expectation maximization algorithm is used to find the most likely values for hidden variables. The algorithm initially takes a random guess at the model. Then it iterates over two steps until convergence:

* Expectation step: given a model, predict the most likely parameter values
* Maximization step: given parameters, learn a new model

# Mutual Information

The Kullback-Leibler (KL) divergence provides a distance measure between two distributions $$P$$ and $$Q$$. 

$$D_{KL}(P(X) \vert Q(X)) = \sum_x P(x) \log \frac{P(x)}{Q(x)} = \sum_i p_i [\log(p_i) - \log(q_i)]$$

If the two distributions are indpendent, then $$P$$ is non-informative about $$Q$$. The KL divergence will be small. 

We can use KL divergence to understand comparing models with divergence. Deviance is an estimate of relative information divergence.


-------------------------------|----------------
$$D_{KL}(p,q) - D_{KL}(p, r)$$ | $$ = -sum_i p_i (\log q_i - \log r_i)$$ 
                               | $$ \propto D(q) - D(r)$$
                               
Deviance is defined as $$-2\sum_i log(q_i)$$.

Thus deviance can be thought of as comparing two distributions using KL divergence. 

# Ensembles

Ensembling means to combine multiple models. Ensembling often obtains better predictions than single models. Ensemble techniques include random forests and boosting. 

Model ensemble procedure

* Obtain predictions/prediction distributions for each model
* Compute weights (may be based of CV, information criteria, linear model to predict on hold-out set, etc)
* Combine predictions using model weights

[glm_basics_post]: http://jnguyen92.github.io/nhuyhoa//2015/11/GLM-Basics.html#fitting-glm

