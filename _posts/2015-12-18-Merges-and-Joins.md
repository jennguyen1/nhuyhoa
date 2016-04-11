---
layout: post
title: "Merges & Joins"
date: "December 18, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}

Often when you have data from multiple sources, you need to combine the data to effectively analyze the data. The most effective way to do this is with joins or merges. 

# Types of Joins

## Inner Join
Keep only rows that match from the two data frames.

![inner join](http://jnguyen92.github.io/nhuyhoa/figure/images/inner_join.png)

## Outer Join
Keep all rows from both data frames.

![outer join](http://jnguyen92.github.io/nhuyhoa/figure/images/outer_join.png)

## Left Join
Keep all rows from x and all those from y that match.

![left join](http://jnguyen92.github.io/nhuyhoa/figure/images/left_join.png)

## Right Join
Keep all rows from y and all those from x that match.

![right join](http://jnguyen92.github.io/nhuyhoa/figure/images/right_join.png)

# Implementation 

## In SQL
Joins in SQL follow a simple format:

{% highlight sql %}
select tab1.COLNAMES tab2.COLNAMES
from tab1
___ join tab2
on tab1.id = tab2.id and tab1.id2 = tab2.id2;
{% endhighlight %}

To specify the join, simply replace the blank with `inner`, `full outer`, `left`, or `right`. 

To join multiple data frames in SQL, you can also do successive joins. Simply append an additional `___ join ... on` statements after the previous join.

Other operations similar to merges:

* `union`
* `intersect`
* `except`

## In R
All merges in R can be done with a simple `merge()` function. The arguments for this function include

* `x`, `y`: data frames to be merged
* `by`: the names of columns on which matches are searched
* `all`: option for inner or outer join; set to `FALSE` for inner join and `TRUE` for outer join
* `all.x`: option for left join
* `all.y`: option for right join

To join multiple data frames in R, you can do successive joins. That is, join two and use the result to join with another data frame. To save time, the function `jn.general::mult_merge()` was created to make merging multiple data frames easier.

Other operations similar to merges:

* `cbind()`
* `rbind()`, `data.table::rbindlist()`
* `dplyr::anti_join()` 
* `dplyr::intersect()` 
* `dplyr::union()` 
* `dplyr::setdiff()`

## In SAS

Merging data in SAS requires first sorting by the merge variable then merging.


{% highlight r %}
# first sort both files
proc sort data = TAB;
by VAR1 VAR2 ...;
run;

# then merge
merge TAB1 (in=INVAR1) TAB2 (in==INVAR2);
by VAR1 VAR2;
if INVAR and INVAR2;
run;
{% endhighlight %}

By default SAS merges will do an outer merge. Additional filtering can be done to specify other types of merges. The example above is doing an inner merge. 

An operation similar to union or rbind is

{% highlight r %}
data NAME;
set TAB1 TAB2;
run;
{% endhighlight %}

