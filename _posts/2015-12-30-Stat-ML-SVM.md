---
layout: post
title: "Support Vector Machines (SVM)"
date: "December 30, 2015"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}



For binary classification problems, support vector machines may be used to find a plane that separates classes in the feature space. Features should be standardized prior to applying SVM.

# Separating Hyperplane
The separating hyperplane has the form <br>
$$f(\overrightarrow{x}) =  b + \beta_1 X_1 + ... + \beta_p X_p = 0$$ 

or in vector notation <br>
$$f(\overrightarrow{x}) = \overrightarrow{\beta}^T \overrightarrow{x} + b$$

The vector $$\overrightarrow{\beta}$$ is the normal vector: it is orthogonal to the hyperplane. 

Classify a data point based on $$f(\overrightarrow{x})$$:

* group $$A$$ if $$f(\overrightarrow{x}) > 0$$
* group $$B$$ if $$f(\overrightarrow{x}) < 0$$

Use the magnitude of $$f(\overrightarrow{x})$$ to assess the confidence about the class assignment. 

* more confident the greater the magitude of $$f(\overrightarrow{x})$$ is (farther from separator)
* less confident the smaller the magnitude of $$f(\overrightarrow{x})$$ is (closer to separator)

Code the points as $$Y_i = 1$$ or $$Y_i = -1$$, so that $$Y_i * f(X_i) > 0 \forall i$$. 

# Maximal Margin Classifier
The best separating hyperplane is found via the maximal margin classifier. This methods finds the biggest gap or margin between the two classes. 

