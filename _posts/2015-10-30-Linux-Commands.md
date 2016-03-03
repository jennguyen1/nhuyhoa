---
layout: post
title: "Linux Commands"
date: "October 30, 2015"
---

* TOC
{:toc}

**Cheatsheet:**

See [Linux Cheatsheet][linux_ref]{:target = "_blank"}

**Editing files:**

* `grep` for pattern matching
  * `grep -c` counts matches
  *`grep -i` ignores case
  * special characters: `^`, `$`, `*`
* `tr 'abc' 'ABC'` translate lower case to upper case
  * `tr a b < file` translate a to b in the file
  * `tr -d 'aeiou'` delete specific characters
* `uniq` for unique values
* `sort` sorting
* `echo` repeat your own text, can pipe into files
* `wc` word counts
* `cut` cuts out selected portions of each line from each file and writes to standard output
* `paste` merges lines of files together
* `join` merges tables of files together by a given column
* `diff` compare files line by line
* `expand` converts tabs to spaces
* `unexpand` converts spaces to tabs
* `fold` prints out content in more readable format
* `colrm` removes columns from being printed

**Setting variables:**

{% highlight r %}
# set variable
VAR='value'

# view list of variables
set

# remove variable
unset VAR

# set environmental vars so child processes can inherit
export VAR2='value2
{% endhighlight %}

**Aliasing:**

Execute a series of commands
{% highlight r %}
# save the shortcut
alias shortcut='cd ~Desktop; nano temp.txt`

# run shortcut
shortcut

# remove alias
unalias shortcut

# view list of aliases
alias
{% endhighlight %}

**Finding files:**

{% highlight r %}
find directory -type (f/d) \(-name "." -(and/or/not) -name "."\)
{% endhighlight %}

**To log in via ssh:**

{% highlight r %}
ssh username@place
{% endhighlight %}

**To upload to a folder:**

{% highlight r %}
# using rsync
rsync -a filename username@place:file_directory

# using scp (after ssh)
scp original.file location.to.transfer

# using scp with directories
scp -rp file location.to.transfer
{% endhighlight %}

**Change permissions:** 

Syntax: `chmod (user)(+-=)(rwx) (filename)`

Options for users: 

* `u` user (file owner)
* `g` group
* `o` others/world
* `a` all (if no characters given, all is assumed)

The `+-=` refers to assigning and removing permissions

File access options: 

* `r` read and open
* `w` write
* `e` executable

When listed via `ls`, the file access options from left to right are for owner, group, then all. 

{% highlight r %}
# make file readable by group
chmod g+r filepath
{% endhighlight %}

**Useful locations:**

desk22.stat.wisc.edu:public/html

[linux_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMeXJRRWdFTFQzMEU/view?usp=sharing
