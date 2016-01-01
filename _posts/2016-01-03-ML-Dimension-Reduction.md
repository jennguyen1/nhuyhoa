---
layout: post
title: "Dimension Reduction"
date: "January 3, 2016"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}



# Principal Components Analysis (PCA)
PCA is a dimension-reduction tecnique that produces a low-dimensional representation of a high-dimensional dataset. It finds a sequence of linear combinations of the variables that have

* Maximal variance
* Mutually uncorrelated

In doing so, PCA can reduce the number of features from $$p$$ to $$M$$, where $$M < p$$.
It is often helpful in dealing with cases in which the curse of dimensionality is severe. 

The curse of dimensionality refers to the breakdown of modeling techniques when the number of parameters increase. For example in KNN, increasing the number of dimensions results in data points that are farther away which affects the algorithm efficiency.

Prior to running the PCA algorithm, it is necessary to normalize the features. If the data is not normalized features with large values and large variances will dominate the principal components. Normalizing the features will ensure that all variables are on the same scale and have an equal opportunity to contribute to PCA. 

## Singular Value Decomposition (SVD)
PCA uses singular value decomposition (SVD).

With SVD, every matrix $$R$$ can be written as
$$ X = U \Sigma V^T$$

where 

* $$\Sigma_{pxp}$$ is diagonal  
* $$V_{pxp}$$ is orthogonal ($$A$$ is orthogonal if $$A^TA = AA^T = I$$). 
* $$U_{Nxp}$$ is orthogonal

We can regenerate the symmetric matrix with
$$X^T X = (U \Sigma V^T)^T (U \Sigma V^T)$$
$$X^T X = (V \Sigma U^T) (U \Sigma V^T)$$
$$X^T X = (V \Sigma^2 V^T)^T$$

The matrix $$X^T X$$ is symmetric and so it can be written in the form $$Q \Lambda Q^T$$ where $$Q$$ is the orthogonal matrix of eigenvectors and $$\Lambda$$ are is a diagonal matrix of eigenvalues. Thus

* Columns of $$V$$ are eigenvectors (of $$X^TX$$), ie the principal components loadings
* Diagonal entries of $$D$$ are the eigenvalues (of $$X^TX$$), ie the standard deviations (can derive the proportion of variance explained)

We can also rearrange the SVD formula $$X = UDV^T$$ to $$XV = UD$$. This vector contains the principal component scores. 

The principal component scores can be used in place of the original features. 

## Geometric Interpretation
The first principal component loading vector defines the line in $$p$$-dimensional space that is closest to the $$n$$ observations (Euclidean distance). The first 2 principal components of a dataset span the plane that is closest to the $$n$$ observations. 

![PCA Geometric Interpretation](http://jnguyen92.github.io/nhuyhoa/figure/images/principal_components.png)
Green line is the $$1^{st}$$ principal component and the blue dashed line is the $$2^{nd}$$ principal component. (Hastie, et.al)

## Principal Components In R

{% highlight r %}
# grab some data
dat <- data.frame(scale(mtcars))

# run singular value decomposition
svd <- svd(dat)

# run principal components
pc <- princomp(dat)
{% endhighlight %}

PC Loadings:

{% highlight r %}
# Using PCA
pc$loadings

# Using SVD
svd$v
{% endhighlight %}

Variance Explained

{% highlight r %}
# Using PCA
pc$sdev^2

# Using SVD
svd$d^2

# PC returns a scaled version of the SVD output, the following code should equal pc$sdev^2
svd$d^2 / nrow(dat)
{% endhighlight %}
The proportion of variance explained can be obtained by dividing each variance explained value by the sum of all variance explained values.

PC Scores

{% highlight r %}
# Using PCA
pc$scores

# Using SVD
as.matrix(dat) %*% svd$v
{% endhighlight %}

## Chosing How Many Principal Components
There is no best method to choose the number of components. However, one thing we could doo is look at the "scree plot" and look for the point at which the trend converges. 


{% highlight r %}
x <- 1:length(pc$sdev)
y <- pc$sdev^2 / sum(pc$sdev^2)
ggplot(data = NULL, aes(x = x, y = y)) + 
  geom_point() + 
  geom_line() +
  scale_x_continuous(breaks = seq(1, length(pc$sdev), by = 2)) +
  xlab("Principal Component") + ylab("Prop. Variance Explained")
{% endhighlight %}

<img src="/nhuyhoa/figure/source/2016-01-03-ML-Dimension-Reduction/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

In this plot, we could potentially choose to use 5-7 principal components. 

## What PCA Can Be Used For

* Use for data visualization or data pre-processing
* Use to simplify high-dimensional data; use PC as features in various other methods 

PCA is great for providing a low-dimensional representation of high-dimensional data. Thus it works best when the first few PC are sufficient in capturing most of the variation in the predictors. (So it is generally not a good idea to use all of the PC).

# Partial Least Squares
Partial least squares (PLS) is a supervised learning modification of principal components regression (PCR). PLS generates the new low-dimensional features by making use of the response Y. It finds components that help explain both the response and the predictors. 

Similar to PCR, PLS requires that the predictors are standardized. The first principal component is computed by setting the loading vector equal to the coefficients from OLS of $$Y$$ ~ $$X_j$$. These values are proportional to the correlation between $$Y$$ and $$X_j$$. Thus the scores from the first component is $$Z_1 = \Sigma^p_{j = 1} \phi_{1j}X_j$$. In other words, PLS places greater weight on predictors that are most strongly related to the response. The following components are found by taking residuals and then repeating the procedure above. 




