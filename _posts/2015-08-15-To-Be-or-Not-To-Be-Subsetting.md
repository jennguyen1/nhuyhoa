---
title: "To Be or Not To Be: Subsetting"
layout: post
categories: r data_wrangling
---

* TOC
{:toc}



# Subsetting Functions in R

In a previous post, I dicussed the subsetting functions available via the dplyr package, including the `filter()`, `slice()`, and `select()` functions. There are a number of additional ways to subset data frames in R. 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> functions </th>
   <th style="text-align:left;"> purpose </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> head() </td>
   <td style="text-align:left;"> grabs first n rows </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tail() </td>
   <td style="text-align:left;"> grabs last n rows </td>
  </tr>
  <tr>
   <td style="text-align:left;"> magrittr::extract() </td>
   <td style="text-align:left;"> wrapper for '['; takes numeric or character arguments and return corresponding rows/columns </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dplyr::sample_frac() </td>
   <td style="text-align:left;"> randomly selects a given fraction of rows </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dplyr::sample_n() </td>
   <td style="text-align:left;"> randomly selects a given number of rows </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dplyr::distinct() </td>
   <td style="text-align:left;"> subsets to distinct values of a data frame, given a specific variable </td>
  </tr>
  <tr>
   <td style="text-align:left;"> jn.general::duplicated_data() </td>
   <td style="text-align:left;"> returns all duplicated rows by a given variable </td>
  </tr>
</tbody>
</table>
<p></p>

However what if rather than tossing the data that does not correspond to the subset, we wanted to keep it? Say perhaps, we want to subset, perform a sequence of operations, and then somehow relate the two to each other. 

One option would be run the subsetting function two times. Once with the conditions that's required, and then again with the converse argument. 

{% highlight r %}
mtcars %>% subset( gear != 4 )
mtcars %>% subset( gear == 4 )

mtcars %>% dplyr::select(one_of("mpg", "cyl", "hp"))
mtcars %>% dplyr::select(-one_of("mpg", "cyl", "hp"))
{% endhighlight %}

This tends to work pretty well when the filtering condition is pretty simple. However, when we get into multiple arguments, negation can get pretty ugly fast. 

In other cases, obtaining the "anti-subset" is not all that straight forward. For example, if a subset of the data was obtained randomly, as with `sample_n()` or `sample_frac()`, it's difficult to find the portion of the data that wasn't returned by the function. Another example of not being able to easily negate is with `duplicated_data()`, which returns all duplicated rows by a given variable. 

Having faced this issue many times, I wrote the `to_be()` function as a way to obtain both the subsetted data and the "anti-subset". 

# To Be or Not To Be

The function`to_be()` is quite simple when broken down. It takes in a data frame, a subsetting function, and any additional arguments needed for the subset. After performing the needed operations, `to_be()` returns a list of two objects. The first object returned, "to_be", is the resulting data frame when the subset function is applied to the input data. The second object returned, "not_to_be" is the anti-subset, obtained by considering a total of three cases: subset by rows, subset by columns, and subset by rows and columns. 

## Subset by Rows


{% highlight r %}
by_row <- to_be(mtcars, dplyr::filter, cyl != 4, mpg > 20)
{% endhighlight %}

{% highlight r %}
# data corresponding to cars where the cyl is not 4 and mpg is greater than 20
by_row[["to_be"]]
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.620 </td>
   <td style="text-align:right;"> 16.46 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.875 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 258 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> 3.215 </td>
   <td style="text-align:right;"> 19.44 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# data corresponding to cars where cyl is 4 or mpg is less than 20
