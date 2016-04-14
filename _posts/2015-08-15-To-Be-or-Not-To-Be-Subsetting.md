---
title: "To Be or Not To Be: Subsetting (R)"
layout: post
categories: ['r programming']
---

* TOC
{:toc}



# Subsetting Functions in R

In a previous post, I dicussed the subsetting functions available via the dplyr package, including the `filter()`, `slice()`, and `select()` functions. There are a number of additional ways to subset data frames in R. 

However what if rather than tossing the data that does not correspond to the subset (call it the "anti-subset"), we wanted to keep it? Say perhaps, we want to subset, perform a sequence of operations, and then somehow relate the two to each other. One could easily subset two times, once with the condition and again with the negation. However in some cases, obtaining the anti-subset isn't all that straight forward. For example what if the subset was obtained randomly, as with functions like `sample_n()` or `sample_frac()`, or when there is no clear negation, such as `view_duplicated()`?

Having faced this issue many times, I wrote the `to_be()` function as a way to obtain both the subsetted data and the "anti-subset". It is available in the [jn.general package][package_link]{:target="blank"}.

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
Let’s do something a little more challenging to see to_be in action. With this data set, we want to remove the duplicated id entries by hand and merge them back into the non-duplicates. 

<div class = "dftab">

{% highlight text %}
## Error in loadNamespace(name): there is no package called 'pryr'
{% endhighlight %}



{% highlight text %}
## Warning in rep(digits, length.out = m): first element used of
## 'length.out' argument
{% endhighlight %}



{% highlight text %}
## Warning in seq_len(m): first element used of 'length.out' argument
{% endhighlight %}



{% highlight text %}
## Error in seq_len(m): argument must be coercible to non-negative integer
{% endhighlight %}
</div><p></p>


{% highlight r %}
result <- to_be(data, view_duplicated, id)
{% endhighlight %}



{% highlight text %}
## Error in to_be(data, view_duplicated, id): Input x must be a data frame
{% endhighlight %}

The duplicated id entries:

{% highlight r %}
result[["to_be"]]
{% endhighlight %}
<div class = "dftab">

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'result' not found
{% endhighlight %}



{% highlight text %}
## Error in rownames(x) <- NULL: object 'x' not found
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'x' not found
{% endhighlight %}
</div><p></p>

The non-duplicated id entries:

{% highlight r %}
result[["not_to_be"]]
{% endhighlight %}
<div class = "dftab">

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'result' not found
{% endhighlight %}



{% highlight text %}
## Error in rownames(y) <- NULL: object 'y' not found
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'y' not found
{% endhighlight %}
</div><p></p>

From the duplicated id's, I'll keep the id that corresponds to a female or, if none of the duplicated entries are female, an id corresponding to someone greater than 50 years old. 

{% highlight r %}
result[["to_be"]] %>% arrange(gender, desc(age)) %>% group_by(id) %>% slice(1)
{% endhighlight %}
<div class = "dftab">

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'x' not found
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'z' not found
{% endhighlight %}
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

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'result' not found
{% endhighlight %}



{% highlight text %}
## Error in rownames(a) <- NULL: object 'a' not found
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'a' not found
{% endhighlight %}
</div>

[package_link]: https://github.com/jnguyen92/jn.general
