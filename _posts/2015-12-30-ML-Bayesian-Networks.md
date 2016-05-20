---
layout: post
title: "Bayesian Networks"
date: "December 30, 2015"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}



Bayesian networks are a type of probabilistic graphical model that represents a set of random variables and their conditional dependencies using a directed acyclic graph (DAG). (See below)

![sample bayesian network](http://jnguyen92.github.io/nhuyhoa/figure/images/bayes_net.png)

Each node is associated with a probability function that takes a particular set of values from the node's parent variables as inputs and gives the probability of the node's random variable as outputs.

Given the conditional probabilities, one could compute probabilities for any combination of variables.
 
# Conditional Independence
Independence is nice property because variables can be analyzed without regard to the variables it is independent of.

* Two nodes in a bayesian network are unconditionally independent if there is no undirected path between the nodes. 
* If there is an undirected path between two nodes, then whether they are indpendent depends on what other evidence is known. 
  * A node is conditionally independent of its non-descendants, given its parents. 
  * A node is conditionally independent of all other nodes, given its Markov blanket. A Markov blanket is a node's parents, children, and children's parent. $$P(X \vert MB(X), Y) = P(X \vert MB(X))$$

![Markov blanket](http://jnguyen92.github.io/nhuyhoa/figure/images/markov_blanket.png)

The markov blanket of $$X$$. 

# Parameter Learning
This task is pretty straightforward. One can compute the joint probability tables from the training data (count things). From these, one could easily generate the conditional probability tables. 

# Structure Learning
This task is a bit harder. If an expert provides the structure, this step can be ignored. Otherwise, one can cast the structure-learning task as a search problem. 

There are 3 main structure search operators:

* add an edge
* delete an edge
* reverse an edge

To compare network structures, use a scoring function. One example is <br>

-------------|----------
$$score(G:D)$$ | $$ = \log\left( P(G \vert D) \right)$$
               | $$ = \log \left( P(D \vert G) \right) + \log \left( P(G) \right) + C$$

which is derived from <br>
$$\log\left( P(G \vert D) \right) = \int P(D \vert G, \Theta) P(\Theta \vert G) d\Theta$$

The scoring functions can be summed up to get <br>
$$score(G:D) = \sum_i Score(X_i, Parents(X_i):D)$$

## Sparse Candidate Algorithm
This algorithm uses Restrict and Maximize steps in an interation until convergence. The steps here only cover parts of the algorithm.

One can intially identify candidate parents in by computing the mutual information between pairs of variables. The variable with the greatest information would be the better candidate parent. <br>
$$I(X, Y) = \sum_{x, y} \hat{P}(x, y) \log \frac{\hat(P)(x, y)}{\hat{P}(x)\hat{P}(y)}$$

The Kullback-Leibler (KL) divergence can also be used. It provides a distance measure between two distributions P and Q. <br>
$$D_{KL}(P(X) \vert Q(X)) = \sum_x P(x) \log \frac{P(x)}{Q(x)}$$

KL can be used to assess the discrepancy between the network's estimate $$P_{net}(X, Y) $$ and the empirical estimate, with $$D_{KL}(\hat{P}(X, Y) \vert P_{net}(X, Y))$$.

## Testing Structures
Following the construction of a Bayesian network, do the following

* bootstrapping and permutation testing to assess confidence and significance of features
* interventions and time series experiments to assess causality




