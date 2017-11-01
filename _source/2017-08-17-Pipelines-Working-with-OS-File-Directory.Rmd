---
layout: post
title: "Working with OS File Directory"
date: "August 17, 2017"
categories: Software
tags: Pipelines
---

* TOC
{:toc}

# Navigation

R | Python | Bash
--------|--------|--------
| **import os** | 
**getwd()** | **os.getcwd()** | **pwd**
**setwd()** | **os.chdir()** | **cd**
**dir.create()** | **os.makedirs()** | **mkdir** 
**dir.exists()** | **os.path.exists()** | 
**file.exists()** | |
**list.files()** | **os.listdir()** | **ls**
**file.path()** | **os.path.join()** |
..............................................|..............................................|..............................................

# Reading in Files

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
f.readline()
f.readlines()
f.close()
for i, l in enumerate(f):
  do_something(l) # read line by line
  
# automatically close
with open(NAME, 'r') as f:
  for i,l in enumerate(f):
    do_something(l)


pandas.read_csv()
{% endhighlight %}

**Bash**

{% highlight bash %}
read var
read -p 'msg' var

f < file
{% endhighlight %}

# Writing out Files

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
f.writelines()
f.close()

pandas.to_csv()
{% endhighlight %}

**Bash**
{% highlight bash %}
from_file > to_file
from_file >> to_file
from_file &> out_file
from_file &>> out_file
{% endhighlight %}
