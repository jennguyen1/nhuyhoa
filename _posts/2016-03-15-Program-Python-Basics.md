---
layout: post
title: "Python Basics"
date: "March 15, 2016"
categories: ['basics']
---

* TOC
{:toc}



# Data Structures

Python allows simultaneous declarations, so `a = b = c = 0` is possible. 

To check the type of an object use the following functions

* `type(obj)`
* `isinstance(obj, Class)`

## Math Types

Python has a number of basic types: int, long, float, bool, str. 

Operations in are defined by type (`int / int = int`), so take care to cast values into the right type for the operation (`int / float(int) = float`).

Python has basic operations such as `+-/*/%` and `in`.

Quickly increment with with `x += n`.

For more advanced math operations, use the `math` or `random` module
{% highlight python %}
from math import *
from random import *
{% endhighlight %}

These modules provide functions such as `math.abs()` `math.exp()`, `math.pow()`, `math.ceil()`, `random.random()`, `random.uniform(a, b)`, etc.

## String Types

* Slice with `s[i:j:k]`, where the indices may be negative or positive, takes values [i,j) by k
* Concatenate with `+`
* Repeat with `*`
* Convert to list `list(s)`
* Convert to number `ord(char)` and vice versa `chr(number)`

For more information on string functions see [the post on regular expressions][regex_post]{:target = "_blank"}.

For printing, strings may be formatted: `"{} is {} years old".format(name, age)`.

A number of variables may be concatenated to a template using a dictionary

{% highlight python %}
template = 'blah blah {apple} blah blah {banana} blah {orange}'

# using a dictionary
dt = {'apple': 'test1', 'banana': 'test2', 'orange': 'test3'}
template.format_map(dt)

# using variables (apple, banana, orange) in the local environment
template.format_map(locals())
template.format(**locals()) # unpack the dictionary
{% endhighlight %}

## Lists

Lists are a very common data structure. They can be nested within each other to obtain arrays. 

Lists can be declared like so
{% highlight python %}
[..., ..., ...]
range(i, j) # generates a sequence from i to j-1; if i omitted from 0 to j-1
{% endhighlight %}

Objects in Python on indexed starting from 0, for example `l[0:4]`. Negative indices go in reverse. To obtain elements from a nested list, do multiple indexes, `l[i][j]`.

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

Dictionaries are hash tables. It has a key and value pair that makes it easier to find/access objects since they have unique keys. The keys of a dictionary should be unique.

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
d.get(key, default) # gets key, returns default if key not available
d.setdefault('KEY', default_value) # gets key, sets key to default if key not available
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


## Collections Class

Collections provides alternatives to the base list structures.

A few functions include

* `deque()`
* `Counter()` is a dictionary subclass for counting hashable objects
* `OrderedDict()` is a dictionary subclass that remembers the order entries were added

# Useful Modules

* Statistical models: [Scikit Learn][scikitlearn_link]{:target = "_blank"}

## Pandas

The module `pandas` provides the ability to work with data frames. 

* [Pandas][pandas_link]{:target = "_blank"} 
* [Pandas_Cheatsheet][pandas_cheatsheet]{:target = "_blank"}

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
Numpy arrays are similar to vectors in R. Vectorized functions may be implemented on the array. Examples of these include `+-*/><`, `np.abs()`, `np.square()`, `np.log()`, etc. Several functions of note include

Function | Description 
---------|------------
`np.unique()` | finds unique values of array
`np.where()` | elementwise if/else (similar to R `ifelse()`)
`np.vectorize(f)` | vectorizes a function (similar to R `Vectorize()`)

<br>
Additional math problems include `arr.sum()`, `arr.mean()`, `arr.var()`, `arr.std()`, `arr.min()`, `arr.argmin()`, `arr.any()`, `arr.all()`. 

More advanced math problems include `np.dot()`, `np.inner()`, `np.outer()`, `np.cross()`, `np.linalg.det()`, `np.linalg.eig()`, `np.linalg.inv()`, `np.linag.svd()`.

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

The module `scipy.stats` provides access to probability distributions. 

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


[regex_post]: http://jennguyen1.github.io/nhuyhoa//2015/07/Regular-Expressions.html
[itertools_link]: https://docs.python.org/2/library/itertools.html
[scipy_link]: http://docs.scipy.org/doc/scipy/reference/stats.html
[pandas_link]: http://pandas.pydata.org/
[Pandas_Cheatsheet]: https://drive.google.com/file/d/0B5VF_idvHAmMV0dTNFpyQU9Udnc/view?usp=sharing
[scikitlearn_link]: http://scikit-learn.org/stable/