by_row[["not_to_be"]] %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> mpg </th>
   <th style="text-align:center;"> cyl </th>
   <th style="text-align:center;"> disp </th>
   <th style="text-align:center;"> hp </th>
   <th style="text-align:center;"> drat </th>
   <th style="text-align:center;"> wt </th>
   <th style="text-align:center;"> qsec </th>
   <th style="text-align:center;"> vs </th>
   <th style="text-align:center;"> am </th>
   <th style="text-align:center;"> gear </th>
   <th style="text-align:center;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Volvo 142E </td>
   <td style="text-align:center;"> 21.4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 121.0 </td>
   <td style="text-align:center;"> 109 </td>
   <td style="text-align:center;"> 4.11 </td>
   <td style="text-align:center;"> 2.780 </td>
   <td style="text-align:center;"> 18.6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Maserati Bora </td>
   <td style="text-align:center;"> 15.0 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 301.0 </td>
   <td style="text-align:center;"> 335 </td>
   <td style="text-align:center;"> 3.54 </td>
   <td style="text-align:center;"> 3.570 </td>
   <td style="text-align:center;"> 14.6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ferrari Dino </td>
   <td style="text-align:center;"> 19.7 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 145.0 </td>
   <td style="text-align:center;"> 175 </td>
   <td style="text-align:center;"> 3.62 </td>
   <td style="text-align:center;"> 2.770 </td>
   <td style="text-align:center;"> 15.5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ford Pantera L </td>
   <td style="text-align:center;"> 15.8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 351.0 </td>
   <td style="text-align:center;"> 264 </td>
   <td style="text-align:center;"> 4.22 </td>
   <td style="text-align:center;"> 3.170 </td>
   <td style="text-align:center;"> 14.5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lotus Europa </td>
   <td style="text-align:center;"> 30.4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 95.1 </td>
   <td style="text-align:center;"> 113 </td>
   <td style="text-align:center;"> 3.77 </td>
   <td style="text-align:center;"> 1.513 </td>
   <td style="text-align:center;"> 16.9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
</tbody>
</table>
</div>

## Subset by Columns


{% highlight r %}
by_col <- to_be(mtcars, dplyr::select, -one_of(c("gear", "vs")))
{% endhighlight %}


{% highlight r %}
# data corresponding to all car information except gear & vs 
by_col[["to_be"]] %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> mpg </th>
   <th style="text-align:center;"> cyl </th>
   <th style="text-align:center;"> disp </th>
   <th style="text-align:center;"> hp </th>
   <th style="text-align:center;"> drat </th>
   <th style="text-align:center;"> wt </th>
   <th style="text-align:center;"> qsec </th>
   <th style="text-align:center;"> am </th>
   <th style="text-align:center;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:center;"> 21.0 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 160 </td>
   <td style="text-align:center;"> 110 </td>
   <td style="text-align:center;"> 3.90 </td>
   <td style="text-align:center;"> 2.620 </td>
   <td style="text-align:center;"> 16.46 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:center;"> 21.0 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 160 </td>
   <td style="text-align:center;"> 110 </td>
   <td style="text-align:center;"> 3.90 </td>
   <td style="text-align:center;"> 2.875 </td>
   <td style="text-align:center;"> 17.02 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:center;"> 22.8 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 108 </td>
   <td style="text-align:center;"> 93 </td>
   <td style="text-align:center;"> 3.85 </td>
   <td style="text-align:center;"> 2.320 </td>
   <td style="text-align:center;"> 18.61 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:center;"> 21.4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 258 </td>
   <td style="text-align:center;"> 110 </td>
   <td style="text-align:center;"> 3.08 </td>
   <td style="text-align:center;"> 3.215 </td>
   <td style="text-align:center;"> 19.44 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:center;"> 18.7 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 360 </td>
   <td style="text-align:center;"> 175 </td>
   <td style="text-align:center;"> 3.15 </td>
   <td style="text-align:center;"> 3.440 </td>
   <td style="text-align:center;"> 17.02 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# data corresponding to gear and vs information of cars
by_col[["not_to_be"]] %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> vs </th>
   <th style="text-align:center;"> gear </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
</tbody>
</table>
</div>


## Subset by Rows and Columns


{% highlight r %}
by_both <- to_be(mtcars, subset, subset = mpg > 20, select = c(cyl, hp, wt))
{% endhighlight %}

When the function both subsets rows and selects columns, the anti-subset data frame will replace the extracted values with NAs. 

