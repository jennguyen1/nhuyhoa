---
layout: post
title: "Linux Commands"
date: "October 30, 2015"
---

* TOC
{:toc}

**Obtain help:**
{% highlight r %}
man cmd
{% endhighlight %}

**To navigate:**
{% highlight r %}
# print current directory
pwd

# travel to the specified location
cd filepath

# travel back to parent directory
cd ..
{% endhighlight %}

**To list file contents**
{% highlight r %}
# print everything
ls -l

# print everything of a given name using wildcards (*, ?, [], {})
ls name.*
{% endhighlight %}

**To upload to a folder:**
{% highlight r %}
rsync -a filename username@place:file_directory
{% endhighlight %}

**To log in via ssh:**
{% highlight r %}
ssh username@place
{% endhighlight %}

**To copy/move files:**
{% highlight r %}
# copy directories
cp -r folder1 folder2

# copy files
cp filename1 filename2 ... new_location

# copy files with wildcards
cp name.* new_location

# move files
mv filenames ... new_location
{% endhighlight %}

**To make files:**
{% highlight r %}
# for a directory(s)
mkdir name1 name2
{% endhighlight %}

**To remove files:**
{% highlight r %}
# for an empty directory
rmdir filepath

# recursively delete
rm -f -r filepath

# for a file
rm filename(s)
{% endhighlight %}

**Change permissions:**
{% highlight r %}
# make file readable by group
chmod g+r filepath
{% endhighlight %}

Useful locations:
desk22.stat.wisc.edu:public/html

