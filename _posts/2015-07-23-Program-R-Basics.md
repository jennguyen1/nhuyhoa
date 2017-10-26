---
layout: post
title: "R Basics"
date: "July 23, 2015"
categories: ['basics']
---

* TOC
{:toc}


# Data Frames
Data frames are two-dimensional tables. The columns may be of dfferent types, but all columns must have the same length. 

A quick glance of data.frames can be obtained with `str()` or `summary()`. Other useful functions include `dim()`, `nrow()`, `ncol()`, `colnames()`.

There are many extensions of data frames such as `tibble`, `data.table`, and `AnnotatedDataFrame`.

It often helps to be able to extract information from and manipulate dataframes. The best packages for this includes `dplyr` and `tidyr` which have functions for extraction, manipulation, summarising, combining, and reformatting. 

The following cheatsheets detail many useful functions for working with data frames. 

* [Data Transformation][dplyr]{:target = "_blank"}
* [Data Import][tidyr]{:target = "_blank"}

# Lists
R lists are a collection of objects. They are indexed by number `l[[1]]` or by name `l$a` `l[['a']]`. 

**Uses of Lists**

* Organization of similar objects
* Return multiple objects from functions
* Parallel looping 

**Purrr**

The library `purrr` simplifies the apply functions. 

The function `map()` takes a list/vector, applies a function and returns a list. There are alternatives that specifies the return object, such as `map_lgl()`, `map_int()`, `map_dbl()`, `map_chr()`, `map_df()`, etc. Functions can be listed using `function()` or as a formula. 


{% highlight r %}
map(list, function, ...)
{% endhighlight %}
There are also multivariate options, such as `map2()`, `pmap()`. These options also have alternative that specifies the return object.


{% highlight r %}
map2(1:3, 3:1, ~ .x * .y)
pmap(list(4:6, 1:3, 10:8, 7:9), c)
{% endhighlight %}
Functions can be specified as a formula that starts with `~`, the variables `.x` and `.y` refers to the first and second incoming argument. 

The map functions also provides filtering options with `map_if()` and `map_at()`.


{% highlight r %}
map_if(list, condition, function)
map_at(list, locations, function)
{% endhighlight %}
The package also allows for applying a list of functions to an object. To do this use the functions `invoke()`, `invoke_map()`, etc.


{% highlight r %}
invoke_map(list(runif, rnorm), list(n = 10))
{% endhighlight %}
There are also functions that can be used to filter a vector: `keep()` and `discard()`.


{% highlight r %}
keep(1:10, ~ . %% 2 == 0)
discard(1:10, ~ . %% 2 == 0)
{% endhighlight %}

The package has a number of good functions for working in R, including

* `reduce()` and `reduce_right()` iteratively applies a binary function to list elements
* `accumulate()` and `accumulate_right()` does the same as the above functions but keeps intermediary results
* `transpose()` which restructures a list similar to `jn.general::extract_list()` 
* `safely()`, `quietly()`, and `possibly()` for working with errors

# Timing Code

## Profiling Code
A single source file be timed to determine which step is the "bottleneck". By profiling a script, R will record the step it is currently working on every 0.02 seconds. This will give an indication of which step is taking the longest, so that efforts can be taken to make the step more efficient.

To profile a slow $$myScript.R$$:

* add `Rprof(filename = "Rprof.out", line.profiling = TRUE)` to $$myScript.R$$ to turn on profiling
* add `Rprof(NULL)` to $$myScript.R$$ to turn profiling off
* run `summaryRprof(filename = "Rprof.out", lines = "show")` on the profiling output

## Comparing Run Times
To compare the runtimes of several functions, use the function `microbenchmark::microbenchmark()`. This function will run each code fragment a specified number of times (default is 100x) and return the summary statistics of the runtimes. Time distributions of each code fragment may also be plotted and analyzed.

# Speeding Up Code with Parallel Programming
See the [parallel processing post][parallel_processing_post]{: target = "_blank"}.



[dplyr]: https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/data-transformation-cheatsheet.pdf
[tidyr]: https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/data-import-cheatsheet.pdf
[parallel_processing_post]: http://jennguyen1.github.io/nhuyhoa//2017/03/Parallel-Processing.html#in-r



