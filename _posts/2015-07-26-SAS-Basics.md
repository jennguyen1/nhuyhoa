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
proc export data = DATANAME outfile = "FILEPATH" dbms = csv replace;
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

Other expressions of interest

* `=`, `^=`, `>`, ...
* `&`, `|`, `not` 
* `is missing`, `is not missing`, `is null`
* `n()`, `nmiss()`
* `between __ and __`, `contains`, `in (..., ..., ...)`

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

## Using SQL in SAS

{% highlight r %}
proc sql;
select COLNAMES/EXPRESSION as NEWNAME
into :MACRONAME
separated by ""
from TABLE
where CONDITION
group by COLNAMES
having EXPRESSION
order by COLNAMES ASC/DCS;
quit;
{% endhighlight %}

Can also do SQL joins in SAS

{% highlight r %}
proc sql;
select * 
from TAB1
inner join TAB2
where TAB1.id = TAB2.id;
quit;
{% endhighlight %}

# Conditionals
The basic statement for if and else are


{% highlight r %}
if CONDITION then EXPRESSION;
else if CONDITION then EXPRESSION;
else EXPRESSION;
{% endhighlight %}

# Loops

**For Loops**

{% highlight r %}
do i = START to STOP by INCREMENT;
  OPERATIONS;
end;

do i = 1, 2, 3, 4 to 10 by INCREMENT;
  OPERATIONS;
end;
{% endhighlight %}

**While and Until Loops**

{% highlight r %}
do while(CONDITION);
  OPERATIONS;
end;

do until(CONDITION);
  OPERATIONS;
end;
{% endhighlight %}

**Control within Loops**

* Skip to next iteration: `continue`
* Exit loop: `leave`

# Macros
Functions in SAS are known as macros. 

**Declare Macro Variables**

{% highlight r %}
%LET MNAME = VALUE;
{% endhighlight %}

We can convert data values into macro variables by doing

{% highlight r %}
call symput("MNAME", VALUE);
{% endhighlight %}

**Use Macro Variable**

{% highlight r %}
&MNAME
{% endhighlight %}

When used in a string, macrovariables should start with a `&` and end with a space, `;`, `&`, or `.`

There are a number of built-in macrovariables, including

* `&sysdate`, `&sysdate9`
* `&ststime`
* `&sysday`

To write macrovariables to the console, one can do

{% highlight r %}
%PUT &MNAME;
{% endhighlight %}


**Conditional**

{% highlight r %}
%if CONDITION %then ACTION;
%else %if CONDITION %then ACTION;
%else ACTION;

%if CONDITION %then %do;
  OPERATIONS;
%end;
{% endhighlight %}

**Functions**

{% highlight r %}
%macro MACRONAME(param1 = , param2 = , ...);
  OPERATIONS;
%mend MACRONAME;

%MACRONAME(PARAMS);
{% endhighlight %}

Notice that the parameters are macrovariables, so they should be used with `&`. 

