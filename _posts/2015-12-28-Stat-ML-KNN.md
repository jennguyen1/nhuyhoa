---
layout: post
title: "K Nearest Neighbors"
date: "December 28, 2015"
categories: Statistics
tags: Machine_Learning
---

* TOC
{:toc}



# K Nearest Neighbors
The k nearest neighbors method assigns a point a value based on its k nearest neighbors.

* The distance metric is defined by the user (common methods include Euclidian distance, Manhattan distance, correlation metrics, etc)
* Parameter $$k$$ found via cross-validation
* Technique becomes more flexible as k decreases
* Feature variables should be standardized prior to running KNN

## KNN Classification

**Algorithm:**

* Find the k nearest neighbors (based on distance)
* Compute the class probabilities based on those neighbors

$$ P(Y = j \vert X = x_0) = \frac{1}{K} \sum_{i \in N_0} I(y_i = j) $$

* Assigns the test point to the class with the greatest probability

## KNN Regression

**Algorithm:**

* Find the k nearest neighbors (based on distance)
* Compute the predicted response

$$ \hat{f}(x_0) = \frac{1}{K} \sum_{x_i \in N_0} y_i $$

## Example

Here a KNN is run on two dimensions where the response is binary. The true boundary is given by the black line. The shaded regions are the predicted assignments.

Tthe smaller $$K$$ is, the more flexible the predicted boundary line. As $$K$$ increases, the predicted boundary is more linear. 
<img src="/nhuyhoa/figure/source/2015-12-28-Stat-ML-KNN/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

When $$K = 2$$, the test error is minimized and the predicted boundaries are quite similar to the true boundary.
<img src="/nhuyhoa/figure/source/2015-12-28-Stat-ML-KNN/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

## Strengths and Weaknesses

**Strengths:**

* Simple method
* Can work well in some situations

**Weaknesses:**

* Fails when the number of features is large (curse of dimensionality) because nearest neighbors may be very far away

# In R

* KNN classification: `class::knn()` or `caret::knn3()`
* KNN regression: `caret::knnreg()`

Consider the iris data set

{% highlight r %}
# obtain the indexes
i <- sample(1:150, 100, replace = FALSE)

# split data into train & test set
train <- iris[i, ]
test <- iris[i, ]

# run KNN - randomly chosen k
pred <- class::knn(train[, 1:4], test[, 1:4], train$Species, k = 3)

# cross-tab results
table(pred, test$Species)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-Stat-ML-KNN/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

The predictions did pretty well. Only 2 observations were misclassified. 
