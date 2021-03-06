---
layout: post
title: "Version Control with Git"
date: "August 20, 2017"
categories: Software
tags: Pipelines
---

* TOC
{:toc}



Git is a version control system; it allows you to track changes in your code. 

**Basics**

{% highlight bash %}
git status
git add
git commit -m 'msg'
git commit -am 'msg'
git diff
git diff --staged
{% endhighlight %}

**Branching**

{% highlight bash %}
git branch -a
git branch new_branch_name
git branch -d branch_name
git checkout branch_name
git merge branch_name
{% endhighlight %}

**Syncing with Github**

{% highlight bash %}
git push 
git pull 
{% endhighlight %}

