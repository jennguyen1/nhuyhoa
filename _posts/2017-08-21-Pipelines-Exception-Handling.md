---
layout: post
title: "Exception Handling"
date: "August 21, 2017"
categories: Software
tags: Pipelines
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
  # RUNS IF NO EXCEPTIONS IN TRY
finally:
  # OPERATIONS
{% endhighlight %}

Possible excepions

* IOError
* IndexError

# Unit Testing

**R**

Unit tests in R can be done with the package `testthat`.

**Python**

{% highlight python %}
import unittest
import my_functions # import your own code

class TestName(unittest.TestCase):

  # setup any objects needed for testing
  def setUp(self):
    pass

  # any series of tests
  def test_name(self):
    self.assertBlah(my_functions.f(), ...)
    
  # cleanup any objects needed for testing
  def tearDown(self)
  
  
# call tests  
if __name__ == '__main__':
  unittest.main()
{% endhighlight %}

{% highlight bash %}
# run tests
python test_unittest.py -v
{% endhighlight %}


Here are a list of common assertions

* `assertEqual(a,b)`, `assertNotEqual()`
* `assertTrue(x)`, `assertFalse()`
* `assertIs(a,b)`, `assertIsNot()`
* `assertNone(x)`, `assertIsNotNone()`
* `assertIn(a,b)`, `assertNotIn()`
* `assertIsInstance(a,b)`, `assertNotIsInstance()`
* `assertAlmostEqual(a,b,places,delta)`, `assertNotAlmostEqual()`
* `assertGreater(a,b)`, `assertGreaterEqual()`
* `assertLess(a,b)`, `assertLessEqual()`
* `assertRegex(t,regexp)`, `assertNotRegex()`
* `assertCountEqual(a,b)`
* `assertListEqual(a,b)`, `assertTupleEqual()`, `assertSetEqual()`, `assertDictEqual()`
* `assertRaises()`, `assertRaisesRegex()`

These methods have a parameter `msg` in which you can provide additional messages upon fail.

It is a good idea to unit test modules and packages that you use repetitively. For one-off scripts (cleaning/transforming data, etc), unit testing is unecessary but you can sprinkle asserts throughout the code. 

# Debugging

**R**

When placed inside of a function, `browser()` will trigger a debugging session in interactive mode. 


