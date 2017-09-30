---
layout: post
title: "Exception Handling"
date: "August 21, 2017"
categories: ['pipelines']
---

* TOC
{:toc}



# Exception Handling 

**R**

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
## <simpleError in log(x = x, base = base): non-numeric argument to mathematical function>
{% endhighlight %}



{% highlight r %}
map(list(1, 2, "hi"), quietly(log))
{% endhighlight %}



{% highlight text %}
## Error in log(x = x, base = base): non-numeric argument to mathematical function
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


The function `dplyr::failwith()` can control how errors within a function are dealt with. 

{% highlight r %}
# arbitrary function
f <- function(x) if( is.character(x) ) stop("There is an error")

# add the failwith option to the function
f2 <- dplyr::failwith(default = NULL, f, quiet = TRUE)
{% endhighlight %}



{% highlight text %}
## Warning: Deprecated: please use `purrr::possibly()` instead
{% endhighlight %}



{% highlight r %}
# run option
f2("testing")
{% endhighlight %}



{% highlight text %}
## NULL
{% endhighlight %}

**Python**

Within functions, assertions can be used to detect errors. The syntax is below

{% highlight python %}
def f():
  assert condition, error_msg
{% endhighlight %}

Exceptions can be raised by doing this
{% highlight python %}
raise Exception("")
{% endhighlight %}

There are a variety of built in exceptions that you can use or you may write your own.

{% highlight python %}
class Error(Exception):
  def __init__(self, message, var2):
    self.message = message
    self.var2 = var2
{% endhighlight %}

Try/catch is also available in python.

{% highlight python %}
try:
  # OPERATIONS
except (Exception1, Exception2) as e:
  # SPECIFIED ERROR
except:
  # ALL OTHER ERRORS
else:
  # OPERATIONS
finally:
  # OPERATIONS
{% endhighlight %}

Possible excepions

* IOError
* IndexError

# Debugging

**R**
When placed inside of a function, `browser()` will trigger a debugging session in interactive mode. 


