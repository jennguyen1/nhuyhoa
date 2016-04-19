---
layout: post
title: "Python Basics"
date: "March 15, 2016"
categories: ['basics']
---

* TOC
{:toc}



# Data Structures

Python allows simultaneous declarations, so one can do `a = b = c = 0`. 

To check the type of an object use the following functions

* `type(obj)`
* `isinstance(OBJ, type)`

## Math Types

Python has a number of basic types: int, long, float, bool, str. 

Operations in are defined by type (`int / int = int`), therefore one needs to be careful to cast values into the right type for for the operation (`int / float(int) = float`).

Python has basic operations such `+-/*/%` as well as `in`.

Incrementing a value is quick with `x += n`.

To do more advanced math operations, use the `math` or `random` module
{% highlight python %}
from math import *
from random import *
{% endhighlight %}

These modules provide functions such as `math.abs()` `math.exp()`, `math.pow()`, `math.ceil()`, `random.random()`, `random.uniform(a, b)`, etc.

## String Types

* Sliced, `s[i:j]`, where the indices may be negative or positive. 
* Concatenated with `+`
* Repeated with `*`
* Converted to list `list(s)`
* Converted to number `ord(char)` and vice versa `chr(number)`

For more information on string functions see [the post on regular expressions][regex_post]{:target = "_blank"}.

For printing, strings may be formatted: `"%s is %d years old" % (name, age)`. The following are examples of formats

* string: `%s`
* integers: `%d`
* floating point numbers: `%<nchar>.<ndecimals>f`

## Lists

Lists are a very common data structure. They can be nested within each other to obtain arrays. 

Lists can be declared like so
{% highlight python %}
[..., ..., ...]
range(i, j) # generates a sequence from i to j-1; if i omitted from 0 to j-1
{% endhighlight %}

Objects in Python on indexed starting from 0, for example `l[0:4]`. To obtain elements from a nested list, do multiple indexes, `l[i][j]`.

The following are methods that can be used with lists (for example `l`)

Function | Description
---------|--------------
`l.append(obj)` | add object to last index
`l.insert(index, obj)` | add object to specified index
`l.pop(index)` | remove specified index, default is last index
`list.index(obj)` | finds first index of obj
`l.remove(obj)` | removes object from list
`l.reverse()` | reverses the list
`list.count(obj)` | counts the occurances of obj
`max(l)`, `min(l)` | finds the min and max object
`l*n` | replicates list n times and concatenates
`l + l2` | concatenates 2 lists
`sorted(l)` | sorts list (has additional options)
`len(l)` | length of list

## Dictionaries

Dictionaries are hash tables. It has a key and value pair that makes it easier to "find" objects since they have unique keys. The keys of a dictionary should be unique.

Dictionaries can be declared like so
{% highlight python %}
{'KEY':VALUE, ...}
{% endhighlight %}

Dictionary values can be accessed like so
{% highlight python %}
d["KEY"]
d.has_key("KEY")
d.key()
d.values()
d.items() # returns (key, value tuples)
{% endhighlight %}

If both keys and values are unique, key/value pairs can be inverted using list comprehensions
{% highlight python %}
{val:key for key, val in d.items()}
{% endhighlight %}

## Tuples

Tuples are frozen lists, once created no modifications can be made.

Tuples can be declared like so
{% highlight python %}
(..., ...)
{% endhighlight %}

Values in tuples can be accessed the same way as lists. Tuples are very often used as returned objects in functions.

## Sets

Sets are lists with no duplicated entries.

Sets can be declared from a list like so
{% highlight python %}
set(l)
{% endhighlight %}

Sets operations include:

* `s.intersection(s2)`
* `s.difference(s2)`
* `s.union(s2)`
* `s.issubset(s2)`

## List Comprehension

List comprehensions provide an easy way for looping through a list. Think of it like a shortcut to looping. It provides options for looping through tuples as well.

{% highlight python %}
[EXPR for VAR1, VAR2 in l if EXPR]
{% endhighlight %}

