---
layout: post
title: "Bias Variance Tradeoff"
date: "December 27, 2015"
categories: ['statistics', 'probability and inference']
---

* TOC
{:toc}



# Bias Variance Tradeoff

* Overfitting: unneccessary variables are included, fitting the noise
* Underfitting: important variables are not included

With all models, we want to minimize the error, which is a function of bias and variance of our model.

Let $$W$$ be a point estimate of $$\theta$$

--------------------|--------------------
$$MSE_{\theta}(W)$$ | $$= E_{\theta}[(W - \theta)^2]$$
                    | $$= E[((W - E[W]) + (E[W] - \theta))^2]$$
                    | $$= E[(W - E[W])^2] + 2E[(W - E[W])(E[W] - \theta)] + E[(E[W] - \theta)^2]$$
                    | $$= Var(W) + 2E[W - \theta]E[W - E[W]] + Bias(W)^2$$
                    | $$= Var(W) + Bias(W)^2$$

$$E[(\hat{f}(x_i) - y_i)^2] = Var[\hat{f}(x_i)] + Bias[\hat{f}(x_i)]^2 + Var[\epsilon] $$

* Variance: the amount by which $$\hat{f}(x_i)$$ would change if it was estimated with different testing data
* Bias: error from approximating real life problem to simple models

When models are underfitted, bias tends to be high and variance low. When models are overfitted, variance tends to be high and bias low. Thus we have what is called the bias-variance tradeoff. We want to choose a model such that the average test error is minimized, while taking into account both the bias and the variance.

# Training & Testing Error
To understand the effectiveness of cross validation, we need to make a distinction between the training error and the test error.

* Training error: error that results from prediction using the data that generated the model 
* Test error: error that results from prediction using new data, data the model has not yet seen

It is easy to memorize, but harder to generalize. Training error tends to decrease as we introduce more flexibility to the model (overfitting). Thus training data can severely underestimate the testing error. Thus testing error should always be used as the model selection metric.

Consider the following plot of prediction error against model complexity. As the model gets increasingly complex, training error decreases, even beyond the baseline error. Testing error intially decreases due to reduction of bias, but then increases due to increased variability.
<img src="/nhuyhoa/figure/source/2015-12-27-Bias-Variance/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

# Cross Validation
The cross-validation procedure can be used to select the model parameters which minimizes error. (Thus it is commonly used on the training set). The CV error is compared across different models to select the one with the smallest CV error. 

**Procedure:**

* Randomly divide data into $$K$$ equal-sized, nonoverlapping parts, usually $$K = 5$$ or $$10$$
* Repeat for all $$k$$
  * Leave part $$k$$ out and fit the model to the other $$k - 1$$ parts combined
  * Using the fitted model, obtain predictions for left out $$k$$ part and compute the error
* Combine the results from all partitions, usually with a weighted average
* Compare the cross-validated metric across different models to find the best model parameters
* Refit the model based on the best model parameters using all of the data

