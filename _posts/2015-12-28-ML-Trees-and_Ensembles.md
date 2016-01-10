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
Entropy (information) is defined as
$$H(Y) = - \sum_{y \in values(Y)} P(y)log_2(P(y))$$

The conditional entropy is defined as 
$$H(Y \vert X) = \sum_{x \in values(Y)} P(X = x)H(Y \vert X = x)$$

where
$$H(Y \vert X = x) = - \sum_{y \in values(Y)} P(Y = y \vert X = x) log_2( P(Y = y \vert X = x) ) $$

Information gain is then defined as
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
Let 
$$ \sum^{\vert T \vert}_{m = 1} \sum_{i: x_i \in R_m} (y_i - \hat{y}_{R_m})^2 + \alpha \vert T \vert$$

where $$\alpha >= 0$$, $$\vert T \vert$$ is the number of terminal nodes in subtree, $$R_m$$ is the subset of predictor space corresponding to the $$m^{th}$$ terminal node, and $$\hat{y}_{R_m}$$ is the mean of the training observations in $$R_m$$.

When $$\alpha = 0$$, we have the original tree. As $$\alpha$$ increases, the tree incurs a price for having too many terminal nodes which forces the tree to become smaller. The value $$\hat{\alpha}$$ can be found via cross-validation.

## Strengths & Weaknesses

**Strengths:**

* Great technique for learning models noisy models
* Results are easily interpretable
* Robust to outliers and missing data
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
Rather than fitting one tree, we grow a a set of trees using the training data. Then we generate predictions on each tree and combine the predictions. Ensemble methods tend to outperform simpler methods and work very well in practice. 

Predictions from models can be combined in a variety of ways

* Unweighted votes
* Weighted votes (determined by tuning set accuracy)
* Learning a combining function

Because these methods average across a set of models, the variance of the predictions are reduced. 

Unfortunately, the results are quite difficult to interpret.

## Bagging

**Algorithm:**

* Repeat B times
  * Choose with replacement $$N$$ examples from data set
  * Build tree to obtain the $$\hat{f}^{*b}(x)$$ prediction
  * Average all predictions (or take a majority vote for nominal responses)

If there is one very strong predictor, most of the bagged trees will use the predictor as the top split. Thus, the predictions from the trees will be highly correlated and the average predictions will have high variance. To decorrelate the predictions, we could use a method called random forests.

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

The tuning parameter $$i$$ can be chosen by cross-validation. Typically we choose $$i = \sqrt{F}$$. Increasing $$i$$ may (bias-variance tradeoff)

* increase correlation among individual trees in the forest (bad)
* increase the accuracy of individual trees (good) 

Because it samples from all possible features, random forests can handle a large number of features. It can also reduce overfitting drastically.

## Boosting
Boosting is a class of ensemble methods that sequentially produces multiple weak classifiers, where each classifier is dependent on the previous ones. Examples that are misclassfified by previous classifiers become more important in the next classifier. The classifiers can be combined to get
$$C(x) = \theta (\sum_i w_i h_i(x) + b)$$

where $$w_i$$ is the weight and $$h_i(x)$$ is the classifier. 

There are many variants of boosting. All of them have the same idea. Here are two such algorithms.

**Regression Algorithm:**

* Set $$\hat{f}(x) = 0$$ and $$r_i = y_i \forall i$$ in the training set
* Repeat B times
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


We use the packages `rpart` and `rpart.plot`.


{% highlight r %}
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
## 3 0.045732      2   0.60366 0.71951 0.055615
## 4 0.036585      4   0.51220 0.71951 0.055615
## 5 0.027439      5   0.47561 0.73780 0.056017
## 6 0.024390      7   0.42073 0.71951 0.055615
## 7 0.012195      8   0.39634 0.66463 0.054298
## 8 0.010000     10   0.37195 0.64634 0.053821
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
## 1 0.452744      0   1.00000 1.00312 0.083091
## 2 0.171172      1   0.54726 0.64306 0.058531
## 3 0.071658      2   0.37608 0.41965 0.046179
## 4 0.036164      3   0.30443 0.34650 0.041608
## 5 0.033369      4   0.26826 0.35190 0.042314
## 6 0.026613      5   0.23489 0.34392 0.043532
## 7 0.015851      6   0.20828 0.30780 0.042288
## 8 0.010000      7   0.19243 0.30510 0.042599
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-4.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" /><img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-3-5.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

We can do another example with the iris data set.

{% highlight r %}
# fit model 
iris_tree <- rpart(Species ~ Sepal.Width, Petal.Width, data = iris)

# plot results
iris_party <- as.party(iris_tree)
plot(iris_party)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


{% highlight r %}
# fit model with tree
iris_tree_2 <- tree(Species ~ Sepal.Width + Petal.Width, data = iris)

# another way to view cut
plot(iris$Petal.Width, iris$Sepal.Width, pch=19, col=as.numeric(iris$Species))
partition.tree(iris_tree_2, label="Species", add=TRUE)
legend("topright",legend=unique(iris$Species), col=unique(as.numeric(iris$Species)), pch=19)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

**Random Forests**
Random forests can be fit with the `randomForest` package. 


{% highlight r %}
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
##           Mean of squared residuals: 9.912383
##                     % Var explained: 88.26
{% endhighlight %}



{% highlight r %}
# view importance
importance(forest)
{% endhighlight %}



{% highlight text %}
##           %IncMSE IncNodePurity
## crim    17.181189     2457.0926
## zn       2.740325      186.5410
## indus   10.850019     2416.2958
## chas     3.764951      150.9747
## nox     18.059678     2581.5122
## rm      41.001366    13435.8859
## age     13.305575     1010.5205
## dis     17.328140     2472.3621
## rad      5.027595      253.8563
## tax     13.393890      993.8280
## ptratio 14.989223     2448.8228
## black    7.599927      701.5214
## lstat   32.558837    12943.0280
{% endhighlight %}

**Boosting**

{% highlight r %}
# fit gbm
boost <- gbm(medv ~ ., data = Boston, distribution = "gaussian", n.trees = 10000, shrinkage = 0.01, interaction.depth = 4)

# view results
summary(boost)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2015-12-28-ML-Trees-and_Ensembles/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

{% highlight text %}
##             var    rel.inf
## lstat     lstat 37.0559383
## rm           rm 30.7266839
## dis         dis  8.6985977
## crim       crim  4.9047198
## nox         nox  4.8788260
## age         age  3.9729838
## ptratio ptratio  2.9984237
## black     black  2.8437262
## tax         tax  1.8099648
## indus     indus  0.7543425
## rad         rad  0.6424044
## chas       chas  0.5842021
## zn           zn  0.1291868
{% endhighlight %}

