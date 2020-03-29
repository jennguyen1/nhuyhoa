---
layout: post
title: "Principal Components Analysis"
date: "January 3, 2016"
categories: Statistics
tags: Multivariate_Analysis
---

* TOC
{:toc}



# Principal Components Analysis (PCA)
PCA is a dimension-reduction technique that produces a low-dimensional representation of a high-dimensional dataset. It finds a sequence of linear combinations of the variables that have 

* Maximal variance
* Mutually uncorrelated (orthogonal)

In doing so, PCA can reduce the number of features from $$p$$ to $$M$$, where $$M < p$$.
It is often helpful in dealing with cases in which the curse of dimensionality is severe. 

The curse of dimensionality refers to the breakdown of modeling techniques when the number of parameters increase. For example in KNN, increasing the number of dimensions results in data points that are farther away, which affects the algorithm efficiency.

Prior to running the PCA algorithm, it is necessary to **standardize** the features. If the data is not normalized features with large values and large variances will dominate the principal components. Normalizing the features will ensure that all variables are on the same scale and have an equal opportunity to contribute to PCA. 

## Singular Value Decomposition (SVD)
PCA uses singular value decomposition (SVD).

With SVD, every matrix $$R$$ can be written as
$$ X = U \Sigma V^T$$

where 

* $$\Sigma_{Nxp}$$ is diagonal matrix with nonzero elements along first $$p$$ diagonals
* $$V_{pxp}$$ is an orthogonal matrix ($$A$$ is orthogonal if $$A^TA = AA^T = I$$) in which the columns form an orthonormal basis for the row vectors of $$X$$ 
* $$U_{NxN}$$ is an orthogonal matrix in which the columns form an orthonormal basis for the space spanned by the column vectors of $$X$$

Regenerate the symmetric matrix with

---------|---------------------
$$X^T X$$| $$ = (U \Sigma V^T)^T (U \Sigma V^T)$$
         | $$ = (V \Sigma U^T) (U \Sigma V^T)$$
         | $$= (V \Sigma^2 V^T)^T$$

The matrix $$X^T X$$ is symmetric and so it can be written in the form $$Q \Lambda Q^T$$ where $$Q$$ is the orthogonal matrix of eigenvectors and $$\Lambda$$ are is a diagonal matrix of eigenvalues. Thus

* Columns of $$V$$ are eigenvectors (of $$X^TX$$), ie the principal components loadings
* Diagonal entries of $$D$$ are the eigenvalues (of $$X^TX$$) ordered from largest to smallest, ie the standard deviations (can derive the proportion of variance explained)

Rearranging the SVD formula $$X = UDV^T$$ to $$XV = UD$$ results in the principal component scores. 

The principal component scores can be used in place of the original features. 

## Geometric Interpretation
The first principal component loading vector defines the line in $$p$$-dimensional space that is closest to the $$n$$ observations (Euclidean distance). The first 2 principal components of a dataset span the plane that is closest to the $$n$$ observations. 

