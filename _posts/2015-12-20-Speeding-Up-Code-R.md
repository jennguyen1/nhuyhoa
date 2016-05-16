---
layout: post
title: "Speeding Up Code (R)"
date: "December 20, 2015"
categories: ['r programming']
---

* TOC
{:toc}



In some cases we may want/need to speed up code. There are a variety of ways to do this.

# Timing Code

## Profiling Code
A single source file be timed to determine which step is the "bottleneck". By profiling a script, R will record the step it is currently working on every 0.02 seconds. This will give an indication of which step is taking the longest, so that one can focus on making that step more efficient.

To profile a slow $$myScript.R$$:

* add `Rprof(filename = "Rprof.out", line.profiling = TRUE)` to $$myScript.R$$ to turn on profiling
* add `Rprof(NULL)` to $$myScript.R$$ to turn profiling off
* run `summaryRprof(filename = "Rprof.out", lines = "show")` on the profiling output

## Comparing Run Times
To compare the runtimes of several functions, use the function `microbenchmark::microbenchmark()`. This function will run each code fragment a specified number of times (default is 100x) and return the summary statistics of the runtimes. Time distributions of each code fragment may also be plotted and analyzed.

# Speeding Up Code with Parallel Programming
See the [parallel processing post][parallel_processing_post]{: target = "_blank"}.

[parallel_processing_post]: http://jnguyen92.github.io/nhuyhoa//2015/10/Apply-Parallel-Processing.html#parallel-processing