A Python function similary to R's `lapply` is 
{% highlight python %}
map(FUNCTION, l)
{% endhighlight %}

A Python function similar to R's `Filter` is
{% highlight python %}
filter(FUNCTION, l)
{% endhighlight %}

A common function used with list comprehensions is `enumerate()` which can access the index and values of a list
{% highlight python %}
[EXPR for index, value in enumerate(l)]
{% endhighlight %}

## Collections Class

Collections provides alternatives to the base list structures.

Load the module like so
{% highlight python %}
from collections import *
{% endhighlight %}

A few functions include

* `namedtuple()`
* `Counter()` is a dictionary subclass for counting hashable objects
* `OrderedDict()` is a dictionary subclass that remembers the order entries were added

# Conditionals

**Format for if/else**
{% highlight python %}
if EXPR:
  # OPERATIONS
elif EXPR:
  # OPERATIONS
else:
  # OPERATIONS
{% endhighlight %}

# Loops

**For Loops**
{% highlight python %}
for i in SEQUENCE:
  # OPERATIONS
{% endhighlight %}

**While Loops**
{% highlight python %}
while EXPR:
  # OPERATIONS
{% endhighlight %}

**Control within Loops**

* Skip to next iteration: `continue`
* Exit loop: `break`

# Functions

{% highlight python %}
# declare function
def f(x = 1, PARAMS):
  # OPERATIONS
  return x, y
  
# call function
a, b = f(x = 4, ARGS)
{% endhighlight %}

{% highlight python %}
# anonymous functions (usually one liners)
lambda x,y: # OPERATIONS

# example
map(lambda x: str(x), [1,2,3])
{% endhighlight %}

# Classes: OOP

{% highlight python %}
# declare class
class myClass():

  # initiate the class; use "self" to refer to the object itself
  def __init__(self, x, y): 
    self.x = x # public variable
    self.__position = (x,y) # private variable

  # DECLARE CLASS METHDS
  
# create an instance of myClass
myobj = myClass(x, y)
myobj.method()
{% endhighlight %}

You can declare a variety of unique methods for functions and use as desired. There are also a number of pre-defined methods that would be useful to use

* `def __init__(self, ...)` to intialize the class
* `def __repr__(self)` to determine the string printed when the object is printed
* `def __getitem__(self, index)` to allow obtaining values by indexing `myobj[i]`
* `def __setitem__(self, index, value)` to allow setting values by indexing `myobj[index] = value`
* `def __getslice__(self, low, high)` to allow slicing `myobj[i:j]`
* `def __len__(self)` to obtain the length `len(myobj)`
* `def __contains__(self)` to test whether something is inside it
* `def __add__(self, other)` to allow adding `myobj + yourobj`
* other operations available [here][class_operators]{:target = "_blank"}

To create an iterator for the class

* `def __iter__(self)` to iterate through a sequence
* `def __next__(self)` to get the next value from an iterator
* `def __reversed__(self)` to create an iterator in reverse order

# IO

We can navigate through the file system like so
{% highlight python %}
import os
os.mkdir(PATH) # make a new directory
os.listdir(PATH) # obtain file names in directory
os.path.exists(PATH) # check if file exists
{% endhighlight %}

## Input

**From a File**
{% highlight python %}
# opens file and reads everything into a list of lines
f = open(FILENAME, 'r')
f.readlines()
f.close()
{% endhighlight %}

**User Input**
{% highlight python %}
raw_input("feed me") # takes in a string
input("feed me") # guesses the input type
{% endhighlight %}

**Command Line Arguments**
{% highlight python %}
import sys 

# obtain list of command line arguments
# 1st value is name of script, the rest are arguments
sys.argv
{% endhighlight %}

## Output

{% highlight python %}
# open file and writes strings to it
f = open(FILENAME, 'w') # write to a new file
f = open(FILENAME, 'a') # append to a file
f.write(STR)
f.close()
{% endhighlight %}

# Useful Modules