![PCA Geometric Interpretation](http://jennguyen1.github.io/nhuyhoa/figure/images/principal_components.png)

Green line is the $$1^{st}$$ principal component and the blue dashed line is the $$2^{nd}$$ principal component. (Hastie, et.al)

## Principal Components In R

{% highlight r %}
# grab some data
dat <- data.frame(scale(mtcars))

# run singular value decomposition
svd <- svd(dat)

# run principal components
pc <- prcomp(dat)
{% endhighlight %}

**PC Loadings**

{% highlight r %}
# Using PCA
pc$rotation

# Using SVD
svd$v
{% endhighlight %}

**Variance Explained**

{% highlight r %}
# Using PCA
pc$sdev^2

# Using SVD
svd$d^2

# PC returns a scaled version of the SVD output, the following code should equal pc$sdev^2
svd$d^2 / (nrow(dat) - 1)
{% endhighlight %}
The proportion of variance explained can be obtained by dividing each variance explained value by the sum of all variance explained values.

**PC Scores**

{% highlight r %}
# Using PCA
pc$x

# Using SVD
as.matrix(dat) %*% svd$v
{% endhighlight %}

## Interpretation of the Principal Components

A plot of the first two principal components against each other with the loadings may relay some important information regarding the components. This plot is called a biplot. This requires the `ggfortify` package. 



{% highlight r %}
library(ggfortify)

# plot the biplot
autoplot(prcomp(dat, center = TRUE, scale. = TRUE), data = iris, colour = "Species", 
         loadings = TRUE, loadings.label = TRUE,
         loadings.label.size = 3)
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-03-Principal-Components-Analysis/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

From this plot, the first principal components has large loadings for $$Petal.Length$$, $$Petal.Width$$, and $$Sepal.Length$$, . This indicates that $$Length$$ and $$Petal$$ attributes vary together (are correlated) and make up a large part of the first principal component. The second principal component has large loadings for $$Sepal.Length$$ and $$Sepal.Width$$. The $$Sepal$$ attributes are correlated and make up a large part of the second principal component. 

Each point on the plot refers to a single data point. For example, points with high values on the first principal component will have high values for $$Petal.Width$$, $$Petal.Length$$, and $$Sepal.Length$$. A point with low values of the second principal component will have high values of $$Sepal.Width$$ and $$Sepal.Length$$. 

Here's another way to visualize the loadings. 

<img src="/nhuyhoa/figure/source/2016-01-03-Principal-Components-Analysis/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

Often you have an external label that can be used to identify how the PCs performed. Here we plot the PCs for each data point with the external label. The plot shows that PC1 does a good job of separating the observations by $$Species$$, even when $$Species$$ wasn't used in the principal components analysis. 

<img src="/nhuyhoa/figure/source/2016-01-03-Principal-Components-Analysis/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

This type of plot is common in genetic analyses to determine the ancestry of study participants based on genotype information. 

## Choosing How Many Principal Components
There is no best method to choose the number of components. However, one thing that could be done is to look at the "scree plot" and look for the point at which the trend converges. 


{% highlight r %}
x <- 1:length(pc$sdev)
y <- pc$sdev^2 / sum(pc$sdev^2)
ggplot(data = NULL, aes(x = x, y = y)) + 
  geom_point() + 
  geom_line() +
  scale_x_continuous(breaks = seq(1, length(pc$sdev), by = 2)) +
  xlab("Principal Component") + ylab("Prop. Variance Explained")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-03-Principal-Components-Analysis/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" style="display: block; margin: auto;" />

In this plot, using 5-7 principal components would be adequate. 

## What PCA Can Be Used For

* Use for data visualization or data pre-processing
* Evaluate whether there may be confounding effects (plot principal components grouped by a variable) to see if certain effects/variables capture the majority of the variance
* Simplify high-dimensional data and use as features in other methods, like regression (however it may be harder to interpret variables)

PCA is great for providing a low-dimensional representation of high-dimensional data. Thus it works best when the first few PC are sufficient in capturing most of the variation in the predictors. (So it is generally not a good idea to use all of the PC).

For example if running an experiment, PCA can be used to assess whether there may be confounding effects due to improper randomization. 

In R, one can do principal components regression with `pls::pcr()`. This package also has functions to view cross-validated results with the `validationplot()` function. 


{% highlight r %}
# fit PCR
pcr.fit <- pls::pcr(mpg ~ ., data = mtcars, scale = TRUE, validation = "CV")
# results
summary(pcr.fit)
{% endhighlight %}



{% highlight text %}
## Data: 	X dimension: 32 10 
## 	Y dimension: 32 1
## Fit method: svdpc
## Number of components considered: 10
## 
## VALIDATION: RMSEP
## Cross-validated using 10 random segments.
##        (Intercept)  1 comps  2 comps  3 comps  4 comps  5 comps
## CV           6.123    2.699    2.718    2.501    2.530    2.584
## adjCV        6.123    2.687    2.705    2.487    2.515    2.565
##        6 comps  7 comps  8 comps  9 comps  10 comps
## CV       2.691    2.860    2.971    3.528     3.578
## adjCV    2.667    2.827    2.928    3.454     3.497
## 
## TRAINING: % variance explained
##      1 comps  2 comps  3 comps  4 comps  5 comps  6 comps  7 comps
## X      57.60    84.10    90.07    92.77    94.99    97.09    98.42
## mpg    82.53    82.63    85.40    85.41    85.47    85.56    85.58
##      8 comps  9 comps  10 comps
## X      99.23    99.76     100.0
## mpg    85.85    86.09      86.9
{% endhighlight %}



{% highlight r %}
pls::validationplot(pcr.fit, val.type = "MSEP")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-03-Principal-Components-Analysis/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />
So here using 3 principal components is preferred. To specify a a number of components, pass the argument `ncomps = n` instead of the `validation` argument. 

# Partial Least Squares
Partial least squares (PLS) is a supervised learning modification of principal components regression (PCR). PLS generates the new low-dimensional features by making use of the response Y. It finds components that help explain both the response and the predictors. 

Similar to PCR, PLS requires that the predictors are standardized. The first principal component is computed by setting the loading vector equal to the coefficients from OLS of $$Y \sim X_j$$. These values are proportional to the correlation between $$Y$$ and $$X_j$$. Thus the scores from the first component is $$Z_1 = \sum^p_{j = 1} \phi_{1j}X_j$$. In other words, PLS places greater weight on predictors that are most strongly related to the response. The following components are found by taking residuals and then repeating the procedure above. In R, this can be done with `pls::plsr()`.




