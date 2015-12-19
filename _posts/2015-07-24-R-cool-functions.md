---
layout: post
title: "R Cool Functions List"
date: "July 24, 2015"
categories: R
---

* TOC
{:toc}



# Links

* [R reference][r_ref]{:target = "_blank"}
* [dplyr cheatsheet][dplyr_ref]{:target = "_blank"}
* [data.table cheatsheet][data.table_ref]{:target = "_blank"}

[r_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMMWN5dmhaT05IRkk/view?usp=sharing
[dplyr_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMblBxTjEwRWZXYjQ/view?usp=sharing
[data.table_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMOTVOSnRVMkFHczQ/view?usp=sharing

The `broom` package has three main functions that deal with a variety of modeling functions

* `tidy`: extracts the model estimates and p-values
* `glance`: extracts the model statistics ($$R^2$$, etc)
* `augment`: extracts the individual data point statistics (fitted values, residuals, leverages, etc)

# Numeric Types

|func               |descr                                           |
|:------------------|:-----------------------------------------------|
|seq(from, to, by)  |generate regular sequences                      |
|range()            |produces sample quantiles                       |
|quantile(x, probs) |computes min/max of all args                    |
|cut(x, breaks)     |cuts up continuous values into factor intervals |
|dist(x)            |computes pairwise distances for all points      |

# Logical Types

|func                     |descr                        |
|:------------------------|:----------------------------|
|which()                  |gives the TRUE indices       |
|%in%                     |finds matches                |
|between(x, lower, upper) |whether x is between l and u |

# Character Types

{% highlight r %}
func <- c(""
          )

descr <- c(""
           )

data.frame(func, descr) %>% kable
{% endhighlight %}



|func |descr |
|:----|:-----|
|     |      |

# Input/Output

{% highlight r %}
func <- c("list.files(dir)",
          "save(list = ls(), file = '__.Rdata')"
          )

descr <- c("obtain a list of all files in given file path",
           "save all vars for another session"
           )

data.frame(func, descr) %>% kable
{% endhighlight %}



|func                                 |descr                                         |
|:------------------------------------|:---------------------------------------------|
|list.files(dir)                      |obtain a list of all files in given file path |
|save(list = ls(), file = '__.Rdata') |save all vars for another session             |


# Any Type

{% highlight r %}
func <- c(""
          )

descr <- c(""
           )

data.frame(func, descr) %>% kable
{% endhighlight %}



|func |descr |
|:----|:-----|
|     |      |
sample (takes a random sample of x), order, sort, table, str, summary, names, colnames, rownames, assign("name", obj), get("name"), expand.grid, interaction, mapvalues
