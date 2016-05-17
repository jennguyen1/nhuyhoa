---
title: "To Be or Not To Be: Subsetting (R)"
layout: post
categories: ['r programming']
---

* TOC
{:toc}



# Subsetting Functions in R

There are a number of different subsetting functions available in base R and external packages. 

However, there are no functions available for keeping (rather than discarding) the data that does not correspond to the subset (call it the "anti-subset"). This process might be useful for performing a different set of operations on two different subsets of the data and combining the results back again. 

In some cases, obtaining the anti-subset isn't straightforward. For example, when the subset is obtained randomly (as with `sample_n()` or `sample_frac()`) or when there is no clear negation (as with `jn.general::view_duplicated()`). 

A simple solution is to use the function `jn.general::to_be()`, which returns both the subsetted and the anti-subsetted data. It is available in the [jn.general package][package_link]{:target="blank"}.

# To Be or Not To Be

The function `to_be()` is quite simple when broken down. 

The parameters include

* A data.frame
* A subsetting function
* Any additional arguments to be passed to the subset function

After performing the subset operations, `to_be()` returns a list of two objects

* A data.frame "to_be": the resulting data.frame when the subset function is applied to the input data
* A data.frame "not_to_be": the anti-subset, the opposite of the subset operation

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
by_both[["not_to_be"]] %>% head(10)
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
   <td style="text-align:right;"> 3.44 </td>
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
   <td style="text-align:right;"> 3.46 </td>
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
   <td style="text-align:right;"> 3.57 </td>
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
   <td style="text-align:right;"> 3.44 </td>
   <td style="text-align:right;"> 18.30 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
</tbody>
</table>
</div>

# Challenge Round
Let's do something a little more challenging to see `to_be` in action. With this data set, remove the duplicated id entries by hand and merge them back into the non-duplicates. 

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
result <- to_be(data, view_duplicated, id)
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

Keep the id that corresponds to a female or someone greater than 50 years old.

{% highlight r %}
result[["to_be"]] %>% arrange(gender, desc(age)) %>% group_by(id) %>% slice(1)
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
# obtain the duplicated entries
result[["to_be"]] %>% 
  # order by gender (females first) and decreasing age
  arrange(gender, desc(age)) %>% 
  # group by unique id's
  group_by(id) %>% 
  # take the first entry in each group
  do(slice(.,1)) %>% 
  # combine results with non-duplicated data
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

[package_link]: https://github.com/jnguyen92/jn.general
