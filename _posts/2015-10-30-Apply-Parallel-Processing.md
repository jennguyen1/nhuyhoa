---
layout: post
title: "Apply and Parallel Processing"
date: "October 30, 2015"
categories: R data_wrangling
---

* TOC
{:toc}



For loops in R are known to be quite slow as the number of iterations increase. Thus it is advised to use apply functions for looping operations. In cases when it is desirable to optimize code even more, parallel processing can be used alongside the apply functions.

# Basic Setup - For Loop Replacement
Lapply is a desireable replacement of for-loops when each iteration is independent of the others. 

Recall the basic setup of the for loop: 
{% highlight r%}
for (LOOP_VAR in SEQUENCE) {
  EXECUTION
  # more control
  break
  next
}
{% endhighlight%}

The setup is similar when using apply.
{% highlight r%}
lapply(SEQUENCE, function(i, ...){
  EXECUTION
  return(OBJ)
}, 
# additional arguments for the function
...)
{% endhighlight%}

Note that the keywords break and next cannot be used with lapply. In order to skip an iteration, enact a conditional statment and return an empty object. 

The output of an lapply is a list object. 

# plyr Functions
The package plyr has a number of apply functions to that allow for proper control of input and outputs types. 

Plyr functions have the form `__ply()`. 


|title      |list____ |data.frame_ |array |
|:----------|:--------|:-----------|:-----|
|list       |llply    |dlply       |alply |
|data.frame |ldply    |ddply       |adply |
|array      |laply    |daply       |aaply |
|empty      |l_ply    |d_ply       |a_ply |

<p></p>
The first character (`l`, `d`, `a`) denotes the format of the incoming object. The second character (`l`, `d`, `a`, `_`) denotes the format of the outcoming object. 

For example, `llply()` means take a list, apply a function on all elements of that list, and the results in a list. On the other hand, `ldply()` means take a list, apply a function on all elements of that list, and merge the results into a data frame.

The `_` refers to no output. This is useful for when the outputs are taken care of (saved or printed) within the loop, and you have no need for overall outputs.

In addition to providing control for input and output types, plyr functions have additional arguments for increased efficiency. 

* `.progress`: allows for the creation of a progress bar to inform users of the looping progress. Use `.progress = "time"` to get constant updates on how much longer code is expected to run
* `.parallel` and `.paropts`:  allows iterations to be run in parallel. Details on how to do this is provided in a later section.

## l*ply
The function `l*ply(.data, .fun, ...)` is probably the most general. It is identical to the `lapply()` function provided in the first section.

## d*ply
The function `d*ply()` are used with data frames. However, more recent packages provide better control and support for these tasks. See the post on [Split-Apply-Combine][sac_link]{:target="blank"} for more information.

## a*ply
The function `a*ply(.data, .margins, .fun, ...)` will apply a functions on the rows and/or columns of an array. The rows or columns can be specified using the `.margins`, pass 1 to split by rows, 2 to split by columns. 


{% highlight r %}
# generate random data
set.seed(1)
x <- raply(4, sample(1:4, 6, replace = TRUE))
x
{% endhighlight %}



{% highlight text %}
##      1 2 3 4 5 6
## [1,] 2 2 3 4 1 4
## [2,] 4 3 3 1 1 1
## [3,] 3 2 4 2 3 4
## [4,] 2 4 4 1 3 1
{% endhighlight %}



{% highlight r %}
# count the # of even values in each col
y <- alply(x, 2, function(x) sum(x %% 2 == 0))
y %>% unlist 
{% endhighlight %}



{% highlight text %}
## 1 2 3 4 5 6 
## 3 3 2 2 0 2
{% endhighlight %}
Here the first row is the column name, the second row is the count of even values

Note that data frames of one type are technically arrays too. So they can be passed as the .data argument to `a*ply()`.

## r*ply
The function `r*ply(.n, .expr, ...)` replicates an expression/function n times. This is great for running multiple iterations of random number generator.



{% highlight r %}
# 5 replicates of uniform random data of size 3
rdply(5, runif(3))
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> .n </th>
   <th style="text-align:center;"> V1 </th>
   <th style="text-align:center;"> V2 </th>
   <th style="text-align:center;"> V3 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0.2672207 </td>
   <td style="text-align:center;"> 0.3861141 </td>
   <td style="text-align:center;"> 0.0133903 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0.3823880 </td>
   <td style="text-align:center;"> 0.8696908 </td>
   <td style="text-align:center;"> 0.3403490 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0.4820801 </td>
   <td style="text-align:center;"> 0.5995658 </td>
   <td style="text-align:center;"> 0.4935413 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0.1862176 </td>
   <td style="text-align:center;"> 0.8273733 </td>
   <td style="text-align:center;"> 0.6684667 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0.7942399 </td>
   <td style="text-align:center;"> 0.1079436 </td>
   <td style="text-align:center;"> 0.7237109 </td>
  </tr>
</tbody>
</table>
</div>

# Foreach Functions
Under Construction :)

# Parallel Processing
Parallel processing allows independent tasks to be dispatched to different cores. These cores compute them in parallel and combine the results. Running tasks in parallel can reduce the runtime in half or more! Parallel processing is only recommended for time-consuming tasks. With shorter tasks, it may take more time to set up the cores than to run the analysis iteratively!

Here's the general setup:
{% highlight r %}
# load library
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

Note that this is one of many ways to run parallel processing. 

# Cool Uses of Apply

Say we have a number of files that we want to open. Rather than reading them in one by one, we could use an apply loop.

{% highlight r %}
# given a directory
directory <- "~/Desktop/file_monster/"

# get a list of all the files in the directory
file_paths <- list.files(directory)

# we only want to open the csv files
file_paths <- file_paths %>% str_subset(".csv")

# open all of our csv files using data.table::fread
files <- llply(file_paths, data.table::fread, .progress = "time")

# if all the files are of the same format, combine them into one file
super_set <- rbindlist(files)
{% endhighlight %}

And there you have it, all the files you need in one compact list. The great thing about llply is that you aren't restricted to simple functions. So instead of just reading in the file, you could do even more data processing to fit your needs. The sky's the limit!


- extract


[sac_link]: http://jnguyen92.github.io/nhuyhoa//2015/10/Split_Apply-Combine.html
