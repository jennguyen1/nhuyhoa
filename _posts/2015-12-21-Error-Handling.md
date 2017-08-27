---
layout: post
title: "Exception Handling"
date: "December 21, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}



# In R

## Purrr

The package `purrr` has 3 functions to deal with error handling. These functions are applied to other functions and can handle error output.

* `safely()` returns a list with 2 elements: result and error, one of which is always NULL
* `quietly()` returns a list with 4 elements: result, output, warnings, and messages
* `possibly()` replaces errors in 1 object with a default value


{% highlight r %}
map(list(1, 2, "hi"), safely(log))
{% endhighlight %}



{% highlight text %}
## [[1]]
## [[1]]$result
## [1] 0
## 
## [[1]]$error
## NULL
## 
## 
## [[2]]
## [[2]]$result
## [1] 0.6931472
## 
## [[2]]$error
## NULL
## 
## 
## [[3]]
## [[3]]$result
## NULL
## 
## [[3]]$error
## <simpleError in .f(...): non-numeric argument to mathematical function>
{% endhighlight %}



{% highlight r %}
map(list(1, 2, "hi"), quietly(log))
{% endhighlight %}



{% highlight text %}
## Error in .f(...): non-numeric argument to mathematical function
{% endhighlight %}



{% highlight r %}
map(list(1, 2, "hi"), possibly(log, NA_real_))
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] 0
## 
## [[2]]
## [1] 0.6931472
## 
## [[3]]
## [1] NA
{% endhighlight %}

## tryCatch
Similar to other languages `tryCatch()` can be used to deal with how error, warning, and messages are dealt with. 

{% highlight r %}
error_handling <- function(code){
  tryCatch(
    code, 
    error = function(e){"error"}, 
    warning = function(e){"warning"},  
    message = function(e){"message"}
  )
}

error_handling(stop("!"))
{% endhighlight %}



{% highlight text %}
## [1] "error"
{% endhighlight %}

## failwith
The function `failwith()` can control how errors within a function are dealt with. 

{% highlight r %}
# arbitrary function
f <- function(x) if( is.character(x) ) stop("There is an error")

# add the failwith option to the function
f2 <- failwith(default = NULL, f, quiet = TRUE)

# run option
f2("testing")
{% endhighlight %}



{% highlight text %}
## NULL
{% endhighlight %}

## try_default
The function `try_default()` can control how errors within an expression are dealt with. 

{% highlight r %}
try_default(expr = 3 + "a", default = NULL, quiet = FALSE)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "try_default"
{% endhighlight %}

# In Python

## Try Catch

{% highlight python %}
try:
  # OPERATIONS
except Exception:
  # OPERATIONS
else:
  # OPERATIONS
{% endhighlight %}

Possible excepions

* IOError
* IndexError