![maximal margin classifier](http://jennguyen1.github.io/nhuyhoa/figure/images/maximal_margin_classifier2.png)

Schematic diagram of maximal margin classifier. The margin is defined as $$M = \frac{2}{\| \overrightarrow{\beta} \|}$$.

This is an optimization problem: <br>
$$maximize_{\beta_0, \beta_1, ..., \beta_p} M > 0$$ <br>
w.r.t. $$\| \overrightarrow{\beta} \|= 1$$ <br>
so that $$y_i (\overrightarrow{\beta}^T \overrightarrow{x_i}+b) \ge M \forall i$$

This is equivalent to minimizing $$\| \overrightarrow{\beta} \|$$ or $$\| \overrightarrow{\beta} \|^2$$.

(This problem can be solved with linear or quadratic programming).

In the figure below, there are 3 training observations are are equidistant from the separating hyperplane. These three observations are called support vectors. The maximal margin classifier depends directly on the support vectors (and not on other observations far away from it).

![maximal margin classifier 2](http://jennguyen1.github.io/nhuyhoa/figure/images/maximal_margin_classifier.png)

A schematic diagram of maximum margin classifier (Hastie, et. al).

# Slack Variables and C Boundary
The separating hyperplane is sensitive to the support vectors, and thus may be overfitting the data. Thus to accommodate this issue, one must maximize a soft margin. 

Slack variables,  $$\epsilon_i$$, are values that indicate where the $$i^{th}$$ observation is located relative to the hyperplane and margins. 

* $$\epsilon_i = 0$$ on the correct side of margin
* $$\epsilon_i > 0$$ on the wrong side of the margin
* $$\epsilon_i > 1$$ on the wrong side of the hyperplane

![slack variables](http://jennguyen1.github.io/nhuyhoa/figure/images/svm_slack_variables.png)

The new optimization problem becomes <br>
$$maximize_{\beta_0, \beta_1, ..., \beta_p, \epsilon_1, ..., \epsilon_n} M > 0$$ <br>
w.r.t. $$\| \overrightarrow{\beta} \|= 1$$ <br>
so that $$y_i (\overrightarrow{\beta}^T \overrightarrow{x}+b) \ge M(1 - \epsilon_i) \forall i$$ <br>
where $$\epsilon_i \ge 0$$ and $$\sum^n_{i = 1} \epsilon_i \le C$$

This is equivalent to <br>
$$min \| \overrightarrow{\beta} \| + C \sum^N_i \epsilon_i$$ with the constraints <br>
$$\beta^T x_k + b \ge 1 + \epsilon_k$$ if $$y_k = 1$$ <br>
$$\beta^T x_k + b \le -1 + \epsilon_k$$ if $$y_k = -1$$ <br>
$$\epsilon_k \ge 0 \forall k$$


The variable $$C$$ is a penalty boundary chosen via cross-validation. It determines the number and severity of violations to the margin and the hyperplane. 

* Small $$C$$ allows for wider margins and is more tolerant of violations
* Large $$C$$ forces narrower margins that are rarely violated

![C penalty](http://jennguyen1.github.io/nhuyhoa/figure/images/svm_C_parameter.png)

A schematic diagram of the effects of $$C$$ penalty from small $$C$$ (upper left) to big $$C$$ (lower right) (Hastie, et. al).

# Kernals & Mapping to Higher Dimensions
In some cases, the data points are non-linearly separable. For these instances, the features may be transformed by mapping them to a higher dimensional space. With the expanded dimensional space, a linear separator may be fit to divide the data. 

Kernals are used to map to a higher dimensional space. Kernals have the form $$K(x_i, x_j) = \phi(x_i)^T \phi(x_j)$$.

* Linear: $$K(x_i, x_j) = x_i^T x_j$$
* Polynomial: $$K(x_i, x_j) = (\gamma x_i^T x_j + r)^d$$, $$\gamma > 0$$
* Radial basis function: $$K(x_i, x_j) = exp(-\gamma \| x_i - x_j \|^2)$$, $$\gamma > 0$$
* Sigmoid: $$K(x_i, x_j) = tanh(\gamma x_i^T x_j + r)$$

![polynomial kernal](http://jennguyen1.github.io/nhuyhoa/figure/images/svm_nonlinear_kernal1.png)![radial kernal](http://jennguyen1.github.io/nhuyhoa/figure/images/svm_nonlinear_kernal2.png)
Polynomial kernal (left) and radial kernal (right) (Hastie, et. al).

The hyperplane equation becomes <br>
$$f(\overrightarrow{x}) = \overrightarrow{\alpha}^T K(x, x_i) + b$$

where $$\alpha_i \ne 0$$ are the weights vectors. 

See this [link][kernal_link]{:target = "_blank"} for an example of what a kernal does.

# Strengths and Weaknesses of SVM

**Strengths:**

* When classes are nearly separable, does better than logistic regression
* Can model nonlinear boundaries

**Weaknesses:**

* Unlike logistic regression and LDA/QDA, cannot estimate class probabiltiies

# Example
To perform SVM, one can use the package `e1071`

{% highlight r %}
library(e1071)
{% endhighlight %}



First, the linear SVM example
<img src="/nhuyhoa/figure/source/2015-12-30-Stat-ML-SVM/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


{% highlight r %}
# fit linear SVM
lin.svm.fit <- svm(y ~ ., data = lin_dat, kernel = "linear", cost = 10, scale = TRUE)

# look at fit
summary(lin.svm.fit)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## svm(formula = y ~ ., data = lin_dat, kernel = "linear", cost = 10, 
##     scale = TRUE)
## 
## 
## Parameters:
##    SVM-Type:  C-classification 
##  SVM-Kernel:  linear 
##        cost:  10 
##       gamma:  0.5 
## 
## Number of Support Vectors:  7
## 
##  ( 4 3 )
## 
## 
## Number of Classes:  2 
## 
## Levels: 
##  -1 1
{% endhighlight %}



{% highlight r %}
# the support vectors
lin.svm.fit$index
{% endhighlight %}



{% highlight text %}
## [1]  3  7  8 10 12 15 18
{% endhighlight %}



{% highlight r %}
# look at plot
plot(lin.svm.fit, lin_dat)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-30-Stat-ML-SVM/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />
This plot isn't too appealing. It wouldn't be too hard to write the own. 

Consider the use of other kernals
<img src="/nhuyhoa/figure/source/2015-12-30-Stat-ML-SVM/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />


{% highlight r %}
# fit nonlinear SVM
nonlin.svm.fit <- svm(y ~ ., data = nonlin_dat, kernal = "radial", gamma = 10, cost = 1, scale = TRUE)

# look at fit
summary(nonlin.svm.fit)
{% endhighlight %}



{% highlight text %}
## 
## Call:
## svm(formula = y ~ ., data = nonlin_dat, kernal = "radial", 
##     gamma = 10, cost = 1, scale = TRUE)
## 
## 
## Parameters:
##    SVM-Type:  C-classification 
##  SVM-Kernel:  radial 
##        cost:  1 
##       gamma:  10 
## 
## Number of Support Vectors:  111
## 
##  ( 73 38 )
## 
## 
## Number of Classes:  2 
## 
## Levels: 
##  1 2
{% endhighlight %}



{% highlight r %}
# look at plot
plot(nonlin.svm.fit, nonlin_dat)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-30-Stat-ML-SVM/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

The best parameters may be found by model tuning to minimize the error

{% highlight r %}
tuned_svm.fit <- tune.svm(Species~., data = iris, gamma = 10^(-6:-1), cost = 10^(1:4))
summary(tuned_svm.fit)
{% endhighlight %}



{% highlight text %}
## 
## Parameter tuning of 'svm':
## 
## - sampling method: 10-fold cross validation 
## 
## - best parameters:
##  gamma  cost
##  1e-04 10000
## 
## - best performance: 0.03333333 
## 
## - Detailed performance results:
##    gamma  cost      error dispersion
## 1  1e-06    10 0.77333333 0.12252488
## 2  1e-05    10 0.77333333 0.12252488
## 3  1e-04    10 0.62666667 0.14807406
## 4  1e-03    10 0.12666667 0.08577893
## 5  1e-02    10 0.04666667 0.05488484
## 6  1e-01    10 0.05333333 0.05258738
## 7  1e-06   100 0.77333333 0.12252488
## 8  1e-05   100 0.62666667 0.14807406
## 9  1e-04   100 0.12666667 0.08577893
## 10 1e-03   100 0.05333333 0.05258738
## 11 1e-02   100 0.04666667 0.05488484
## 12 1e-01   100 0.06000000 0.04919099
## 13 1e-06  1000 0.62666667 0.14807406
## 14 1e-05  1000 0.12666667 0.08577893
## 15 1e-04  1000 0.05333333 0.05258738
## 16 1e-03  1000 0.04000000 0.04661373
## 17 1e-02  1000 0.04666667 0.04499657
## 18 1e-01  1000 0.07333333 0.05837300
## 19 1e-06 10000 0.12666667 0.08577893
## 20 1e-05 10000 0.05333333 0.05258738
## 21 1e-04 10000 0.03333333 0.04714045
## 22 1e-03 10000 0.04000000 0.04661373
## 23 1e-02 10000 0.05333333 0.04216370
## 24 1e-01 10000 0.06666667 0.08314794
{% endhighlight %}


[kernal_link]: https://www.youtube.com/watch?v=3liCbRZPrZA
