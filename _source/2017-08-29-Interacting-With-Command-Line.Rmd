---
layout: post
title: "Interacting with Command Line"
date: "August 29, 2017"
categories: ['pipelines']
---

* TOC
{:toc}

# Output

**R**
{% highlight r %}
Sys.sleep(s)

Sys.time()

system()
{% endhighlight %}

**Python**
{% highlight python %}
import time
time.sleep(s)

import datetime
datetime.now()
datetime.today()

import subprocess
subprocess.check_output(CMD, shell = True) # gets command line output; CalledProcessError if code is non-zero
subprocess.call(CMD, shell = True) # runs code, get return code
subprocess.check_call(['CMD', 'ARG1']) # runs code, CalledProcessError if code is non-zero

from subprocess import Popen, PIPE
proc = Popen(CMD, stdout = PIPE, stderr = PIPE)
proc.wait() # wait for completion
stdout, stderr = process.communicate()
proc.returncode
proc.kill()
{% endhighlight %}


# Scripting

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
echo 'all arguments:'$*
echo 'script name:'$0
echo 'first arg:'$1
echo 'second arg:'$2

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo 'dir of script:'${DIR}
{% endhighlight %}

## Calling Scripts

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

