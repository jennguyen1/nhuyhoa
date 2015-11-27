---
layout: post
title: "R Cool Functions List"
date: "July 24, 2015"
categories: R
---

* TOC
{:toc}


R reference card: https://cran.r-project.org/doc/contrib/Short-refcard.pdf
[dplyr_cheatsheet_link]: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
[dt_cheatsheet_link]: https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf

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
