---
layout: post
title: "Distribution Facts"
date: "October 18, 2015"
categories: ['statistics', 'probability theory']
---

* TOC
{:toc}


{% highlight text %}
## Warning: replacing previous import by 'grid::arrow' when loading
## 'GGally'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'grid::unit' when loading
## 'GGally'
{% endhighlight %}

# Normal Distribution
Let $$ X $$ ~ $$ N(\mu, \sigma^2) $$

$$ f_x(x) = \frac{1}{\sigma \sqrt{2\pi}} exp{\frac{-(x - \mu)^2}{2 \sigma^2}} $$

$$ X = \mu + \sigma Z$$ where $$ Z $$ ~ $$ N(0, 1) $$

If $$ X_i $$ ~ $$ iidN(\mu, \sigma^2) $$ then $$ \Sigma X_i $$ ~ $$ N(\Sigma \mu, \Sigma \sigma^2) $$

# Chi-Square Distribution
Let $$ V = X^2_1 = Z^2 $$

Note that $$ X^2_1 $$ ~ $$ Gamma(\frac{1}{2}, \frac{1}{2}) $$

Also $$ X^2_k = \Sigma Z^2_i $$ ~ $$ Gamma(\frac{1}{2}, \frac{k}{2}) $$ where $$k$$ is the degrees of freedom. 

# t Distribution
Let $$Z$$  ~ $$ N(0, 1) $$ and $$V$$ ~ $$ X^2_k$$ and $$ Z \perp V $$ then 

$$ t = \frac{Z}{\sqrt{V/k}} $$

is the student's $$t$$-distribution with $$k$$ df. 

The $$t$$-distribution is essentially the normal distribution with fatter tails. Note that $$ t $$ converges in distribution to $$ N(0, 1) $$ as $$ n \rightarrow \infty $$. 

# F Distribution
Let $$V$$ ~ $$ X^2_m $$ and $$W$$ ~ $$ X^2_k $$ and $$ V \perp W $$ then 

$$ F = \frac{V/m}{W/k} $$

is the $$F$$ distribution with $$m$$, $$k$$ df.

Note that $$ F_{1, k} = t^2_k $$

# Other Distributions
See the[Probability Overview post][prob_overview_post]{:target = "_blank"}.

[prob_overview_post]: http://jnguyen92.github.io/nhuyhoa//2015/10/Probability-Overview.html
