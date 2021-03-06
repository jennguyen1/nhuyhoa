---
layout: post
title: "Distribution Facts"
date: "October 18, 2015"
categories: Statistics
tags: Probability_and_Inference
---

* TOC
{:toc}



# Normal Distribution
Let $$ X  \sim  N(\mu, \sigma^2) $$

$$ f_x(x) = \frac{1}{\sigma \sqrt{2\pi}} exp \left( \frac{-(x - \mu)^2}{2 \sigma^2} \right) $$

$$ X = \mu + \sigma Z$$ where $$ Z  \sim  N(0, 1) $$

If $$ X_i  \sim  iidN(\mu, \sigma^2) $$ then $$ \sum X_i  \sim  N(\sum \mu, \sum \sigma^2) $$

## Multivariate Normal Distribution
Let $$ \overrightarrow{X}  \sim  N(\overrightarrow{\mu}, \Sigma) $$

$$ f(\overrightarrow{X}) = \frac{1}{(2\pi)^{n/2} \vert \Sigma \vert^{1/2}} exp \left( -\frac{1}{2} (x - \overrightarrow{\mu})^T \Sigma^{-1} (x - \overrightarrow{\mu}) \right)$$ 

Properties:

* Sum of independent Gaussians are Gaussian

If $$X, Y \sim MVN$$ (with its own parameters)

Then $$X + Y \sim N(\overrightarrow{\mu}_x + \overrightarrow{\mu}_y, \Sigma_x + \Sigma_y)$$

* Marginal of a joint Gaussian is Gaussian

If $$\left[\begin{array}
{rrr}
X \\
Y
\end{array}\right] \sim N\left(\left[\begin{array}
{rrr}
\mu_x \\
\mu_y
\end{array}\right], \left[\begin{array}
{rrr}
\Sigma_{xx} \Sigma_{xy} \\
\Sigma_{yx} \Sigma_{yy}
\end{array}\right] \right)$$

Then 
$$X \sim N(\mu_x, \Sigma_{xx})$$ and 
$$Y \sim N(\mu_y, \Sigma_{yy})$$

* Conditional of a joint Gaussian is Gaussian

If $$\left[\begin{array}
{rrr}
X \\
Y
\end{array}\right] \sim N\left(\left[\begin{array}
{rrr}
\mu_x \\
\mu_y
\end{array}\right], \left[\begin{array}
{rrr}
\Sigma_{xx} \Sigma_{xy} \\
\Sigma_{yx} \Sigma_{yy}
\end{array}\right] \right)$$

Then 
$$X \vert Y \sim N(\mu_x + \Sigma_{xy} \Sigma^{-1}_{yy} (x_y - \mu_y), \Sigma_{xx} - \Sigma_{xy} \Sigma_{yy}^{-1} \Sigma_{yx})$$
$$Y \vert X \sim N(\mu_y + \Sigma_{yx} \Sigma^{-1}_{xx} (x_x - \mu_x), \Sigma_{yy} - \Sigma_{yx} \Sigma_{xx}^{-1} \Sigma_{xy})$$

# Chi-Square Distribution
Let $$ V = \chi^2_1 = Z^2 $$

Note that $$ \chi^2_1  \sim  Gamma(\frac{1}{2}, \frac{1}{2}) $$

Also $$ \chi^2_k = \sum Z^2_i  \sim  Gamma(\frac{1}{2}, \frac{k}{2}) $$ where $$k$$ is the degrees of freedom. 

# t Distribution
Let $$Z$$  ~ $$ N(0, 1) $$ and $$V \sim  \chi^2_k$$ and $$ Z \perp V $$ then 

$$ t = \frac{Z}{\sqrt{V/k}} $$

is the student's $$t$$-distribution with $$k$$ df. 

The $$t$$-distribution is essentially the normal distribution with fatter tails. Note that $$ t $$ converges in distribution to $$ N(0, 1) $$ as $$ n \rightarrow \infty $$. 

# F Distribution
Let $$V \sim  \chi^2_m $$ and $$W \sim  \chi^2_k $$ and $$ V \perp W $$ then 

$$ F = \frac{V/m}{W/k} $$

is the $$F$$ distribution with $$m$$, $$k$$ df.

Note that $$ F_{1, k} = t^2_k $$

# Other Distributions
See the [Probability Overview post][prob_overview_post]{:target = "_blank"}.

# Distributions of Common Statistics
Suppose

* $$X_1, ..., X_n$$ are observations of a random sample from $$N \sim N(\mu, \sigma^2)$$
* $$\bar{X} = \frac{1}{n} \Sigma_i^n X_i $$ is the sample mean of the observations
* $$ S^2 = \frac{1}{n - 1} \Sigma_i^n (X_i - \bar{X})^2 $$ is the sample variance of the observations

Then:

* $$\bar{X}$$ and $$S^2$$ are independent
* .$$\frac{(n-1)S^2}{\sigma^2} = \frac{\Sigma_i^n (X_i - \bar{X})^2}{\sigma^2}  \sim  X^2_{n - 1} $$

[prob_overview_post]: http://jennguyen1.github.io/nhuyhoa/statistics/Probability-Overview.html