* Create iterators: [Itertools][itertools_link]{:target = "_blank"}
* Data analysis: [Pandas][pandas_link]{:target = "_blank"}
* Statistical models: [Scikit Learn][scikitlearn_link]{:target = "_blank"}

## Numpy 

The module `numpy` provides additional functionality for arrays.

First, import the module like so
{% highlight python %}
import numpy as np
{% endhighlight %}

The following commands can be used to declare arrays.

Function | Description
---------|---------------
`np.array(list, dtype)` | declare array from list of lists, floats, int
`np.arrange(start, stop, by, dtype)` | array version of `range()`
`np.linspace(start, stop, n)` | creates a range from start to stop of length n
`np.identity(n)` | square identity matrix
`np.ones()`, `np.zeros()` | creates array of all 0/1, pass in dimensions `(r, c)`
`np.ones_like(a)`, `np.zeros_link(a)` | makes array of all 0/1 that looks like `a`
`np.concatenate()` | binds arrays together

<br>
The following commands can be run on instances of arrays.

Function | Description
---------|-------------
`arr.shape` | array dimensions
`arr.reshape((r, c))` | reshape array to new dimensions
`arr.flatten()` | makes array 1D
`arr.transpose()` | tranposes array
`arr.as_type()` | converts type
`arr.fill()` | fills an array with specified value
`arr.tolist()` | converts array to list
`arr.sort()` | sorts an array

<br>
Numpy arrays are similar to vectors in R. You can apply element-wise functions onto each element of the array. Examples of these include `+-*/><`, `np.abs()`, `np.square()`, `np.log()`, etc. Several functions of note include

Function | Description 
---------|------------
`np.unique()` | finds unique values of array
`np.where()` | elementwise if/else (similar to R `ifelse()`)
`np.vectorize(f)` | vectorizes a function (similar to R `Vectorize()`)

<br>
Additional math problems include `arr.sum()`, `arr.mean()`, `arr.var()`, `arr.std()`, `arr.min()`, `arr.argmin()`, `arr.any()`, `arr.all()`. More advanced math problems include `np.dot()`, `np.inner()`, `np.outer()`, `np.cross()`, `np.linalg.det()`, `np.linalg.eig()`, `np.linalg.inv()`, `np.linag.svd()`.

There are also options for random simulation.

Function | Description
---------|-------------
`np.random.seed()` | set a seed
`np.random.rand()` | generate array of random numbers
`np.random.random()` | draws random numbers [0.0, 1.0)
`np.random.randint(min, max, size)` | draws random integers
`np.random.<dist_name>(params, size)` | generate random numbers from various distributions
`np.random.normal(mu, sigma, size)` | generate random numbers from normal distributions
`np.random.shuffle()` | randomly shuffle order of items in list
`np.random.choice(a, size, replace, p)` | randomly sample from given array

## Scipy Stats

The module `scipy.stats` gives you access to probability distributions. 

Import the model like so
{% highlight python %}
import scipy.stats as ss
{% endhighlight %}

See the [scipy manual][scipy_link]{:target = "_blank"} for the list of available distributions.

Intiate an instance of a distribution by doing 
{% highlight python %}
x = ss.norm(loc = 0, scale = 1)
{% endhighlight %}

Obtain values from the distribution using the following functions
{% highlight python %}
# generate random variables; R's rnorm()
x.rv(n)

# the y value of function, for discrete P(X = x); R's dnorm()
x.pdf(q)
y.pmf(q)

# a | a = P(X <= x); R's pnorm()
x.cdf(q)

# x | a = P(X <= x); R's qnorm()
x.ppf(p)
{% endhighlight %}

The module also has functions for moments, expectations, and MLE.

[regex_post]: http://jnguyen92.github.io/nhuyhoa//2015/07/Regular-Expressions.html
[class_operators]: https://docs.python.org/2/library/operator.html
[itertools_link]: https://docs.python.org/2/library/itertools.html
[scipy_link]: http://docs.scipy.org/doc/scipy/reference/stats.html
[pandas_link]: http://pandas.pydata.org/
[scikitlearn_link]: http://scikit-learn.org/stable/
