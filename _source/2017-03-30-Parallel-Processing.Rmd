---
layout: post
title: "Parallel Processing"
date: "March 30, 2017"
categories: ['pipelines']
---

* TOC
{:toc}

Parallel processing allows independent tasks to be dispatched to different cores. These cores compute them in parallel and combine the results. Running tasks in parallel can reduce the runtime by half or more. Each core is a new environemnt, so it is required to export your current environment so that the worker cores have objects to work with.

However, parallel processing is only recommended for time-consuming tasks. With shorter tasks, it may take more time to set up the cores than to run the analysis iteratively. 

**R**

For parallel processing in R, the `parallel`.

{% highlight r %}
# load library
library(parallel)

# total number of cores
detectCores()

# run in parallel - for linux/mac
mclapply(list, function, mc.cores = n)
mcMap(f, x, y, mc.cores = n)

# run in parallel - for windows

# generate clusters - n = # of clusters
cl <- makeCluster(n)

# push functions/vars to clusters
clusterExport(cl = cl, varlist = c("function1", "var1"))

# use plyr to run in parallel
parLapply(cl = cl, X, fun)

# close clusters
stopCluster(cl)
{% endhighlight %}

The function `mclapply()` copies the current environemnt into each worker environment and can be run from Linux/Mac. The function `parLapply()` requires you to tell the cluster what to load and can be run from Linux/Mac/Windows. 

It is important to note that if you are saving big objects in memory, `mclapply()` worker environments will multiply this by copying the object into their environment. Take care to either actively remove objects with `rm()` and clear memory with `gc()`, or just use `parLapply()`


Another option is to use the `plyr` and `doParallel` packages.

{% highlight r %}
# load library
library(plyr)
library(doParallel)

# total number of cores
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

Note that these are two of many ways to run parallel processing in R. 

**Python**

For parallel processing in Python, the `multiprocessing` package is needed.

{% highlight python %}
# load module
from itertools import repeat
import multiprocessing as mp

# define function
def f(x):
  return x**3

def f2(x,y):
  return(x*y)
  
# total number of cores
n = mp.cpu_count()
  
# generate clusters
pool = mp.Pool(processes = n)

# option 1: lock main program until all processes are finished; map = 1 arg, startmap = multiple args
pool.map(f, range(1,7))
pool.starmap(f, zip(range(1, 7), range(1,7)))
pool.starmap(f, zip(range(1,7), repeat(10)))

# option 2: submits all processes at once and retrieve results as they finish
results = pool.map_async(f, range(1,7))
# DO OTHER STUFF
results.wait() # block program starting here
output = results.get()

# close 
pool.close()
pool.join()
{% endhighlight %}