![5-fold_CV](http://jnguyen92.github.io/nhuyhoa/figure/images/cross_validation.png)

The figure above is a schematic display of 5-fold CV. A set of $$N$$ observations is randomly split into 5 non-overlapping groups. Each of the groups acts as a validation set (red) and the remainder as a traing set. The 5-fold CV error is an average of the 5 resulting MSE estimates.

The procedure where setting $$K = n$$ is called Leave One Out Cross-Validation (LOOCV). This method is sometimes useful but it doesn't shuffle the data enough. Thus the error estimates from each fold are correlated and the average can have high variance.

# Error Metrics

## Regression
For continuous responses, the root mean square error is often used. This is defined as

$$RMSE = \sqrt{E\left((x - \bar{x})^2\right)}$$

## Classification
The following is the confusion matrix we would get for a two-class classification problem. 

<img src="/nhuyhoa/figure/source/2015-12-27-Bias-Variance/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

There are four possible outcomes:

* **True positive (I)**: (+) instance correctly classified as (+)
* **False positive (II)**: (-) instance incorrectly classified as (+)
* **False negative (III)**: (+) instance incorrectly classified as (-)
* **True negative (IV)**: (-) instance correctly classified as (-)

### ROC
For binary responses, ROC (Receiver Operating Characteristic) AUC (Area Under the Curve) can be used. 

* **True positive rate** $$= \left( P(predict.T \vert actual.T) \right)$$
* **False positive rate** $$= \left( P(predict.T \vert actual.F) \right)$$ 

The ROC curve plots the true positive rate  vs. the false positive rate across a range of thresholds. Then the AUC is calculated as a measure of accuracy. A perfect model has a $$AUC = 1$$, the trends should hug the upper left corner of the curve. A model with an $$AUC = 0.5$$ is no better than random guessing.

### Precision Recall Curves
Precision recall curves are preferred over ROC when there are highly skewed classes. 

* **Precision** $$= \frac{true.positive}{true.positive + false.positive}$$
* **Recall** $$= \frac{true.positive}{true.positive + false.negative}$$ 

For example, cancer cases may be skewed towards the negative cancer (more non-cancer cases than cancer). However, it is extremely important to detect cancer when it exists. So focusing on precision and recall is definitely preferred over true positive and false positive rates. 

The PR curve plots the precision vs. recall. An ideal algorithm will hug the upper right hand side of the curve. 

In R, we can generate a confusion matrix with `caret::confusionMatrix(test$pred, test$obs)`. 


# In R: Caret

In R, we can use the `caret` package to conduct model searches with tuning. 

**Preprocessing Functions:**

{% highlight r %}
# generates the design matrix
mode.matrix(y ~ ., data = x)
dummyVars(y ~ ., data = x)

# identify correlated predictors
x.cor <- cor(x)
high.cor <- findCorrelation(x.cor, cutoff = 0.75)
x[, -high.cor]

# find linear dependencies
findLinearCombos(x)

# center and scale the data
# make a function based off training data and apply to both train and test
pre.proc.values <- preProcess(train.dat, method = c("center", "scale"))
train.transformed <- predict(pre.proc.values, train.dat)
test.transformed <- predict(pre.proc.values, test.dat)
{% endhighlight %}

**Data Partitions:**

{% highlight r %}
# create training and test set
createDataPartition()

# create folds for k-fold cross validation
createFolds()

# create multiple folds for k-fold cross validation
createMultiFolds()

# create bootstrap samples
createResample()
{% endhighlight %}

**Model Training and Tuning:**

{% highlight r %}
# training controls
trainControl(
  method, # resampling method: boot, cv, loocv, repeatedcv, oob, none
  number, # number of folds for cv methods
  repeats, # number of repeats for repeated cv
  classProbs, # classification: predicted class probabilities & labels 
  summaryFunction, # function to compute performance metrics across resamples
  selectionFunction, # function to select best tuning parameter
  allowParallel # option to run tuning in parallel
)
{% endhighlight %}


{% highlight r %}
# model training
train(x, y, formula, data, # model formula
  method,  # model/method for fitting 
  preProcess, # arguments for preprocessing
  ..., # additional args for fitting method
  metric, # metric to use for optimizing 
  maximize, #   how to optimize, depends on metric
  trControl, # trainControl() above
  tuneGrid # data.frame of tuning parameters and values to try
)
{% endhighlight %}

For more information about these options, see the available help pages provided by the package. 

A few notes on parameters of `train` and `trainControl`

* To tune models, pass in a data frame with the tuning parameters (as columns) and its potential values. To fit one model, pass in a data frame with one row of tuning parameters and set the `trainControl` option `method` to "none".
* Several options for `summaryFunction` in `trainControl` are available in the help page. Can also pass in user-defined functions as long as it contains the same parameters and return types.
* Several options for `selectionFunction` in `trainControl` are availabe in the help page. Can also pass in user-defined functions as long as it contains the same parameters and return types.

**Visualize Training Performance:**

{% highlight r %}
# summary of results
train.obj$results
getTrainPerf(train.obj)

# plot results (see plot.train for help)
ggplot(train.obj, metric, plotType)
{% endhighlight %}

**Compare Training Performance Across Several Models:**

{% highlight r %}
# combine the files into one
models <- resamples(list(GBM = gbm.fit, SVM = svm.fit, RF = rf.fit))

# obtain summary statistics
summary(models)

# box plot and dotplot comparisons (see xyplot.resamples for help)
bwplot(models, layout = c(3,1))
dotplot(models)

# differences between models
diff.mods <- diff(models)
summary(diff.mods)
bwplot(diff.mods)
{% endhighlight %}


**Predictions:**

{% highlight r %}
# predict for continuous responses
predict(train.obj, newdata)

# predict for categorical responses
predict(train.obj, newdata, type = c("class", "prob"))
{% endhighlight %}

