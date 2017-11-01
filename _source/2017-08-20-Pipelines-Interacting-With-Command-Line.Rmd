---
layout: post
title: "Interacting with Command Line"
date: "August 20, 2017"
categories: Software
tags: Pipelines
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

# calls to shell, locks main program until complete
import subprocess
subprocess.check_output(CMD, shell = True) # gets command line output; CalledProcessError if code is non-zero
subprocess.call(CMD, shell = True) # runs code, get return code
subprocess.check_call(['CMD', 'ARG1']) # runs code, CalledProcessError if code is non-zero

# calls to shell, does not lock main program 
from subprocess import Popen, PIPE
proc = Popen(CMD, stdout = PIPE, stderr = PIPE)
proc.pid
proc.returncode
stdout, stderr = proc.communicate()
proc.wait() # wait until completion
proc.kill()
proc.terminate()

# the functions check_output, check_call, call, wait all have a timeout parameter to limit how long the program can run
{% endhighlight %}


# Command Line Arguments

### In Scripts
It is good practice to print out a time stamp for start/end of script and the command line arguments that were passed in.

**R**
{% highlight r %}
library(argparse)

# initialize the parser
parser <- ArgumentParser(description = "Apple Game")

# declare the arguments
parser$add_argument('-a', '--apple', help = 'Type of apple [%(default)s]', dest = 'apple', default = "red")
parser$add_argument('-c', '--count', help = 'How many apples [%(default)s]', dest = 'count', default = 5)
parser$add_argument('--eat', help = 'Boolean flag, should I eat the apple(s)? [%(default)s]', dest = 'eat', action = 'store_true', default = FALSE)
  
# parse arguments
args <- parser$parse_args()
{% endhighlight %}

**Python**
{% highlight python %}
import argparse

# initialize the parser
parser = argparse.ArgumentParser(description='''Apple Game''')
  
# declare the arguments
parser.add_argument('-a', '--apple', help = 'Type of apple [%(default)s]', dest = 'apple', default = "red")
parser.add_argument('-c', '--count', help = 'How many apples [%(default)s]', dest = 'count', default = 5)
parser.add_argument('--eat', help = 'Boolean flag, should I eat the apple(s)? [%(default)s]', dest = 'eat', action = 'store_true', default = False)
  
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

