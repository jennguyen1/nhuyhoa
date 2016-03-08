---
layout: post
title: "R Cool Functions List"
date: "July 24, 2015"
categories: ['r programming']
---

* TOC
{:toc}



# Links

**General R**

* [R reference][r_ref]{:target = "_blank"}
* [dplyr cheatsheet][dplyr_ref]{:target = "_blank"}
* [data.table cheatsheet][data.table_ref]{:target = "_blank"}


**Graphics in R**

* [ggplot2 cheatsheet][ggplot2_ref]{:target = "_blank"}
* [GGally::ggpairs()][grid.arrange]{:target = "_blank"}
* RColorBrewer


{% highlight r %}
library(RColorBrewer)
display.brewer.all()
{% endhighlight %}

![plot of chunk unnamed-chunk-2](/nhuyhoa/figure/source/2015-07-24-R-cool-functions/unnamed-chunk-2-1.png)


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
ggmap::gglocator()
heatmaps with dendrograms 2x2


The `broom` package has three main functions that deal with a variety of modeling functions

* `tidy`: extracts the model estimates and p-values
* `glance`: extracts the model statistics ($$R^2$$, etc)
* `augment`: extracts the individual data point statistics (fitted values, residuals, leverages, etc)


data.tables:
with = FALSE: j is a vector of names or positions to select (similar to data frames)
rbindlist: massive rbind of lists of df
DT[, .SD[which.max(i)], by = j]: saves the row that corresponds to max i for each unique j


* assign
* na.omit
* complete.cases

* list of functions

* partial(f, ..): changes the deafults of functions
sf <- pryr::partial(sum, 1:5, na.rm = TRUE)
sf()



