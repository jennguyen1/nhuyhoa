---
layout: post
title: "Regression: Orthogonal Columns"
date: "October 25, 2015"
categories: statistics
---

* TOC
{:toc}



Orthogonal design matrices in regression ensures that the $$\beta$$ estimates do not depend on each ohter. In other words, because there is no collinearity between columns, the effect of one factor or interaction can be estimated separately from the effect of any other factor/interaction in the model.

Let the design matrix be
$$\mathbf{X} = \left[\begin{array}
{rrr}
x_0 & x_1 & x_2 & ... & x_p
\end{array}\right]
$$

where $$x_i$$ are columns vectors and the columns are mutually independent.

We know that
$$ \hat{\beta} = (X^TX)^{-1}X^TY $$

Since the columns of $$X$$ are mutually orthogonal, we have the diagonal matrix
$$\mathbf{(X^TX)^{-1}} = \left[\begin{array}
{rrr}
\frac{1}{x^{T}_{0}x_0} & 0 & 0 & 0 & 0 \\
0 & \frac{1}{x^{T}_{1}x_1} & 0 & 0 & 0 \\
0 & 0 & \frac{1}{x^{T}_{2}x_2} & 0 & 0 \\
0 & 0 & 0 & ... & 0 \\
0 & 0 & 0 & 0 & \frac{1}{x^{T}_{p}x_p} 
\end{array}\right]
$$

Plug this in to compute $$ \hat{\beta} $$
$$ \hat{\beta} = \left[\begin{array}
{cc}
\frac{1}{x^{T}_{0}x_0} & 0 & 0 & 0 & 0 \\
0 & \frac{1}{x^{T}_{1}x_1} & 0 & 0 & 0 \\
0 & 0 & \frac{1}{x^{T}_{2}x_2} & 0 & 0 \\
0 & 0 & 0 & ... & 0 \\
0 & 0 & 0 & 0 & \frac{1}{x^{T}_{p}x_p} 
\end{array}\right]
\left[\begin{array}
{cc}
x^T_0Y \\
x^T_1Y \\
x^T_2Y \\
... \\
x^T_pY \\
\end{array}\right]
$$

Resulting in the final estimate
$$ \hat{\beta} = \left[\begin{array}
{rrr}
\frac{x^T_0Y}{x^{T}_{0}x_0}  \\
\frac{x^T_1Y}{x^{T}_{1}x_1}  \\
\frac{x^T_2Y}{x^{T}_{2}x_2} \\
... \\
\frac{x^T_pY}{x^{T}_{p}x_p} 
\end{array}\right]
$$


Note that the $$\beta_j$$ estimate depends only on the $$j^{th}$$ column in the design matrix. Thus we conclude that the effect of one factor is estimated indepedently of other factors.

