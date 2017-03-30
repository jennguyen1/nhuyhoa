---
layout: post
title: "Parallel Processing"
date: "March 30, 2017"
categories: ['data wrangling']
---

* TOC
{:toc}

Parallel processing allows independent tasks to be dispatched to different cores. These cores compute them in parallel and combine the results. Running tasks in parallel can reduce the runtime by half or more. 

However, parallel processing is only recommended for time-consuming tasks. With shorter tasks, it may take more time to set up the cores than to run the analysis iteratively.

# In R

For parallel processing in R, the `plyr` and `doParallel` packages are needed.

{% highlight r %}
# load library
library(plyr)
library(doParallel)

# find out max # cores you can use
detectCores()

# generate clusters - n = # of clusters
cl <- makeCluster(n)
registerDoParallel(cl)

# use plyr to run in parallel
llply(.data, .fun, ...,
      .parallel = TRUE, 
      .paropts = list(.packages = c("dplyr", "magrittr"))
      )

# close clusters
stopCluster(cl)
{% endhighlight %}

Think of each core as its own separate "R session", in that it will only have information passed to it from the function. The cores will not have access to variables and packages that have been loaded in the current environment. Thus it is best to provide the function with all necessary objects (as parameters) and provide all necessary packages in the `.paropts` argument. 

Note that this is one of many ways to run parallel processing in R. 

# In Python

For parallel processing in Python, the `multiprocessing` package is needed.

{% highlight python %}
# load module
import multiprocessing as mp

# define function
def f(x):
  return x**3
  
# generate clusters - n = # of clusters
pool = mp.Pool(processes=n)

# option 1: lock main program until all processes are finished
results = pool.map(f, range(1,7))

# option 2: submits all processes at once and retrieve results as they finish
results = pool.map_async(f, range(1,7))
output = results.get()
{% endhighlight %}

