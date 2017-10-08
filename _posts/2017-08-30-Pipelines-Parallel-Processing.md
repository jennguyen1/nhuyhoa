---
layout: post
title: "Parallel Processing"
date: "August 30, 2017"
categories: ['pipelines']
---

* TOC
{:toc}


There are a variety of ways to parallelize tasks. The following table has a summary of them. 

Processes | Threads | Synchronization
----------|---------|-----------------
independent sequences of execution | independent sequences of execution | presence of race conditions
separate memory spaces | shared memory space | file locks for processes
variables are copied when processes fork | globally accessible variables shared between threads | mutexes for threads 


# Parallelism via Processes

Parallel processing allows independent tasks to be dispatched to different processes. 

Running tasks in parallel can greatly reduce the runtime. Amdahl's law provides a way to estimate the best attainable performance gain when you convert code from serial to parallel execution. 

$$S(n) = \frac{1}{P/n + (1-P)}$$

where $$P$$ is the proportion of time that the task is strictly parallel, $$n$$ is the number of processes used for parallel execution, and $$S(n)$$ is the theoretical best possible speedup of the task. 

Parallel processing requires data transmission between the master and worker processes. Therefore it is only recommended for time-consuming tasks because unecessary transmission may take longer than running the task serially. 


**R**

For parallel processing in R, the `parallel`.

{% highlight r %}
# load library
library(parallel)

# total number of cpus available
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
  
# total number of cpus available
n = mp.cpu_count()

# generate clusters, with closes pool automatically
with mp.Pool(processes = n) as pool:

  # option 1: lock main program until all processes are finished; map = 1 arg, starmap = multiple args
  pool.map(f, range(1,7))
  pool.starmap(f2, zip(range(1, 7), range(1,7)))
  pool.starmap(f2, zip(range(1,7), repeat(10)))

  # option 2: does not lock main program, submit processes and do other stuff while waiting for them to finish
  results = pool.map_async(f, range(1,7))
  results = pool.starmap_async(f2, zip(range(1, 7), range(1,7)))
  results = pool.starmap_async(f2, zip(range(1,7), repeat(10)))
  # DO OTHER STUFF
  results.wait() # block program starting here
  output = results.get()

# if do not use with statement, then required to close the pool
pool.close()
pool.join()
{% endhighlight %}


# Other Ways to Improve Performance 

When brainstorming ways to improve performance, you can look at a few things

* Reformalize code that has high CPU usage
* Reformalize code that has low free memory and high swap size (system running out of memory and swapping memory onto the disk)
* Reformalize code with high disk I/O

It is useful to profile your code to find where these bottlenecks may be occurring. 

The following are a few suggestions on how to relieve performance issues

* Using special data structures and packages
* Parallelize embarassingly parallel tasks 
* Remove intermediate data when no longer needed 
* Calculating values on the fly 
* Swapping active/inactive data 
* Scale horizontally (buy more CPU/RAM) or vertically (use more computers)

