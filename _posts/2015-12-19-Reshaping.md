---
layout: post
title: "Reshaping"
date: "December 19, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}




The format of your data is an important consideration. Data be formatted long or wide. Often times you will need to switch between the various formats to obtain the metrics you need. 

* Long-format: contains a column for possible variable types and a column with the values for those variables; extremely useful for grouping and running separate operations on by groups
* Wide-format: each variable contains its own columns, populated by values

To switch between the two formats, transpose operations can be used. This is similar to using pivot tables in Excel. This can be useful in plotting.

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

Now perhaps we don't want to melt all variables, we can keep one (or more) as a column. This tells the function that we want to know the values of the variables for each unique combination of our specified columns.


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

To specify the format of the data, we need three things. 

1. The $$id$$ variables (similar to those used in the melt column)
2. The name of the $$variable$$ column that will contain the new column names (swing it into the column names)
3. The name of the $$value$$ column in which the data spaces are filled in

Once we have these three things we can generate a casting formula:

$$ id.vars $$ ~ $$ variable $$, $$ value.var = value $$

We can use the melted data from above to shift it back into wide mode.

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

One potentially annoying error might occur when you do this. If there are duplicated entries of the $$id$$ and $$variable$$, then the function will want to aggregate the duplicated values in each cell. 


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

If this is what you wanted, you can specify the aggregate function (such as $$mean$$, $$median$$, $$sum$$, etc). 


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

If this isn't what you wanted, you make have to be a little creative. One way to do this is to edit the variable values to make it unique across combinations.


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
  unite(variable.id, variable, id) %>% 
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
