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
| `[f(x) for x in mylist if condition]` | 
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


**Decorators**

Decorators are functions that takes another function, and extends the behavior without modifying it.

{% highlight python %}
from functools import wraps

# make a decorator function
def my_decorator(some_function):
  @wraps(some_function)
  def wrapper(*args, **kwargs):
    do_something_before()
    out = some_function(*args, **kwargs) # my original function
    do_something_after()
    return out
  return wrapper
  
  
# apply my decorator
@my_decorator
def f_original():
  print("hi")
  return 5
{% endhighlight %}

Decorators can also be written to take arguments.

{% highlight python %}
# decorator can take in functions, just wrap another function around it
def overhead(decorator_args):
  def my_decorator(some_function):
    @wraps(some_function)
    def wrapper(*args, **kwargs):
      do_something_before(decorator_args)
      out = some_function(*args, **kwargs) # my original function
      do_something_after(decorator_args)
      return out
    return wrapper
  return my_decorator
  

# apply my decorator
@overhead(arg1)
def f_original():
  print("hi")
  return 5
{% endhighlight %}


It can also be declared as a class. This can be used if you want to maintain some sort of state.

{% highlight python %}
# class version w/o arguments
class my_decorator(object):

  def __init__(self, some_function):
    self.__f = some_function
    self.__tracker = 0
    
  def __call__(self, *args, **kwargs):
    do_something_before()
    out = self.__f(*args, **kwargs)
    do_something_after()
    return out
  
@my_decorator
def f_original():
  print("hi")
  return 5
  
# class version with arguments
class overhead(object):
  
  def __init__(self, decorator_args):
    # DO STUFF
    self.__tracker = 0
    
  def __call__(self, func, *args, **kwargs):
    def wrapper(*args, **kwargs):
      do_something_before()
      out = func(*args, *kwargs)
      do_something_after()
      return out
    return wrapper
    

@overhead(arg1)
def f_original():
  print("hi")
  return 5    
{% endhighlight %}

Here are some useful decorators:

* Time how long a function takes to execute
* Memoization (storing cached results)
* Dump arguments passed into function before calling
* Force conditions on inputs/outputs of function
* Count function calls
* Deprecation warnings

Check out this [page][decorator_link]{:target = "_blank"} for implementations of some common decorators.

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
isinstance(myinstane, myClass)
{% endhighlight %}

Classes can inherit from other classes like so
{% highlight python %}
class myClass2(baseClass):
  
  def __init__(self):
    super(baseClass, self).__init__()
    
  # SPECIALIZED STUFF
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

There are a number of decorator functions for classes to extend its methods

* `classmethod` shared among all instances, called with the class 1st arg
* `staticmethod` called without a class or instance reference
* property
* `property` a getter that also turns the method into a read only atribute with the same name, can be accessed as `instance.propname`
* `[property].setter` and `[property].deleter` methods to set and delete a property, the *[property]* value is just the name of the method from `property`


**Generators**

Generators are memory efficienct because they generate values rather than iterating through a list saved in memory. Generators returns values with the `yield` statement (usually placed within a `while` loop) and remembers the current state so that it can resume where it left off. A `StopIteration` exception is raised at the end of the generator's definition. To create a generator for the class

* `def __iter__(self)` initializes sequence to be iterated through; if `__next__()` exists, just returns `self`
* `def __next__(self)` to get the next value from a generator, with a `yield` statement
* `def __reversed__(self)` to create an iterator in reverse order


**Context Managers**

Context managers manage resources. They are used in place of `try` and `finally` statements. To create context managers for the class (implemented with `with ... as` statements)

* `def __enter__(self)` set up and returns object
* `def __exit__(self)` cleanup executed upon close, regardless of what happens; returns nothing

There is a standard library devoted to context managers called `contexlib`. It can turn a function into a context manager with a few simple steps. Everything before `yield` is considered the code for `__enter__()` and everything after is the code for `__exit__()`.

{% highlight python %}
from contexlib import contextmanager

@contextmanager
def open_file(path. mode)
  f = open(path, mode)
  yield f
  f.close()
{% endhighlight %}

[class_operators]: https://docs.python.org/3.5/library/operator.html
[decorator_link]:https://wiki.python.org/moin/PythonDecoratorLibrary
