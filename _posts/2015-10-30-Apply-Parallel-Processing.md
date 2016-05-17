---
layout: post
title: "Apply and Parallel Processing (R)"
date: "October 30, 2015"
categories: ['r programming']
---

* TOC
{:toc}




For loops in R are can be quite slow as the number of iterations increase. Apply functions or parallel processing are recommended to optimize code for looping operations. 

# Apply as a For Loop Replacement
Lapply can replace for-loops when each iteration is independent of the others. 

Recall the basic setup of the for loop: 
{% highlight r%}
for (LOOP_VAR in SEQUENCE) {
  EXECUTION
  # more control
  break
  next
}
{% endhighlight%}

The setup is similar when using lapply.
{% highlight r%}
lapply(SEQUENCE, function(i, ...){
  EXECUTION
  return(OBJ)
}, 
# additional arguments for the function
...)
{% endhighlight%}

Note that the keywords break and next cannot be used with `lapply()`. In order to skip an iteration, implement a conditional statment and return an empty object. 

The output of an `lapply()` is a list object. 

![lapply diagram](http://jnguyen92.github.io/nhuyhoa/figure/images/lapply_diagram.png)

# plyr Functions
The package plyr has a number of apply functions to that allow for proper control of input and outputs types. 

Plyr functions have the form `__ply()`. 


|input\output |list  |data.frame |array |empty |
|:------------|:-----|:----------|:-----|:-----|
|list         |llply |ldply      |laply |l_ply |
|data.frame   |dlply |ddply      |daply |d_ply |
|array        |alply |adply      |aaply |a_ply |

<p></p>
The first character (`l`, `d`, `a`) denotes the format of the incoming object. The second character (`l`, `d`, `a`, `_`) denotes the format of the outcoming object. 

For example, `llply()` takes in a list, applies a function on all elements of that list, and returns the results in a list. On the other hand, `ldply()` takes in a list, applies a function on all elements of that list, and merges the results into a data frame.

The `_` refers to no output. This is useful for when the outputs are taken care of (saved or printed) within the loop, and there is no need for other output.

In addition to providing control for input and output types, plyr functions have additional arguments for increased efficiency. 

* `.progress`: allows for the creation of a progress bar to inform users of the looping progress. Use `.progress = "time"` to get constant updates on how much longer code is expected to run
* `.parallel` and `.paropts`:  allows iterations to be run in parallel. Details on how to do this is provided in a later section.

## l*ply
The function `l*ply(.data, .fun, ...)` is probably the most general. It is identical to the `lapply()` function.

## d*ply
The function `d*ply()` are used with data frames. However, other packages provide better control and support for these tasks. See the post on [Split-Apply-Combine][sac_link]{:target="blank"} for more information.

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

Note that data frames of one type are technically arrays too. So they can be passed as the `.data` argument to `a*ply()`.

## r*ply
The function `r*ply(.n, .expr, ...)` replicates an expression/function n times. This is useful for running multiple iterations of random number generator.



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

# Multivariate Apply
`Map` can simultaneously loop over several vectors at once. 

For example, it can be used to compute multiple weighted means of two different data sets. Here, one set of weights  is applied to two different data sets. 

{% highlight r %}
# list of obs and weights
obs <- replicate(5, runif(10), simplify = FALSE)
weights <- replicate(5, rpois(10, 5) + 1, simplify = FALSE)

# multivariate apply
Map(function(x, w) weighted.mean(x, w, na.rm = TRUE), obs, weights) 
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] 0.5849222
## 
## [[2]]
## [1] 0.433252
## 
## [[3]]
## [1] 0.495873
## 
## [[4]]
## [1] 0.5998531
## 
## [[5]]
## [1] 0.4728041
{% endhighlight %}

# Parallel Processing
Parallel processing allows independent tasks to be dispatched to different cores. These cores compute them in parallel and combine the results. Running tasks in parallel can reduce the runtime by half or more. 

However, parallel processing is only recommended for time-consuming tasks. With shorter tasks, it may take more time to set up the cores than to run the analysis iteratively.

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

## Example 1
Rather than opening a large number of files one by one, an apply loop can be used to open all the files at once.

{% highlight r %}
# given a directory
directory <- "~/Desktop/file_monster/"

# get a list of all the files in the directory
file_paths <- list.files(directory, full.names = TRUE)

# we only want to open the csv files
file_paths <- file_paths %>% str_subset(".csv")

# open all of our csv files using data.table::fread
files <- llply(file_paths, data.table::fread, .progress = "time")

# if all the files are of the same format, combine them into one file
super_set <- rbindlist(files)
{% endhighlight %}

The object `super_set` will have all the specified files in one compact list. The advantage of the apply functions is that it isn't restricted to simple functions. So if there are additional data pre-processing steps, user-defined functions can also be used with the apply functions.

## Example 2

Imagine a work flow where independent models are constructed with different parameters. The goal is to group common data outputs from each of those models for a more simplified analysis. For example, multiple models can be compared by gathering all diagnostics into one data.frame. An easy way to do this is with the function `jn.general::extract_list()`, which uses a recursive apply/looping function to accumulate the data structures. 

Here's an example of when `jn.general::extract_list()` would come in handy.

