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
data DATANAME;
input VARNAMES ($);
datalines;
DATA;
run;
{% endhighlight %}

**CSV Files**

{% highlight r %}
data DATANNAME;
infile "FILEPATH" dlm = ',' startobs = 2 dsd;
input VARNAMES @@;
run;
{% endhighlight %}


{% highlight r %}
proc import datafile = "FILEPATH" out = DATANAME dbms = csv replace;
getnames = yes;
datarow = 2;
guessingrows = 1000;
run;
{% endhighlight %}

**From Existing Table**

{% highlight r %}
data DATANAME;
set DATASET;
{% endhighlight %}

## Export Data

**To CSV**

{% highlight r %}
proc export data = DATANAME outfile = "FILEPATH" outtable = OUTNAME dbms = csv replace;
run;
{% endhighlight %}

**Print Data**

{% highlight r %}
proc print data = DATANAME noobs;
{% endhighlight %}


## Edit Data

Shortcuts may be used to select many columns

* `VAR1-VAR10`: VAR1, VAR2, ..., VAR10
* `_ALL_`, `__CHARACTER__`, `__NUMERIC__`: all variables of specified type

**Creating a New Column**

{% highlight r %}
data DATANAME;
set DATANAME;
NEWCOL = EXPR;
run;
{% endhighlight %}

Sometimes we may want to change the format of variables. 

* Numeric to character conversion: `put(VALUE, $32.)`
* Character to numeric conversion: `input(VALUE, best32.)`

**Renaming Columns**

{% highlight r %}
data DATANAME;
set DATANAME;
rename OLD = NEW;
run;
{% endhighlight %}

**Reorder Columns**

{% highlight r %}
data DATANAME;
retain CORRECT.COL.ORDER;
set DATANAME;
run;
{% endhighlight %}

**Keep/Drop Columns**

{% highlight r %}
data DATANAME;
set DATANAME;
drop COL1 COL2 ...;
keep COL3 COL4 ...;
run;
{% endhighlight %}

**Keep/Delete Observations**

{% highlight r %}
# to keep add the phrase
if CONDITION;

# to delete add the phrase
if CONDITION then delete;
{% endhighlight %}

**Sorting Data**

{% highlight r %}
proc sort data = INDATA out = OUTDATA sortseq = __ nodupkey;
by ascending/descending VAR1 VAR2;
run;
{% endhighlight %}

There are several options for sorting

* `ASCI`: sorts by blanks, numbers, uppercase, lowercase
* `LINGUISTIC(STRENGTH = PRIMARY)`: sorts in ASCI, ignoring case
* `LINGUISTIC(NUMERIC_COLLATION = ON)`: treats numbers as numbers and not just digits
* `nodupkey` removes duplicate keys

# Other 

{% highlight r %}
title "";
# in other functions
output out = ;
libname LIBNAME FILEPATH
{% endhighlight %}

