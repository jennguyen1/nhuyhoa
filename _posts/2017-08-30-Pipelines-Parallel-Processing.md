---
layout: post
title: "Parallel Processing"
date: "August 30, 2017"
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

The function `mclapply()` copies the current environemnt into each worker environment and can be run from Linux/Mac. The function `parLapply()` requires you to tell the cluster what to load from the current environment and can be run from Linux/Mac/Windows. 

It is important to note that if you are saving big objects in memory, `mclapply()` worker environments will multiply this by copying the object into their environment. Take care to either actively remove objects with `rm()` and clear memory with `gc()`, or just use `parLapply()`


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

# generate clusters, with closes pool automatically
with mp.Pool(processes = n) as pool:

  # option 1: lock main program until all processes are finished; map = 1 arg, starmap = multiple args
  pool.map(f, range(1,7))
  pool.starmap(f2, zip(range(1, 7), range(1,7)))
  pool.starmap(f2, zip(range(1,7), repeat(10)))

  # option 2: submits all processes at once and retrieve   results as they finish
  results = pool.map_async(f, range(1,7))
  results = pool.starmap(f2, zip(range(1, 7), range(1,7)))
  results = pool.starmap(f2, zip(range(1,7), repeat(10)))
  # DO OTHER STUFF
  results.wait() # block program starting here
  output = results.get()

# if do not use with statement, then required to close the pool
pool.close()
pool.join()
{% endhighlight %}