{% highlight r %}
# data corresponding to cyl, hp, wt of cars with an mpg greater than 20
by_both[["to_be"]]
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> wt </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 2.620 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 2.875 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 2.320 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.215 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 240D </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 3.190 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 230 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 3.150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fiat 128 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 2.200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Honda Civic </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 1.615 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toyota Corolla </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 1.835 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toyota Corona </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 2.465 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fiat X1-9 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 1.935 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Porsche 914-2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 2.140 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lotus Europa </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> 1.513 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Volvo 142E </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 2.780 </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# data corresponding to cyl, hp, wt of cars with an mpg greater than 20 are replaced with NAs
by_both[["not_to_be"]] 
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 160.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 16.46 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 160.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:right;"> 22.8 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 108.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.85 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18.61 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 258.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 19.44 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:right;"> 18.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360.0 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.15 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Valiant </td>
   <td style="text-align:right;"> 18.1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 225.0 </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 3.460 </td>
   <td style="text-align:right;"> 20.22 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Duster 360 </td>
   <td style="text-align:right;"> 14.3 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360.0 </td>
   <td style="text-align:right;"> 245 </td>
   <td style="text-align:right;"> 3.21 </td>
   <td style="text-align:right;"> 3.570 </td>
   <td style="text-align:right;"> 15.84 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 240D </td>
   <td style="text-align:right;"> 24.4 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 146.7 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.69 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20.00 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 230 </td>
   <td style="text-align:right;"> 22.8 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 140.8 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.92 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 22.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 280 </td>
   <td style="text-align:right;"> 19.2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 167.6 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 3.92 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 18.30 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 280C </td>
   <td style="text-align:right;"> 17.8 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 167.6 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 3.92 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 18.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 450SE </td>
   <td style="text-align:right;"> 16.4 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 275.8 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:right;"> 3.07 </td>
   <td style="text-align:right;"> 4.070 </td>
   <td style="text-align:right;"> 17.40 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 450SL </td>
   <td style="text-align:right;"> 17.3 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 275.8 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:right;"> 3.07 </td>
   <td style="text-align:right;"> 3.730 </td>
   <td style="text-align:right;"> 17.60 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 450SLC </td>
   <td style="text-align:right;"> 15.2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 275.8 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:right;"> 3.07 </td>
   <td style="text-align:right;"> 3.780 </td>
   <td style="text-align:right;"> 18.00 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Cadillac Fleetwood </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 472.0 </td>
   <td style="text-align:right;"> 205 </td>
   <td style="text-align:right;"> 2.93 </td>
   <td style="text-align:right;"> 5.250 </td>
   <td style="text-align:right;"> 17.98 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lincoln Continental </td>
   <td style="text-align:right;"> 10.4 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 460.0 </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:right;"> 3.00 </td>
   <td style="text-align:right;"> 5.424 </td>
   <td style="text-align:right;"> 17.82 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Chrysler Imperial </td>
   <td style="text-align:right;"> 14.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 440.0 </td>
   <td style="text-align:right;"> 230 </td>
   <td style="text-align:right;"> 3.23 </td>
   <td style="text-align:right;"> 5.345 </td>
   <td style="text-align:right;"> 17.42 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fiat 128 </td>
   <td style="text-align:right;"> 32.4 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 78.7 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 19.47 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Honda Civic </td>
   <td style="text-align:right;"> 30.4 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 75.7 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4.93 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18.52 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toyota Corolla </td>
   <td style="text-align:right;"> 33.9 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 71.1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4.22 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 19.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toyota Corona </td>
   <td style="text-align:right;"> 21.5 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 120.1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.70 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20.01 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dodge Challenger </td>
   <td style="text-align:right;"> 15.5 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 318.0 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 3.520 </td>
   <td style="text-align:right;"> 16.87 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AMC Javelin </td>
   <td style="text-align:right;"> 15.2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 304.0 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 3.15 </td>
   <td style="text-align:right;"> 3.435 </td>
   <td style="text-align:right;"> 17.30 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Camaro Z28 </td>
   <td style="text-align:right;"> 13.3 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 350.0 </td>
   <td style="text-align:right;"> 245 </td>
   <td style="text-align:right;"> 3.73 </td>
   <td style="text-align:right;"> 3.840 </td>
   <td style="text-align:right;"> 15.41 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Pontiac Firebird </td>
   <td style="text-align:right;"> 19.2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 400.0 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> 3.845 </td>
   <td style="text-align:right;"> 17.05 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fiat X1-9 </td>
   <td style="text-align:right;"> 27.3 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 79.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4.08 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Porsche 914-2 </td>
   <td style="text-align:right;"> 26.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 120.3 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4.43 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 16.70 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lotus Europa </td>
   <td style="text-align:right;"> 30.4 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 95.1 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3.77 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 16.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ford Pantera L </td>
   <td style="text-align:right;"> 15.8 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 351.0 </td>
   <td style="text-align:right;"> 264 </td>
   <td style="text-align:right;"> 4.22 </td>
   <td style="text-align:right;"> 3.170 </td>
   <td style="text-align:right;"> 14.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ferrari Dino </td>
   <td style="text-align:right;"> 19.7 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 145.0 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.62 </td>
   <td style="text-align:right;"> 2.770 </td>
   <td style="text-align:right;"> 15.50 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Maserati Bora </td>
   <td style="text-align:right;"> 15.0 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 301.0 </td>
   <td style="text-align:right;"> 335 </td>
   <td style="text-align:right;"> 3.54 </td>
   <td style="text-align:right;"> 3.570 </td>
   <td style="text-align:right;"> 14.60 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Volvo 142E </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 121.0 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 4.11 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18.60 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
