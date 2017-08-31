---
layout: post
title: "Logging"
date: "August 29, 2017"
categories: ['pipelines']
---

* TOC
{:toc}

# Initiation and General Logging

**R**

Logging in R can be done with the `logging` package. 

{% highlight r %}
import logging

# set logger
logReset()
level <- "DEBUG"
log <- getLogger()
log$addHandler(writeToConsole, level = level)
log$addHandler(writeToFile, file = "test.log", level = level)
setLevel(level)

# start logging
log$handlers
logdebug("Need to fix")
loginfo("You are late")
logwarning("This is outdated")
logerror("Kill code")
{% endhighlight %}

**Python**

The `logging` module is also available in Python.
{% highlight python %}
import logging
import sys

# initiate logger: levels incldue DEBUG, INFO, WARNING, ERROR, CRITICAL
log = logging.getLogger()
level = logging.DEBUG
log.setLevel(level)

# make handler for console
handler = logging.StreamHandler(sys.stderr)
handler.setLevel(level)

# make formatter
formatter = logging.Formatter("%(asctime)s %(levelname)s %(message)s", "%Y-%m-%d %H:%M:%S")
handler.setFormatter(formatter)

# make formatter for file
file_handler = logging.FileHandler("test.log")
file_handler.setFormatter(formatter)

# add handlers to logger
log.addHandler(handler)
log.addHandler(file_handler)

# log messages
log.debug("Need to fix")
log.info("You are late")
log.warning("This is outdated")
log.error("Kill code")
log.log(level, "Here's another way")
{% endhighlight %}


# Progress Bar

**Python**

The following code is an example of a progress bar that can be incorporated into a python log.

{% highlight python %}
# make class for progress bar
class ProgressBar(object):
  def __init__(self, level, total, increment = 10, pattern = "%i% complete"):
    self.level = level
    self.total = total
    self.increment = increment
    self.last_reported = 0
    self.pattern = pattern
    
  # log an update in reporter
  def update(self, i, text = None, force = False):
    percent = int(i * 100.0 / self.total)
    
    if force or percent >= self.last_reported + self.increment:
      self.last_reported = percent
      
      if not text:
        text = self.pattern
        
      logging.log(self.level, text % percent)

# intiate and update reporter
reporter = PercentReporter(logging.INFO, len(mylist), increment = 5)
reporter.update(0)
reporter.update(30, '%i% of matches found')
{% endhighlight %}

