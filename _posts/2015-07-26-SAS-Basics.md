---
layout: post
title: "SAS Basics"
date: "July 26, 2015"
categories: Software
tags: Basics
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

**Reports**


{% highlight r %}
proc reports data = NAME headline headskip;
  title 'SOME TITLE';
  column COLNAMES;
  where CONDITION;
  define VAR1 / 'COL TITLE / WITH SPLIT' format = FORMAT spacing = N width = N;
  define VAR2 / order descending;
run;
{% endhighlight %}

Variables may also be grouped and summarised with any of SAS's summary statistics

{% highlight r %}
proc report data = NAME;
  column VAR1 VAR2 VAR3;
  define VAR1 / group 'TYPE';
  define VAR2 / mean 'MEAN';
  define VAR3 / var 'VARIANCE';
run;
{% endhighlight %}

New variables may also be computed

{% highlight r %}
proc report data = NAME;
  column VAR1 VAR2 NEWVAR;
  define VAR3;
  compute VAR3;
    Var3 = EXPR;
  endcomp;
run;
{% endhighlight %}


## Edit Data

Shortcuts may be used to select many columns

* `VAR1-VAR10`: VAR1, VAR2, ..., VAR10
* `_ALL_`, `_CHARACTER_`, `_NUMERIC_`: all variables of specified type

**Creating a New Column**

{% highlight r %}
data DATANAME;
  set DATANAME;
  NEWCOL = EXPR;
run;
{% endhighlight %}

To change the format of variables

* Numeric to character conversion: `put(VALUE, $32.)`
* Character to numeric conversion: `input(VALUE, best32.)`
* Missing data is represented by a dot `.`

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
* `nodupkey`: removes duplicate keys

## Using SQL in SAS

{% highlight r %}
proc sql outobs = N print;
  create table NEWTABLE as 
  select COLNAMES/EXPRESSION as NEWNAME
  into :MACRONAME separated by ""
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

There are a number of functions for `proc sql` in addition to the usual SAS and SQL functions including

* `missing( A )`
* `monotonic()` refers to the row number
* `ifc( CONDITION, YES, NO )` if/else for character results
* `ifn( CONDITION, YES, NO )` if/else for numeric results

And the following aggregate functions

* `unique( A )`
* `nmiss( A )`
* `var( A )`
* `std( A )`
* `stderr( A )`
* `range( A )`
* `sumwgt( A )`
* `t( A )` t-value from one-sided t-test
* `prt( A )` two-tailed p-value for t-statistic

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

Using an `output` statement inside a loop creates a new row/observation based on the current iteration of the loop.

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

# Arrays

Arrays are useful for iterating over variables and performing repetitive tasks. 

Arrays can be defined with the statement

{% highlight r %}
array ARRNAME(DIM) ELEM1 ELEM2 ELEM3 ... ELEMN;
{% endhighlight %}

Arrays may also be initialized with the appropriate dimensions and edited later to create new columns

{% highlight r %}
array ARRNAME(DIM);
{% endhighlight %}

Once declared, use a loop to iterate through an array and edit single elements as needed. The dimensions of an array can be accessed with `dim(ARRNAME)`.

There are several shortcuts to choose variables to incorporate into an array

* `__ALL__`
* `__CHARACTER__`
* `__NUMERIC__`
* `var1-varn`: variable named `var1`, `var2`, ..., `varn`

Below is an example

{% highlight r %}
data temps;
  set temps;
  input City $ 1-18 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12;
	array fahr(*) m1-m12;
	do i = 1 to 12;
	      fahr(i) = 1.8*fahr(i) + 32;  	
    end;
run;
{% endhighlight %}

# Functions

The FCMP procedure is used to create user defined functions. 

There are two ways to define functions. The main difference between the two is the return statement.


{% highlight r %}
# declare function
proc fcmp outlib = work.functions.funcs;
  function NAME(PARAM1, PARAM2 $) $;
    OPERATIONS;
    return(y);
  endsub;
run;

# run function
options complib = (work.functions);
NAME(PARAMS)
%sysfunc(NAME(PARAMS))
{% endhighlight %}


{% highlight r %}
# declare function
proc fcmp outlib = work.functions.funcs;
  subroutine NAME(PARAMS, RETURN1, RETURN2);
    outargs RETURN1, RETURN2;
    OPERATIONS; # define RETURN1 and RETURN2 here
  endsub;
run;

# run function
options complib = (work.functions);
Y1 = .;
Y2 = .;
call NAME(PARAMS, Y1, Y2);
{% endhighlight %}

Functions can be deleted with 

{% highlight r %}
proc fcmp outlib = work.functions.funcs;
  deletefunc NAME;
run;
{% endhighlight %}

Macros may be used in functions but require a different process. Macros should be defined with out its parameters - they will automatically be passed into the macro. To call a macro from with a function, use the following statement

{% highlight r %}
run_macro('MACRONAME', PARAMS);
{% endhighlight %}

# Macros

Macros are variables and function like processes that work on data sets.

## Declare Macro Variables

{% highlight r %}
%LET MNAME = VALUE;
{% endhighlight %}

Data values can be converted into macro variables with

{% highlight r %}
call symput("MNAME", VALUE);
{% endhighlight %}

**Declaring Macrovariables with Proc SQL**

Macrovariables can also be created from `proc sql`.

The following statement selects the first row of the column into a macrovariable 

{% highlight r %}
select country, flower into :country1, :flower1
{% endhighlight %}

This can be done with and without aggregation. 

Select multiple rows and create multiple macrovariables with

{% highlight r %}
%let n = 100
select country, flower into :country1 - :country&n, :flower1 - :flower&n
{% endhighlight %}

All the values with a column may be concatenated into a single macrovariable with

{% highlight r %}
select country into :countries separated by ", "
{% endhighlight %}

## Use Macro Variable


{% highlight r %}
&MNAME
{% endhighlight %}

When used in a string, macrovariables should start with a `&` and end with a space, `;`, `&`, or `.`

There are a number of built-in macrovariables, including

* `&sysdate`, `&sysdate9`
* `&ststime`
* `&sysday`

To write macrovariables to the console, write

{% highlight r %}
%put &MNAME;
{% endhighlight %}

Macrovariables may also be concatenated to form the name of another macrovariable. This may be useful in looping. For example,

{% highlight r %}
%let var5 = 10
%let i = 5

%put &&var&i
{% endhighlight %}

## Conditional

{% highlight r %}
%if CONDITION %then ACTION;
%else %if CONDITION %then ACTION;
%else ACTION;

%if CONDITION %then %do;
  OPERATIONS;
%end;
{% endhighlight %}

## Loops

{% highlight r %}
%do i = START %to STOP;
  OPERATIONS;
%end
{% endhighlight %}

## Functions

{% highlight r %}
%macro MACRONAME(param1 = , param2 = , ...);
  OPERATIONS;
%mend MACRONAME;

%MACRONAME(PARAMS);
{% endhighlight %}

The parameters of macros are macro variables, so access them with `&`.
