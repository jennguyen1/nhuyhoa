---
layout: post
title: "Reshaping & Transposes"
date: "December 19, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}




Data be formatted long or wide. Often formats will need to switch to obtain the needed metrics. 

* Long-format: contains a column for possible variable types and a column with the values for those variables; extremely useful for grouping and running separate operations on by groups
* Wide-format: each variable contains its own columns, populated by values

To switch between the two formats, transpose operations can be used. This is similar to using pivot tables in Excel. 

# In R
There are a few packages in R that can do transposing. The function names are different, but the idea is the same. 

## Wide to Long

Functions:

* `melt()`
* `gather()`

Take a look at the `airquality` data. 

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Ozone </th>
   <th style="text-align:center;"> Solar.R </th>
   <th style="text-align:center;"> Wind </th>
   <th style="text-align:center;"> Temp </th>
   <th style="text-align:center;"> Month </th>
   <th style="text-align:center;"> Day </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 41 </td>
   <td style="text-align:center;"> 190 </td>
   <td style="text-align:center;"> 7.4 </td>
   <td style="text-align:center;"> 67 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 118 </td>
   <td style="text-align:center;"> 8.0 </td>
   <td style="text-align:center;"> 72 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 149 </td>
   <td style="text-align:center;"> 12.6 </td>
   <td style="text-align:center;"> 74 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 313 </td>
   <td style="text-align:center;"> 11.5 </td>
   <td style="text-align:center;"> 62 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 14.3 </td>
   <td style="text-align:center;"> 56 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
  </tr>
</tbody>
</table>
</div><p></p>

Convert it to long format:

{% highlight r %}
melt(airquality)
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> variable </th>
   <th style="text-align:center;"> value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 41 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 36 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> NA </td>
  </tr>
</tbody>
</table>
</div><p></p>

Rather than melting all variables, one can keep one (or more) columns. This tells the function to provide the values of the variables for each unique combination of the specified columns.


{% highlight r %}
melt(airquality, id.vars = c("Month", "Day"))
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Month </th>
   <th style="text-align:center;"> Day </th>
   <th style="text-align:center;"> variable </th>
   <th style="text-align:center;"> value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 41 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 36 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> Ozone </td>
   <td style="text-align:center;"> NA </td>
  </tr>
</tbody>
</table>
</div><p></p>

## Long to Wide

Functions:

* `dcast()`
* `spread()`

To specify the format of the data, three terms are needed 

1. The $$id$$ variables (similar to those used in the melt column)
2. The name of the $$variable$$ column that will contain the new column names (swing it into the column names)
3. The name of the $$value$$ column in which the data spaces are filled in

With these three terms, the casting formula is

`id.vars ~ variable, value.var = "value"`

Use the melted data from above to shift it back into wide mode.

{% highlight r %}
melt(airquality, id.vars = c("Month", "Day")) %>% 
  dcast(Month + Day ~ variable, value = "value")
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Month </th>
   <th style="text-align:center;"> Day </th>
   <th style="text-align:center;"> Ozone </th>
   <th style="text-align:center;"> Solar.R </th>
   <th style="text-align:center;"> Wind </th>
   <th style="text-align:center;"> Temp </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 41 </td>
   <td style="text-align:center;"> 190 </td>
   <td style="text-align:center;"> 7.4 </td>
   <td style="text-align:center;"> 67 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 118 </td>
   <td style="text-align:center;"> 8.0 </td>
   <td style="text-align:center;"> 72 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 149 </td>
   <td style="text-align:center;"> 12.6 </td>
   <td style="text-align:center;"> 74 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 313 </td>
   <td style="text-align:center;"> 11.5 </td>
   <td style="text-align:center;"> 62 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 14.3 </td>
   <td style="text-align:center;"> 56 </td>
  </tr>
</tbody>
</table>
</div><p></p>

If there are duplicated entries of the $$id$$ and $$variable$$, then the function will want to aggregate the duplicated values in each cell. 


{% highlight r %}
# first melt it
melt(airquality, id.vars = c("Month", "Day")) %>% 
  # then dcast with just the Month
  dcast(Month ~ variable, value.var = "value")
{% endhighlight %}


{% highlight text %}
## Aggregation function missing: defaulting to length
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Month </th>
   <th style="text-align:center;"> Ozone </th>
   <th style="text-align:center;"> Solar.R </th>
   <th style="text-align:center;"> Wind </th>
   <th style="text-align:center;"> Temp </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 30 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 31 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 30 </td>
  </tr>
</tbody>
</table>
</div><p></p>

If aggregation is desired, it can be specified as the aggregate function (such as $$mean$$, $$median$$, $$sum$$, etc). 


{% highlight r %}
# first melt it
melt(airquality, id.vars = c("Month", "Day")) %>% 
  # then dcast with just the Month
  dcast(Month ~ variable, value.var = "value", fun.aggregate = sum, na.rm = TRUE)
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Month </th>
   <th style="text-align:center;"> Ozone </th>
   <th style="text-align:center;"> Solar.R </th>
   <th style="text-align:center;"> Wind </th>
   <th style="text-align:center;"> Temp </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 614 </td>
   <td style="text-align:center;"> 4895 </td>
   <td style="text-align:center;"> 360.3 </td>
   <td style="text-align:center;"> 2032 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 265 </td>
   <td style="text-align:center;"> 5705 </td>
   <td style="text-align:center;"> 308.0 </td>
   <td style="text-align:center;"> 2373 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1537 </td>
   <td style="text-align:center;"> 6711 </td>
   <td style="text-align:center;"> 277.2 </td>
   <td style="text-align:center;"> 2601 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1559 </td>
   <td style="text-align:center;"> 4812 </td>
   <td style="text-align:center;"> 272.6 </td>
   <td style="text-align:center;"> 2603 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 912 </td>
   <td style="text-align:center;"> 5023 </td>
   <td style="text-align:center;"> 305.4 </td>
   <td style="text-align:center;"> 2307 </td>
  </tr>
