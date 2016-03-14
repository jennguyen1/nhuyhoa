---
layout: post
title: "SQL Basics"
date: "December 17, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}

SQL (Structured Query Language) is a database language designed to extract and manipulate data from databases. 

# Basic Statement
The basic SQL statement is pretty simple.

{% highlight sql %}
select *, COLNAMES 
from TAB
where EXPRESSION
group by COLNAMES
having EXPRESSION
order by COLNAMES ACS/DSC;
{% endhighlight %}

Notice the similarities between SQL statments and corresponding functions in $$R$$. 

## Additional Options for Select

{% highlight sql %}
select distinct COLNAMES
{% endhighlight %}

The two statements below are equivalent (depends on the database type)
{% highlight sql %}
select top n COLNAMES from TAB
select COLNAMES from TAB limit n
{% endhighlight %}

## Operators for Expressions

* `=` equal
* `!=` not equal
* `>`, `>=` greater than (or equal to)
* `<`, `<=` less than (or equal to)
* `between _ and _` between a range
* `like` searches for a string pattern
* `in` specify multiple possible values
* `any`, `all` looks through combinations
* `and`, `or`, `not` multiple conditionals
* `is missing()` missing values

## Aliasing
Aliasing involves temporarily remaning a column heading or table. 

{% highlight sql %}
select t1.COL1 as C1, t2.COL1 as C2
from TAB1 as t1, TAB2 as t2
{% endhighlight %}

## Aggregate Functions
Aggregate functions tend to be used along with the `group by` command. These functions include

* `count( * )`
* `count( distinct A )`
* `sum( distinct A )`
* `avg( distinct A )`
* `max( A )`
* `min( A )`

## Conditional Statements
These `case` statements are similar to `if/else` statements.
{% highlight sql %}
select COLNAMES
case
  when CONDITION then VALUE
  ...
  else VALUE
end as NEWVARNAME
from TAB
{% endhighlight %}

