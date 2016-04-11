---
layout: post
title: "SAS Basics"
date: "July 26, 2015"
categories: ['basics']
---

* TOC
{:toc}



# Working with Data

## Import Data

**Manually**

{% highlight r %}
data NAME;
input VARNAMES ($);
datalines;
NUMBERS;
run;
{% endhighlight %}

**CSV Files**

{% highlight r %}
data filename;
infile “FILEPATH” dlm = ‘,’ startobs = 2 dsd;
input VARNAMES @@;
run;
{% endhighlight %}


{% highlight r %}
proc import datafile = “FILEPATH” out = NAME dbms = csv replace;
getnames = yes;
datarow = 2;
guessingrows = 1000;
run;
{% endhighlight %}

**From Existing Table**

{% highlight r %}
data NAME;
set DAT;
{% endhighlight %}

## Export Data

**To CSV**

{% highlight r %}
proc export data = NAME outfile = "" outtable = TABNAME dbms = csv replace;
run;
{% endhighlight %}

**Print Data**

{% highlight r %}
proc print data = DAT noobs;
{% endhighlight %}

## Other 

{% highlight r %}
title "";
# in other functions
output out = ;
libname LIBNAME FILEPATH
{% endhighlight %}

