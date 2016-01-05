---
layout: post
title: "Generic Machine Learning Algorithms"
date: "December 28, 2015"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}




These topics cover generic algorithms that can be applied to a variety of different machine learning algorithms. 

# Gradient Descent
Assume that we start with some intial $$\theta$$. The algorithm repeatedly takes a step in the direction of the steepest decrease of J until it reaches a local minimum. 


There are two variants of the gradient descent algorithm

The batch gradient descent algorithm updates the parameters after examining every training observation.

**Repeat until convergence {**
  $$\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j}J(\theta)$$
**}**

The stochastic gradient descent algorithm updates the parameters after examining a single training observation.

**Repeat{ for i = 1 to n: {**
      $$\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j}J(\theta)$$
**}}**

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


[glm_basics_post]: http://jnguyen92.github.io/nhuyhoa//2015/11/GLM-Basics.html#fitting-glm

