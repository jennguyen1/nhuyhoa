---
layout: post
title: "Pipelining Basics"
date: "August 08, 2017"
categories: ['pipelines']
---

* TOC
{:toc}


# Conditions

R | Python | Bash
--------|--------|--------
`if(){}` | `if :` | `if ; then`
`else if(){}` | `elif :` | `elif ; then`
`else{}` | `else:` | `else`
 | | `fi`
..............................................|..............................................|..............................................
 `ifelse()` | `filter()` |
 `dplyr::case_when()` | 
 `dplyr::recode()` | 
 `plyr::mapvalues()` | 
 `purrr::keep()` | 
 `purrr::discard()` |

# Looping

R | Python | Bash
--------|--------|--------
`for( in ){}` | `for in :` | `for in`
| | `do`
| | `done`
| | |
`while(){}` | `while :` | `while [ ]`
| | `do`
| | `done`
| `[f(x) for x in mylist]` | 
..............................................|..............................................|..............................................
`purrr::map()` | `map(), starmap()` | 
`purrr::pmap()` | `zip(), zip(*l)`
`rep()` | `itertools.repeat()` |
| `enumerate()` |

# Functions

R | Python | Bash
--------|--------|--------
`f <- function(p, ...){` | `def f(p, \*\*kwargs):` | `function f{`
..`list(...)` | ..`kwargs['a']` | ..`echo $1`
..`f2(p, ...)` | ..`f2(kwargs['a'], kwargs['b'])` | 
..`return(list(x,y))` | ..`return x,y` | ..`return x`
`}` | | `}`
| `lambda x,y:` |
..............................................|..............................................|..............................................
`f(a)` | `f(a)` | `f a`
`f(a, b = 1, c = 2)` | `f(a, b = 1)` |
..............................................|..............................................|..............................................
`Vectorize()` | `functools.partial()` | 
| `functools.partialmethod()` |
| `functools.wrap()` | 



**Python**

Python has parameter options for positional args `*args` and keyword args `**kwargs`. Positional args are not named, keyword args are named. It may be used in both defining and calling the function.

{% highlight python %}
def test_args(a, *args):
  print(a)
  for arg in args:
    print(arg)
    
def test_kwargs(a, **kwargs):
  print(a)
  for k in kwargs:
    print("{}: {}".format(k, kwargs[k]))
    
def test_args(a1, a2, a3):
  print([a1, a2, a3])
  
args = ("hi", "me", "!")
test_args(*args)
kwargs = {'a1':"hi", 'a2':"me", 'a3':"!"}
test_args(**kwargs)
{% endhighlight %}

# Classes and Modules

Python can split up code into separate files.

{% highlight python %}
# save a file called Pack.py

# load files with an import statement
import Pack
{% endhighlight %}

{% highlight python %}
class myClass:
  
  # class variables
  class_var = 0
  
  # initiate the class; use "self" to refer to the object itself
  def __init__(self, x, y): 
  self.x = x # public variable
  self.__position = (x,y) # private variable

  # DECLARE CLASS METHODS OR SUB-CLASSES

# create an instance of myClass
myinstance = myClass(x, y)
myinstance.method()
{% endhighlight %}

Classes can inherit from other classes like so
{% highlight python %}
class myClass2(baseClass):
  # STUFF
{% endhighlight %}

Classes have a set of unique methods and functions. There are also a number of pre-defined methods that would be useful to use

* `def __init__(self, ...)` to intialize the class
* `def __repr__(self)` to determine the string printed when the object is printed
* `def __getitem__(self, index)` to allow obtaining values by indexing `myobj[i]`
* `def __setitem__(self, index, value)` to allow setting values by indexing `myobj[index] = value`
* `def __getslice__(self, low, high)` to allow slicing `myobj[i:j]`
* `def __len__(self)` to obtain the length `len(myobj)`
* `def __contains__(self)` to test whether something is inside it
* `def __add__(self, other)` to allow adding `myobj + yourobj`
* other operations available on the [Python manual][class_operators]{:target = "_blank"}

To create an iterator for the class

* `def __iter__(self)` to iterate through a sequence
* `def __next__(self)` to get the next value from an iterator; if a class defines `__next__()` then `__iter__()` can just return `self`
* `def __reversed__(self)` to create an iterator in reverse order

[class_operators]: https://docs.python.org/3.5/library/operator.html

