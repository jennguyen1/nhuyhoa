---
layout: post
title: "Exception Handling"
date: "December 21, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}



# In R

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
## NULL
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
