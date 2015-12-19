---
layout: post
title: "OLS: Box-Cox Transformations"
date: "November 15, 2015"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Background
When regression diagnostics display a violation of assumptions, one step we can take is to transform our variables. The Box-Cox family of transformations provide a procedure for finding the best transformation. This parameterized family of transformations is continuous at $$y>0$$ for a fixed $$\lambda$$ and it is continuous at $$\lambda$$ for a fixed $$y$$, even at $$\lambda = 0$$. 

Let Y be the response variable. Then
$$\mathbf{y^{(\lambda})} = \left[\begin{array}
{rrr}
  \frac{y^{\lambda} - 1}{\lambda} & \lambda \ne 0 \\
  log(y) & \lambda = 0
\end{array}\right]$$

where $$Y(\lambda) $$ ~ $$N(X\beta, \sigma^2 I)$$.

The value $$\lambda$$ is found through maximum likelihood. 
$$ f(Y_i, X_i, i = 1...n$$ | $$ \lambda, \beta_0, \beta_1, \sigma^2) = \Pi^n_{i = 1} \frac{1}{\sqrt{2 \pi \sigma^2}} exp[\frac{-1}{2\sigma^2} (Y_i(\lambda) - \beta_0 - \beta_1 X_i)] $$

# Implementation

|lambda |transformation |
|:------|:--------------|
|-2     |Y^(-2)         |
|-1     |Y^(-1)         |
|-0.5   |Y^(-0.5)       |
|0      |log(Y)         |
|0.5    |Y^0.5          |
|1      |Y              |
|2      |Y^2            |

The $$\lambda$$ value corresponding to the best transformation can computed in R. 

We will use this example data set.


<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> survtimes </th>
   <th style="text-align:center;"> A </th>
   <th style="text-align:center;"> B </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 0.31 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> -1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0.45 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> -1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0.46 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> -1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0.43 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> -1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0.45 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div><p></p>


{% highlight r %}
# fit model - up to 2-way interactions
mod <- lm(survtimes ~ A*B, data = data)
# plot diagnostic plots
plot(mod$residuals ~ mod$fitted.values)
{% endhighlight %}

<img src="/nhuyhoafigure/source/2015-11-15-OLS-Box-Cox/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />
There is funneling pattern given in the resids vs fitted plot that indicates heteroskedaskticity.


{% highlight r %}
# load the MASS package
library(MASS)

# run boxcox
bcmod <- boxcox(mod)
{% endhighlight %}

<img src="/nhuyhoafigure/source/2015-11-15-OLS-Box-Cox/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

{% highlight r %}
bcmod$x[bcmod$y == max(bcmod$y)]
{% endhighlight %}



{% highlight text %}
## [1] -0.3030303
{% endhighlight %}
From the boxcox method we see that $$\lambda = -0.303$$. This corresponds to the $$log(Y)$$ transformation. (Note that the inverse square root transformation is ok too).


{% highlight r %}
# implement transformation
transmod <- lm(log(survtimes) ~ A*B, data = data)
plot(transmod$residuals ~ transmod$fitted.values)
{% endhighlight %}

<img src="/nhuyhoafigure/source/2015-11-15-OLS-Box-Cox/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />
After the transformation, we see that the prior heterskedaskticity has been alleviated. 
