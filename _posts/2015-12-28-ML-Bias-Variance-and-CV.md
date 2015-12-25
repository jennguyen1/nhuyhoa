---
layout: post
title: "Bias Variance Tradeoff and Cross Validation"
date: "December 28, 2015"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}



# Bias Variance Tradeoff

* Overfitting: unneccessary variables are included, fitting the noise
* Underfitting: important variables are not included

With all models, we want to minimize the error, which is a function of bias and variance of our model.
$$ E[y_i - \hat{f}(x_i)]^2 = Var[\hat{f}(x_i)] + Bias[\hat{f}(x_i)]^2 + Var[\epsilon] $$

* Variance: the amount by which $$\hat{f}(x_i)$$ would change if it was estimated with different testing data
* Bias: error from approximating real life problem to simple models

When models are underfitted, bias tends to be high and variance low. When models are overfitted, variance tends to be high and bias low. Thus we have what is called the bias-variance tradeoff. We want to choose a model such that the average test error is minimized, while taking into account both the bias and the variance.

# Training & Testing Error
To understand the effectiveness of cross validation, we need to make a distinction between the training error and the test error.

* Training error: error that results from prediction using the data that generated the model 
* Test error: error that results from prediction using new data, data the model has not yet seen

It is easy to memorize, but harder to generalize. Training error tends to decrease as we introduce more flexibility to the model (overfitting). Thus training data can severely underestimate the testing error. Thus testing error should always be used as the model selection metric.

Consider the following plot of prediction error against model complexity. As the model gets increasingly complex, training error decreases, even beyond the baseline error. Testing error intially decreases due to reduction of bias, but then increases due to increased variability.
<img src="/nhuyhoa/figure/source/2015-12-28-ML-Bias-Variance-and-CV/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

# Cross Validation
The cross-validation procedure can be used to select the model parameters which minimizes error. (Thus it is commonly used on the training set). The CV error is compared across different models to select the one with the smallest CV error. 

Procedure:

* Randomly divide data into $$K$$ equal-sized, nonoverlapping parts, usually $$K = 5$$ or $$10$$
* Leave part $$k$$ out and fit the model to the other $$k - 1$$ parts combined
* Using the fitted model, obtain predictions for left out $$k$$ part and compute the error
* Repeat for all $$k$$
* Combine the results from all partitions, usually with a weighted average
* Compare the cross-validated metric across different models to find the best model parameters
* Refit the model based on the best model parameters using all of the data