</tbody>
</table>
</div>

# Challenge Round
Let’s do something a little more challenging to see to_be in action. With this data set, we want to remove the duplicated id entries by hand and merge them back into the non-duplicates. 

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> race </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Ohio </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Tennessee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Nebraska </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> asian </td>
   <td style="text-align:left;"> North Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> South Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> white </td>
   <td style="text-align:left;"> Mississippi </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Oregon </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> South Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> black </td>
   <td style="text-align:left;"> Nevada </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Alaska </td>
  </tr>
</tbody>
</table>
</div><p></p>


{% highlight r %}
result <- to_be(data, duplicated_data, id)
{% endhighlight %}

The duplicated id entries:

{% highlight r %}
result[["to_be"]]
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> race </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Tennessee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Nebraska </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> white </td>
   <td style="text-align:left;"> Mississippi </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Oregon </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> black </td>
   <td style="text-align:left;"> Nevada </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Alaska </td>
  </tr>
</tbody>
</table>
</div><p></p>

The non-duplicated id entries:

{% highlight r %}
result[["not_to_be"]]
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> race </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> South Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> South Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> asian </td>
   <td style="text-align:left;"> North Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Ohio </td>
  </tr>
</tbody>
</table>
</div><p></p>

From the duplicated id's, I'll keep the id that corresponds to a female, or if none of the duplicated entries are female, an id corresponding to one greater than 50 years old. 

{% highlight r %}
result[["to_be"]] %>% group_by(id) %>% arrange(gender, desc(age)) %>% slice(1)
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> race </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Tennessee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Oregon </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Alaska </td>
  </tr>
</tbody>
</table>
</div><p></p>

Now combine the results back together.

{% highlight r %}
result[["to_be"]] %>% 
  group_by(id) %>% 
  arrange(gender, desc(age)) %>% 
  slice(1) %>% 
  rbind(result[["not_to_be"]])
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> race </th>
   <th style="text-align:left;"> state </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Ohio </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> Tennessee </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> asian </td>
   <td style="text-align:left;"> North Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> hispanic </td>
   <td style="text-align:left;"> South Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Oregon </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> South Carolina </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> native </td>
   <td style="text-align:left;"> Alaska </td>
  </tr>
</tbody>
</table>
</div>
