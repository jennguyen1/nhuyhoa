---
layout: post
title: "SQL Basics"
date: "December 17, 2015"
categories: Software
tags: Basics
---

* TOC
{:toc}

SQL (Structured Query Language) is a database language designed to extract and manipulate data from databases. 

Other languages generally have functionality to interface with databases using SQL.

# Basic Statement
The basic SQL statement is pretty simple.

{% highlight sql %}
select *, COLNAMES 
from TAB
where EXPRESSION
group by COLNAMES
having EXPRESSION
order by COLNAMES ACS/DESC;
{% endhighlight %}

Notice the similarities between SQL statments and corresponding functions in $$R$$. 

For additional functionality, SQL statements can be nested. Nesting can occur at any point in the statement. For example,

{% highlight sql %}
select *
from TAB1
where COL1 in (select COL2 from TAB2);
{% endhighlight %}

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

## Functions

Selected can be wrapped in functions to allow flexibility

* `round( A, decimal )`
* `ceil( A )`
* `floor( A )`
* `A % integer`
* `len( A )`
* `ucase( A )`
* `lcase( A )`
* `trim( A )`
* `substring( A, start, end )`
* `concat( A, ',' , B )` or `( A + ', ' + B)`

**Aggregate Functions**

Aggregate functions tend to be used along with the `group by` command. These functions include

* `count( * )`
* `count( distinct A )`
* `sum( distinct A )`
* `avg( distinct A )`
* `max( A )`
* `min( A )`
* `first( A )`
* `last( A )`

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

# Editing Tables

## Creating Tables
{% highlight sql %}
create table NAME
(
COLNAME TYPE CONSTRAINT,
primary key(COLNAME)
...
)
{% endhighlight %}

## Updating Tables
{% highlight sql %}
update TABLE
set COL1 = VAL1, COL2 = VAL2, ...
where some_col = some_value
{% endhighlight %}

{% highlight sql %}
insert into TABLE (COL1, COL2, ...) 
values (VAL1, VAL2, ...)
{% endhighlight %}

{% highlight sql %}
delete COLNAMES from TABLE
{% endhighlight %}

{% highlight sql %}
alter TABLE
add COLNAME TYPE
alter/modify column COLNAME TYPE
drop column COLNAME
{% endhighlight %}

{% highlight sql %}
insert into TABLE2
select COLNAMES
from TABLE1
{% endhighlight %}

## Create Views
{% highlight sql %}
create view NAME as
select COLNAMES
from TABLE
{% endhighlight %}

## Create Indexes
{% highlight sql %}
create (unique) index NAME
on TABLE (COL1, COL2, ...)
{% endhighlight %}

# Using Variables (MS SQL Server)

Variables in SQL make it easier to combine a large number of column names without typing them out by hand. This may be useful for pivot tables or other complicated operations with many columns. 

Variables can be declared like so
{% highlight sql %}
declare @var1 varchar(MAX);
declare @var2 int;
{% endhighlight %}

The variable may be set in a variety of ways
{% highlight sql %}
/* simple set */
set @var2 = 0;

/* select a column and combine multiple rows into a string */
select @var1 = ISNULL(@var1 + ', ', '') + COLNAME from TAB1

/* set a variable an concatenate with other vars */
set @sql = N'select id, ' + @var1 + 'from TAB2'
{% endhighlight %}

Variables can be print to the screen using the following command
{% highlight sql %}
print @var1
{% endhighlight %}

If a variable is a SQL query, it can be executed with
{% highlight sql %}
exec sp_executesql @sql
{% endhighlight %}