{% highlight r %}
# function to generate some random data
random_data <- function(){
  x <- list(
    temp = list(
      hot = list(red = data.frame(i = sample(c("M", "T", "W", "Th", "F"), 3)), 
                 orange = data.frame(j = sample(month.name, 2))),
      cold = data.frame(x = runif(7, 0, 25), y = sample(state.name, 7))
    ),
    CA = matrix(sample(-10:9, 16), nrow = 4),
    WA = sample(LETTERS, 5)
  )
  return(x)
}

# look at our outputs
output <- llply(1:3, function(i) random_data())
output[[1]]
{% endhighlight %}



{% highlight text %}
## $temp
## $temp$hot
## $temp$hot$red
##   i
## 1 W
## 2 F
## 3 T
## 
## $temp$hot$orange
##          j
## 1    March
## 2 December
## 
## 
## $temp$cold
##           x           y
## 1 18.232741      Nevada
## 2 11.314271    Kentucky
## 3  4.378169    Michigan
## 4 18.667457 Mississippi
## 5  2.624691     Florida
## 6 21.613624  Washington
## 7 15.366124    Arkansas
## 
## 
## $CA
##      [,1] [,2] [,3] [,4]
## [1,]   -5   -3  -10    3
## [2,]   -6    1   -7   -1
## [3,]    9    2    6   -4
## [4,]    5    7    0   -9
## 
## $WA
## [1] "J" "W" "P" "R" "N"
{% endhighlight %}



{% highlight r %}
output[[2]]
{% endhighlight %}



{% highlight text %}
## $temp
## $temp$hot
## $temp$hot$red
##   i
## 1 F
## 2 T
## 3 M
## 
## $temp$hot$orange
##          j
## 1 November
## 2     June
## 
## 
## $temp$cold
##           x          y
## 1 21.926439   Maryland
## 2  4.729841 California
## 3 18.952576    Vermont
## 4 18.112472    Indiana
## 5 23.593120     Nevada
## 6 13.691165  Wisconsin
## 7 17.793597     Oregon
## 
## 
## $CA
##      [,1] [,2] [,3] [,4]
## [1,]   -4   -2    2   -3
## [2,]    4    7   -9  -10
## [3,]   -6   -8    3    8
## [4,]   -7    9    1   -5
## 
## $WA
## [1] "V" "H" "P" "Z" "U"
{% endhighlight %}
And so on for the following iterations.

So this is the result of our model builds. It isn't very useful broken up into so many pieces, so let's use `jn.general::extract_list()` on our output. 

{% highlight r %}
# rename the data frames
renamed <- rename_list(output, names = paste0("m", 1:length(output)))
# extract data
extract <- extract_list(renamed)
extract
{% endhighlight %}



{% highlight text %}
## $temp
## $temp$hot
## $temp$hot$red
##    file_id i
## 1:      m1 W
## 2:      m1 F
## 3:      m1 T
## 4:      m2 F
## 5:      m2 T
## 6:      m2 M
## 7:      m3 T
## 8:      m3 F
## 9:      m3 M
## 
## $temp$hot$orange
##    file_id        j
## 1:      m1    March
## 2:      m1 December
## 3:      m2 November
## 4:      m2     June
## 5:      m3    April
## 6:      m3     June
## 
## 
## $temp$cold
##     file_id         x           y
##  1:      m1 18.232741      Nevada
##  2:      m1 11.314271    Kentucky
##  3:      m1  4.378169    Michigan
##  4:      m1 18.667457 Mississippi
##  5:      m1  2.624691     Florida
##  6:      m1 21.613624  Washington
##  7:      m1 15.366124    Arkansas
##  8:      m2 21.926439    Maryland
##  9:      m2  4.729841  California
## 10:      m2 18.952576     Vermont
## 11:      m2 18.112472     Indiana
## 12:      m2 23.593120      Nevada
## 13:      m2 13.691165   Wisconsin
## 14:      m2 17.793597      Oregon
## 15:      m3 23.099212 Connecticut
## 16:      m3 12.773992       Maine
## 17:      m3  6.440532  New Mexico
## 18:      m3  1.161522   Wisconsin
## 19:      m3 10.446406    New York
## 20:      m3 21.350038    Virginia
## 21:      m3  8.680767    Missouri
##     file_id         x           y
## 
## 
## $CA
## $CA[[1]]
##      [,1] [,2] [,3] [,4]
## [1,]   -5   -3  -10    3
## [2,]   -6    1   -7   -1
## [3,]    9    2    6   -4
## [4,]    5    7    0   -9
## 
## $CA[[2]]
##      [,1] [,2] [,3] [,4]
## [1,]   -4   -2    2   -3
## [2,]    4    7   -9  -10
## [3,]   -6   -8    3    8
## [4,]   -7    9    1   -5
## 
## $CA[[3]]
##      [,1] [,2] [,3] [,4]
## [1,]   -2    4    3   -4
## [2,]    9   -8   -9   -3
## [3,]   -5    7   -6    2
## [4,]   -1    5    8   -7
## 
## 
## $WA
## $WA[[1]]
## [1] "J" "W" "P" "R" "N"
## 
## $WA[[2]]
## [1] "V" "H" "P" "Z" "U"
## 
## $WA[[3]]
## [1] "M" "C" "F" "L" "I"
{% endhighlight %}

The function returns clean aggregated outputs, making analysis and comparison much more simple!

The separate files can be extracted quite simply with `$`. 

{% highlight r %}
# template for extraction
random_letters <- extract$WA
cold_states <- extract$temp$cold
{% endhighlight %}


[sac_link]: http://jnguyen92.github.io/nhuyhoa//2015/10/Split-Apply-Combine.html
