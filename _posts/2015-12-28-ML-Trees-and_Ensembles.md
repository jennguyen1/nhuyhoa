---
layout: post
title: "Trees and Ensembles"
date: "December 28, 2015"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}



![tree](http://jnguyen92.github.io/nhuyhoa/figure/images/tree.png)

A sample tree and how it cuts up the feature space. 

# Decision Trees
Decision trees generate a tree using a top-down algorithm. The idea is to find a feature that "best" divides the data and then recur on each subset of the data that the feature divides. The goal is to predict the class labels, which is done at the leaves of the tree. 

## Algorithm

$$MakeSubtree$$(set of training instances D)

* C = $$Determine.Candidate.Splits$$(D)
* if $$Stopping.Criteria.Met$$()
  * make a leaf node N
  * determine class label/probabilities for N
* else
  * make an internal node N
  * S = $$Find.Best.Split$$(D, C)
  * for each outcome k of S
    * $$D_k$$ = subset of isntances that have outcome k
    * $$k^{th}$$ child of N = $$Make.Subtree$$($$D_k$$)
* return subtree rooted at N

## How to Find the Best Split

### Nominal vs Numeric Features
Candidate splits on nominal features is quite simple. Features can be grouped by all of their categories or some combination of those categories. 

Candidate splits on numeric features requires a bit more thought. The numeric feature can be converted into categories by cutting/binning. The cutpoints could be defined as the median numeric value or any other threshold (depends on the algorithm).

### Information Gain
Entropy (information) is defined as <br>
$$H(Y) = - \sum_{y \in values(Y)} P(y)log_2(P(y))$$

The conditional entropy is defined as <br>
$$H(Y \vert X) = \sum_{x \in values(Y)} P(X = x)H(Y \vert X = x)$$

where <br>
$$H(Y \vert X = x) = - \sum_{y \in values(Y)} P(Y = y \vert X = x) log_2( P(Y = y \vert X = x) ) $$

Information gain is then defined as <br>
$$InfoGain(D, S) = H_D(Y) - H_D(Y \vert S)$$

The split $$S$$ that most reduces the conditional entropy of $$Y$$ for training set $$D$$ is chosen as the split.

This is the method used in the ID3 tree method. 

## Pruning
In order to prevent overfitting, trees can be pruned (removal of internal nodes).

**Algorithm:**

* Fit tree for training data, measure accuracy on tuning set
* Repeat until no progress on tuning set:
  * Consider all subtrees where 1 internal node is removed and replaced by a leaf
  * Remove the node that best improves tuning set accuracy

**Another Algorithm:**

Let <br>
$$ \sum^{\vert T \vert}_{m = 1} \sum_{i: x_i \in R_m} (y_i - \hat{y}_{R_m})^2 + \alpha \vert T \vert$$

where $$\alpha >= 0$$, $$\vert T \vert$$ is the number of terminal nodes in subtree, $$R_m$$ is the subset of predictor space corresponding to the $$m^{th}$$ terminal node, and $$\hat{y}_{R_m}$$ is the mean of the training observations in $$R_m$$.

If $$\alpha = 0$$, this is the original tree. As $$\alpha$$ increases, the tree incurs a price for having too many terminal nodes which forces the tree to become smaller. The value $$\hat{\alpha}$$ can be found via cross-validation.

## Strengths & Weaknesses

**Strengths:**

* Great technique for learning models noisy models
* Results are easily interpretable
* Can do automatic stepwise variable selection & complexity reduction
* Robust to outliers and missing data by doing surrogate splits (that would approximate the best fit) using another variable
* Fast, simple, and robust

**Weaknesses:**

* Only makes univariate splits; unable to consider interactions at a given node
* Greedy hill-climbing algorithm; early bad choice may doom the model
* Pruning may lead to a tree that removes a bad split early but its subtree has a good split later on
* Doesn't have the best prediction accuracy

# Regression Trees
In regression trees, the leaves of functions that predict numeric values rather than class labels. The functions may vary depending on the method. Some methods use constants whereas others use linear functions.

Rather than using information gain to score candidate splits, regression trees may use residual error, generated from a linear model. 

# Ensembles
Rather than fitting one tree, ensembling grows a set of trees using the training data. Then predictions are generated on each tree and then combined. Ensemble methods tend to outperform simpler methods and work very well in practice. 

Predictions from models can be combined in a variety of ways

* Unweighted votes
* Weighted votes (determined by tuning set accuracy)
* Learning a combining function

Because these methods average across a set of models, the variance of the predictions are reduced. 

Unfortunately, the results are quite difficult to interpret.

## Bagging

**Algorithm:**

* Repeat $$B$$ times
  * Choose with replacement $$N$$ examples from data set
  * Build tree to obtain the $$\hat{f}^{*b}(x)$$ prediction
  * Average all predictions (or take a majority vote for nominal responses)

If there is one very strong predictor, most of the bagged trees will use the predictor as the top split. Thus, the predictions from the trees will be highly correlated and the average predictions will have high variance. To decorrelate the predictions, random forests may be used.

## Random Forests

**Algorithm:**

Let $$N$$ = n-size, $$F$$ = # of parameters, $$i << F$$.

* Repeat k times
  * Choose with replacement $$N$$ examples from data set
  * Build tree, but in each recursive call
    * Choose (w/o replacement) $$i$$ features
    * Choose best of $$i$$ features as root of subtree
  * Do not prune
* Average all predictions (or take a majority vote for nominal responses)

The tuning parameter $$i$$ can be chosen by cross-validation. Typically choose $$i = \sqrt{F}$$. Increasing $$i$$ may (bias-variance tradeoff)

* increase correlation among individual trees in the forest (bad)
* increase the accuracy of individual trees (good) 

Because it samples from all possible features, random forests can handle a large number of features. It can also reduce overfitting drastically.

## Boosting
Boosting is a class of ensemble methods that sequentially produces multiple weak classifiers, where each classifier is dependent on the previous ones. Examples that are misclassfified by previous classifiers become more important in the next classifier. The classifiers can be combined to get <br>
$$C(x) = \theta (\sum_i w_i h_i(x) + b)$$

where $$w_i$$ is the weight and $$h_i(x)$$ is the classifier. 

There are many variants of boosting. All of them have the same idea. Here are two such algorithms.

**Regression Algorithm:**

* Set $$\hat{f}(x) = 0$$ and $$r_i = y_i \forall i$$ in the training set
* Repeat $$B$$ times
  * Fit a tree with $$\hat{f}^b$$ with $$d$$ splits (d + 1 terminal nodes) to the training data (X, r)
  * Update $$\hat{f}$$ by adding in a shrunken version of the new tree
$$\hat{f}(x) \leftarrow \hat{f}(x) + \lambda \hat{f}^b(x)$$
  * Update residuals
$$ r_i \leftarrow r_i - \lambda \hat{f}^b(x_i)$$
* Output boosted model
$$\hat{f}(x) = \sum^B_{b = 1} \lambda \hat{f}^b(x)$$

The interaction depth $$d$$ is also chosen via cross validation. The tuning parameter $$\lambda \ge 0$$ allows more trees to fit the residuals. This value is generally small (0.01 or 0.001). 

The idea with boosting is to learn slowing. The algorithm reweights examples (if wrong, increase weight; else decrease weight). Decision trees are fitted to the residuals of the model and then added to the model to update the residuals. This allows the model to improve in the areas that it doesn't perform well. 

**Discrete Adaboost Algorithm:**

* Assign equal weights to each training example
* Let $$E(f(x_i), y_i) = exp(-y_i f(x_i))$$
* Repeat $$T$$ times:
  * Choose $$f_t(x)$$
    * Do a greedy search for a weak learner $$h_t(x)$$ ($$h: x \rightarrow [-1, 1]$$) that minimizes $$\epsilon_t = \sum_i w_i E(h_t(x_i), y_i)$$ the weighted sum error for misclassified points
    * Choose weight $$a_t = \frac{1}{2} ln \left(\frac{1 - \epsilon_t}{\epsilon_t} \right)$$
  * Add to ensemble: $$F_t(x) = F_{t - 1}(x) + a_t h_t(x)$$
  * Update weights: $$w_{i, t+1} = w_{i, t} exp(-y_i a_t h_t(x_i))$$ and renormalize so that $$\sum_i w_{i, t+1} = 1$$

## Additional Notes

### Out of Bag Error
In each round of bootstrapping, about $$\frac{2}{3}$$ of the observations are sampled from the data to be used as the training set. That leaves about $$\frac{1}{3}$$ of the data that are not used to fit the data, which can be used as a testing set. So rather than using cross-validation, the out-of-bag (OOB) error can be utilized to select model parameters. 

### Variable Importance
Interpreting random forests can be quite difficult. One way to get a sense of the variables is to look at important variables (features).

**Procedure:**

* Use OOB samples to predict values
* Randomly permute values of one of the features and predict the values again
* Measure decrease in accuracy

**Alternate Procedure:**

* Measure the split criterion improvement
* Record improvements for each feature
* Accumulate over the whole ensemble

# In R

**CART**


Use the packages `rpart` and `rpart.plot`.


{% highlight r %}
library(rpart)
library(rpart.plot)

# fit decision tree
c_tree <- rpart(high ~ . - sales, carseats, method = "class")
# plot tree
prp(c_tree)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

{% highlight r %}
# prune tree using cross validation
printcp(c_tree)
{% endhighlight %}



{% highlight text %}
## 
## Classification tree:
## rpart(formula = high ~ . - sales, data = carseats, method = "class")
## 
## Variables actually used in tree construction:
## [1] advertising age         compprice   income      price      
## [6] shelveloc  
## 
## Root node error: 164/400 = 0.41
## 
## n= 400 
## 
##         CP nsplit rel error  xerror     xstd
## 1 0.286585      0   1.00000 1.00000 0.059980
## 2 0.109756      1   0.71341 0.71341 0.055477
## 3 0.045732      2   0.60366 0.61585 0.052981
## 4 0.036585      4   0.51220 0.61585 0.052981
## 5 0.027439      5   0.47561 0.60366 0.052629
## 6 0.024390      7   0.42073 0.57317 0.051707
## 7 0.012195      8   0.39634 0.56098 0.051321
## 8 0.010000     10   0.37195 0.53659 0.050518
{% endhighlight %}



{% highlight r %}
c_tree2 <- prune(c_tree, cp = 0.0122)
prp(c_tree2)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-2.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

{% highlight r %}
# fit regression tree
r_tree <- rpart(medv ~ ., Boston, method = "anova")
prp(r_tree)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-3.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

{% highlight r %}
# CV results
rsq.rpart(r_tree)
{% endhighlight %}



{% highlight text %}
## 
## Regression tree:
## rpart(formula = medv ~ ., data = Boston, method = "anova")
## 
## Variables actually used in tree construction:
## [1] crim  dis   lstat rm   
## 
## Root node error: 42716/506 = 84.42
## 
## n= 506 
## 
##         CP nsplit rel error  xerror     xstd
## 1 0.452744      0   1.00000 1.00541 0.083392
## 2 0.171172      1   0.54726 0.69949 0.062866
## 3 0.071658      2   0.37608 0.47011 0.048417
## 4 0.036164      3   0.30443 0.40389 0.045493
## 5 0.033369      4   0.26826 0.34695 0.042726
## 6 0.026613      5   0.23489 0.34641 0.044527
## 7 0.015851      6   0.20828 0.32119 0.041998
## 8 0.010000      7   0.19243 0.31290 0.043877
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-4.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" /><img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-5.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

Consider another example with the iris data set

{% highlight r %}
library(partykit)

# fit model 
iris_tree <- rpart(Species ~ Sepal.Width, Petal.Width, data = iris)

# plot results
iris_party <- as.party(iris_tree)
plot(iris_party)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


{% highlight r %}
library(tree)

# fit model with tree
iris_tree_2 <- tree(Species ~ Sepal.Width + Petal.Width, data = iris)

# another way to view cut
plot(iris$Petal.Width, iris$Sepal.Width, pch = 19, col = as.numeric(iris$Species))
partition.tree(iris_tree_2, label="Species", add = TRUE)
legend("topright",legend = unique(iris$Species), col = unique(as.numeric(iris$Species)), pch = 19)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

**Random Forests**

Random forests can be fit with the `randomForest` package. 


{% highlight r %}
library(randomForest)

# fit random forest
forest <- randomForest(medv ~ ., data = Boston, mtry = 5,  importance = TRUE)
forest
{% endhighlight %}



{% highlight text %}
## 
## Call:
##  randomForest(formula = medv ~ ., data = Boston, mtry = 5, importance = TRUE) 
##                Type of random forest: regression
##                      Number of trees: 500
## No. of variables tried at each split: 5
## 
##           Mean of squared residuals: 9.477957
##                     % Var explained: 88.77
{% endhighlight %}



{% highlight r %}
# view importance
importance(forest)
{% endhighlight %}



{% highlight text %}
##           %IncMSE IncNodePurity
## crim    16.292099     2289.2135
## zn       2.412934      179.8439
## indus   10.487262     2490.6408
## chas     2.470744      137.1248
## nox     19.099991     2431.8032
## rm      44.061506    12989.6253
## age     12.791394      985.8658
## dis     20.109259     2545.4295
## rad      6.919390      270.6165
## tax     12.812500     1148.7540
## ptratio 15.799574     2524.8979
## black   10.566951      703.6690
## lstat   33.652908    13409.3224
{% endhighlight %}

**Boosting**

Boosted models can be fit using the `gbm` package

{% highlight r %}
library(gbm)

# fit gbm
boost <- gbm(medv ~ ., data = Boston, distribution = "gaussian", n.trees = 10000, shrinkage = 0.01, interaction.depth = 4)

# view results
summary(boost)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

{% highlight text %}
##             var    rel.inf
## lstat     lstat 37.1694019
## rm           rm 30.6608440
## dis         dis  9.1110037
## crim       crim  4.9322476
## nox         nox  4.5005495
## age         age  3.7954041
## ptratio ptratio  3.2581330
## black     black  2.8337774
## tax         tax  1.7122363
## indus     indus  0.7747895
## rad         rad  0.6142983
## chas       chas  0.5058775
## zn           zn  0.1314372
{% endhighlight %}

