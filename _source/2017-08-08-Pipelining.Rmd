---
layout: post
title: "Pipelining"
date: "August 08, 2017"
categories: ['basics']
---

* TOC
{:toc}


# Basics
 
## Conditions

R | Python | Bash
--------|--------|--------
**if(){}** | **if :** | **if ; then**
**else if(){}** | **elif :** | **elif ; then**
**else{}** | **else:** | **else**
 | | **fi**
..............................................|..............................................|..............................................
 **ifelse()** | **filter()** |
 **dplyr::case_when()** | 
 **dplyr::recode()** | 
 **plyr::mapvalues()** | 
 **purrr::keep()** | 
 **purrr::discard()** |

## Looping

R | Python | Bash
--------|--------|--------
**for( in ){}** | **for in :** | **for in**
| | **do**
| | **done**
| | |
**while(){}** | **while :** | **while [ ]**
| | **do**
| | **done**
..............................................|..............................................|..............................................
**purrr::map()** | **map()** | 
**purrr::pmap()** | **zip()**
| **[f(x,y) for x,y in seq if cond]** |
| **enumerate()** |



TODO: **Bash List Examples**

* `$(seq start end by)`
* `'a' 'b' 'c'`
* `$@`
* `./*`

## Functions

R | Python | Bash
--------|--------|--------
**f <- function(p, ...){** | **def f(p, \*\*kwargs):** | **function f{**
..**list(...)** | ..**kwarg['a']** | ..**echo $1**
..**f2(p, ...)** | ..**f2(kwarg['a'], kwarg['b'])** | 
..**return(list(x,y))** | ..**return x,y** | ..**return x**
**}** | | **}**
..............................................|..............................................|..............................................
**f(a)** | **f(a)** | **f a**
..............................................|..............................................|..............................................
**Vectorize()** | **lambda x,y:** |

## Object Oriented Programming

**Python**
{% highlight python %}
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
* `def __next__(self)` to get the next value from an iterator
* `def __reversed__(self)` to create an iterator in reverse order


# Working with OS File Directory

R | Python | Bash
--------|--------|--------
| **import os** | 
**getwd()** | **os.getcwd()** | **pwd**
**setwd()** | **os.chdir()** | **cd**
**dir.create()** | **os.mkdir()** | **mkdir** 
**dir.exists()** | **os.path.exists()** | 
**file.exists()** | |
**list.files()** | **os.listdir()** | **ls**
..............................................|..............................................|..............................................

## Reading in Files

**R**
{% highlight r %}
scan()

read.table()
read.csv()
data.table::fread()
readxl::excel_sheets()
readxl::read_excel()
{% endhighlight %}

**Python**
{% highlight python %}
raw_input("msg")
input("msg")

f = open(NAME, 'r')
f.readlines()
f.close()

pandas.read_csv()
{% endhighlight %}

**Bash**

{% highlight bash %}
read var
read -p 'msg' var

f < file
{% endhighlight %}

## Writing out Files

**R**
{% highlight r %}
capture.output()

write.table()
write.csv()
data.table::fwrite()
{% endhighlight %}

**Python**
{% highlight python %}
f = open(NAME, 'w')
f = open(NAME, 'a')
f.write()
f.close()

pandas.to_csv()
{% endhighlight %}

**Bash**
{% highlight bash %}
from_file > to_file
from_file >> to_file
program_with_error 2> to_file
{% endhighlight %}

# Interacting with Command Line

## Output

**R**
{% highlight r %}
system()
{% endhighlight %}

**Python**
{% highlight python %}
import subprocess
subprocess.call(CMD, shell = True)
subprocess.check_call(['CMD', 'ARG1'])
{% endhighlight %}


## Scripting

### Creation
It is good practice to print out a time stamp for start/end of script and the command line arguments that were passed in.

**R**
{% highlight r %}
library(optparse)

option_list <- list(
  make_option("--apple", help = "Type of apple [default '%default']", dest = "apple", default = "red"), 
  make_option(c("-c", "--count"), help = "How many apples [default %default]", dest = "count", type="integer", default = 5),
  make_option("--eat", help = "Boolean flag, should I eat the apple(s)?", dest = "eat", action = "store_true", default = FALSE)
)

opt <- parse_args(Option_Parser(description = "Apple Game", option_list = option_list))
{% endhighlight %}

**Python**
{% highlight python %}
import argparse

if __name__ == '__main__':

  # initialize the parser
  parser = argparse.ArgumentParser(description='''Apple Game''')
  
  # declare the arguments
  parser.add_argument('-a', '--apple', help = 'Type of apple', dest = 'apple', default = "red")
  parser.add_argument('-c', '--count', help = 'How many apples', dest = 'count', default = 5)
  parser.add_argument('--eat', help = 'Boolean flag, should I eat the apple(s)?', dest = 'eat', action = 'store_true', default = FALSE)
  
  # parse arguments
  args = parser.parse_args()
{% endhighlight %}

**Bash**
{% highlight bash %}
echo 'number of arguments:'$#
echo 'all arguments:'$@
echo 'script name:'$0
echo 'first arg:'$1
echo 'second arg:'$2

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo 'dir of script:'${DIR}
{% endhighlight %}

### Calling Scripts

**R**
{% highlight r %}
Rscript script.R --arg1 1
{% endhighlight %}

**Python**
{% highlight r %}
python script.py --arg1 1
{% endhighlight %}

**Bash**
{% highlight bash %}
bash script.bsh 1
sh script.bsh 1
{% endhighlight %}

# Logging

[class_operators]: https://docs.python.org/2/library/operator.html

