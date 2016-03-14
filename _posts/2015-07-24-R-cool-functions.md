---
layout: post
title: "R Cool Functions List"
date: "July 24, 2015"
categories: ['r programming']
---

* TOC
{:toc}



**General R**

* [R reference][r_ref]{:target = "_blank"}
* [dplyr cheatsheet][dplyr_ref]{:target = "_blank"}
* [data.table cheatsheet][data.table_ref]{:target = "_blank"}


**Graphics in R**

* [ggplot2 cheatsheet][ggplot2_ref]{:target = "_blank"}
* [GGally::ggpairs()][grid.arrange]{:target = "_blank"}
* Plotmath

{% highlight r %}
help(plotmath)
{% endhighlight %}

* RColorBrewer


{% highlight r %}
library(RColorBrewer)
display.brewer.all()
{% endhighlight %}

![plot of chunk unnamed-chunk-3](/nhuyhoa/figure/source/2015-07-24-R-cool-functions/unnamed-chunk-3-1.png)


**Other R Apps**

* [shiny cheatsheet][shiny_ref]{:target = "_blank"}
* [rmarkdown][rmarkdown_ref]{:target = "_blank"}
* [rmarkdown2][rmarkdown_ref2]{:target = "_blank"}


[r_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMMWN5dmhaT05IRkk/view?usp=sharing
[dplyr_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMblBxTjEwRWZXYjQ/view?usp=sharing
[data.table_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMYUtxVHVUVFVDbGc/view?usp=sharing
[ggplot2_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMd1RDSlFYQ0lSZFE/view?usp=sharing
[grid.arrange]: http://www.sthda.com/english/wiki/ggplot2-easy-way-to-mix-multiple-graphs-on-the-same-page-r-software-and-data-visualization
[shiny_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMU0JWZmtWSXF0dHc/view?usp=sharing
[rmarkdown_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMV2NBbWlSNHJvM2c/view?usp=sharing
[rmarkdown_ref2]: https://drive.google.com/file/d/0B5VF_idvHAmMTHU4MFRDV1Z3NUE/view?usp=sharing

**Not Yet:**

locator function:

* ggmap::gglocator()
* heatmaps with dendrograms 2x2


The `broom` package has three main functions that deal with a variety of modeling functions

* `tidy`: extracts the model estimates and p-values
* `glance`: extracts the model statistics ($$R^2$$, etc)
* `augment`: extracts the individual data point statistics (fitted values, residuals, leverages, etc)


data.tables:

* with = FALSE: j is a vector of names or positions to select (similar to data frames)
* DT[, .SD[which.max(i)], by = j]: saves the row that corresponds to max i for each unique j


* assign
* na.omit
* complete.cases

* list of functions

* partial(f, ..): changes the deafults of functions
* sf <- pryr::partial(sum, 1:5, na.rm = TRUE)
sf()
* translate_sql() in dplr r to sql

plot multiple data frames: 

{% highlight r %}
ggplot() + 
  geom_histogram(data=x, ...) +
  geom_point(data = y, ...)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "ggplot"
{% endhighlight %}



{% highlight r %}
iris %>%
     group_by(Species)  %>%
     do(mod = lm(Petal.Length~Petal.Width, data = .)) %>%
     mutate(x = llply(mod, function(x) coef(x)[1])) %>% # or use broom
     unnest(x)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "%>%"
{% endhighlight %}
     
nonstandard evaluation:

{% highlight r %}
("1 == 2") %>% parse(text = .) %>% eval
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "%>%"
{% endhighlight %}

* as.character(substitute(list(…))[-1]) # removes the list argument
* substitute(): generates an expression from input
* deparse(): takes an expression & generate a string
* quote(): like substitute, but always return input as is
* eval(): takes expression and evaluates it, 2nd arg is the environment

* eval(quote(x), list(x = 30))
* eval(expr, environment, enclose)
  * to obtain from list or df, environment = name of df
  * to make sure it doesn’t scope outside, do enclose = parent.frame()

* expression: object that represents an action
* expression(): returns a list of expressions
* get(): works by eval(deparse(text = ))



{% highlight r %}
library(ggplot2)

f <- function(data, x, y) {

  varx <- substitute(x)
  vary <- substitute(y)

  x1 <- eval(varx, data)
  y1 <- eval(vary, data)


  # ggplot(data = data, aes(x = x1, y = y1))

  p <- qplot(x = data[,x1], y = data[,y1], geom = "point")
  return(p)

  # return(list(data[,x1], data[,y1]))

}

f(data.table(iris), Petal.Length, Petal.Width)
{% endhighlight %}



{% highlight text %}
## Error in eval(varx, data): could not find function "data.table"
{% endhighlight %}


when called within a function the eval/subs won’t work
make another one that takes a quoted expr (suffix _q for convention)