</tbody>
</table>
</div><p></p>

If aggregation is not desired, achieving the correct format will require a little creativity. One way to do this is to edit the variable values to make it unique across combinations.


{% highlight r %}
airquality %>% 
  # Enough to run this on a select columns
  dplyr::select(Month, Day, Ozone, Wind) %>% 
  # melt as usual
  melt(id.vars = c("Month", "Day")) %>% 
  # step to add the uniqueness factor
  group_by(Day, variable) %>% 
  mutate(id = 1:length(value)) %>% 
  na.omit %>% 
  mutate(variable.id = paste(variable, id, sep = "_")) %>% 
  # now run dcast and observe the changes
  dcast(Day ~ variable.id, value.var = "value")
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Day </th>
   <th style="text-align:center;"> Ozone_1 </th>
   <th style="text-align:center;"> Ozone_2 </th>
   <th style="text-align:center;"> Ozone_3 </th>
   <th style="text-align:center;"> Ozone_4 </th>
   <th style="text-align:center;"> Ozone_5 </th>
   <th style="text-align:center;"> Wind_1 </th>
   <th style="text-align:center;"> Wind_2 </th>
   <th style="text-align:center;"> Wind_3 </th>
   <th style="text-align:center;"> Wind_4 </th>
   <th style="text-align:center;"> Wind_5 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 41 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 135 </td>
   <td style="text-align:center;"> 39 </td>
   <td style="text-align:center;"> 96 </td>
   <td style="text-align:center;"> 7.4 </td>
   <td style="text-align:center;"> 8.6 </td>
   <td style="text-align:center;"> 4.1 </td>
   <td style="text-align:center;"> 6.9 </td>
   <td style="text-align:center;"> 6.9 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 49 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 78 </td>
   <td style="text-align:center;"> 8.0 </td>
   <td style="text-align:center;"> 9.7 </td>
   <td style="text-align:center;"> 9.2 </td>
   <td style="text-align:center;"> 13.8 </td>
   <td style="text-align:center;"> 5.1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 73 </td>
   <td style="text-align:center;"> 12.6 </td>
   <td style="text-align:center;"> 16.1 </td>
   <td style="text-align:center;"> 9.2 </td>
   <td style="text-align:center;"> 7.4 </td>
   <td style="text-align:center;"> 2.8 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 78 </td>
   <td style="text-align:center;"> 91 </td>
   <td style="text-align:center;"> 11.5 </td>
   <td style="text-align:center;"> 9.2 </td>
   <td style="text-align:center;"> 10.9 </td>
   <td style="text-align:center;"> 6.9 </td>
   <td style="text-align:center;"> 4.6 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 64 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 47 </td>
   <td style="text-align:center;"> 14.3 </td>
   <td style="text-align:center;"> 8.6 </td>
   <td style="text-align:center;"> 4.6 </td>
   <td style="text-align:center;"> 7.4 </td>
   <td style="text-align:center;"> 7.4 </td>
  </tr>
</tbody>
</table>
</div><p></p>

## Visual Diagram of Reshaping in R

![reshaping in R](http://jnguyen92.github.io/nhuyhoa/figure/images/transpose.png)
(By r-statistics)

# In SAS

## Wide to Long


{% highlight r %}
proc transpose data = LONGDATA out = WIDEDATA prefix = COLPREFIX;
by LONGID;
id WIDEID;
var VALUE.VAR;
{% endhighlight %}

This formula runs the equivalent of `"LONGID ~ WIDEID", value.var = VALUE.VAR` in R.

## Long to Wide


{% highlight r %}
data LONGDATA;
set WIDEDATA;
array ARR(DIM) WIDEVARS;
do VARIABLE_VAR = VAL1 VAL2 ... VALN;
  VALUE_VAR = ARR(VARIABLE_VAR);
  output;
end;
drop WIDEVARS;
run;
{% endhighlight %}

# In SQL

Reshaping in SQL can be done with the `pivot` command. 

## Wide to Long

{% highlight sql %}
select COLNAMES
from TABLE
unpivot (
  VALUE_VAR 
  for VARIABLE_VAR 
  in(VARIABLE_VAR_VAL)
) as NEWTABLE;
{% endhighlight %}

The following is an example that unpivots the $$MONTH$$ variable wide while putting the value into a $$AMNT$$ variable.

{% highlight sql %}
select ID, MONTH, AMNT
from CALTAB
unpivot ( 
  AMNT 
  for MONTH 
  in(JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC)
) as UNPVT;
{% endhighlight %}

## Long to Wide

{% highlight sql %}
select COLNAMES
from TABLE
pivot ( 
  AGG_FUNC(VALUE_VAR) 
  for VARIABLE_VAR 
  in(VARIABLE_VAR_VALS)
) as NEWTABLE;
{% endhighlight %}

The following is an example that pivots the $$MONTH$$ variable wide while taking the sum of $$AMNT$$.

{% highlight sql %}
select *
from CALTAB
) as S
pivot (
  sum(AMNT)
  for MONTH 
  in (JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC)
) as PVT;
{% endhighlight %}

