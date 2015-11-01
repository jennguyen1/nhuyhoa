---
layout: post
title: "Linux Commands"
date: "October 30, 2015"
---

* TOC
{:toc}

To navigate:
{% highlight r %}
# travel to the specified location
cd filepath

# travel back one directory
cd ..
{% endhighlight %}

To upload to a folder:
{% highlight r %}
rsync -a filename username@place:file_directory
{% endhighlight %}

To log in via ssh:
{% highlight r %}
ssh username@place
{% endhighlight %}

To remove a file:
{% highlight r %}
# for a file
rm filename

# for a directory
rm -f -r filepath
{% endhighlight %}

Change Permissions:
{% highlight r %}
# make file readable by group
chmod g+r filepath
{% endhighlight %}

Useful locations:
desk22.stat.wisc.edu:public/html
mi1.biostat.wisc.edu:/u/medinfo/handin/bmi576

