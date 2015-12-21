---
layout: post
title: "Subsetting With dplyr (R)"
date: "August 1, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}


{% highlight text %}
## Warning: replacing previous import by 'grid::arrow' when loading
## 'GGally'
{% endhighlight %}



{% highlight text %}
## Warning: replacing previous import by 'grid::unit' when loading
## 'GGally'
{% endhighlight %}

Cleaning data can be tedious and annoying, but data rarely ever comes in a tidy, nicely packaged with a bow on top form. In order to get the data in a form that we want, we often need to slice and dice the data in various ways. Luckily, the dplyr package, created by Hadley Wickham, provides some handy tools to subset and select with ease.   
In this post, I will outline the subsetting functions available through dplyr and explain how and when I use them. In addition, I make use of magrittr's piping function, which can combine a complicated sequence of logic into a code chain that is easier to read. More information about magrittr can be found on the [magrittr vignette][magrittr_link]{:target="blank"}.

{% highlight r %}
library(dplyr)
library(magrittr)
{% endhighlight %}

# Example Data
Let's generate some random data to use with dplyr. The random generator function is available via the [jn.general package][jn.general_link]{:target="blank"}.


{% highlight r %}
set.seed(1)
data <- jn.general::rdata(n = 750,
              # posttests
              gen_seq(0, 100, length.out = 40, name = "posttest_score"),
              gen_subject(name = "posttest_subject"),
              gen_seq(10, 12, name = "posttest_grade"),
              # pretests
              gen_char(name = "pretest_7_name", values = "ACT"),
              gen_char(name = "pretest_8_name", values = "Math222"),
              gen_char(name = "pretest_9_name", values = "SAT"),
              gen_char(name = "pretest_10_name", values = "CompSci367"),
              gen_char(name = "pretest_11_name", values = c("ACT", "SAT")),
              gen_seq(0, 100, length.out = 40, ncol = 5, name = paste0("pretest_", 7:11, "_score"), add.na = TRUE),
              gen_seq(8, 11, ncol = 5, name = paste0("pretest_", 7:11, "_grade")),
              gen_char(ncol = 5, name = paste0("pretest_", 7:11, "_version"), values = LETTERS[1:3]),
              # demographics
              gen_gender(name = "d_gender"),
              gen_bool(ncol = 4, name = c("d_black", "d_hispanic", "d_asian", "d_native"), add.na = TRUE, probs = c(0.15, 0.8, 0.05)),
              gen_bool(ncol = 1, name = "d_gifted", probs = c(0.25, 0.25, 0.5), add.na = TRUE), 
              # student id
              .id = FALSE
              )
data %<>% group_by(posttest_subject) %>% mutate(student_id = 1:n()) %>% data.frame
# formatting
data %<>% select(student_id, matches("posttest"), matches("pretest"), matches("d_"))
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_10_name </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_10_grade </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_10_version </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gifted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> 79.487179 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> ss </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> 71.794872 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 56.41026 </td>
   <td style="text-align:center;"> science </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 66.666667 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> 94.871795 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>



# dplyr::slice() and dplyr::filter()
There are a number of functions that allow for rowise manipulation in dplyr, two of which are `dplyr::filter()` and `dplyr::slice()`. 

## Subsetting rows by conditional expression
The `dplyr::filter()` function takes logical conditions as arguments. If multiple conditions are supplied as arguments (via `','`), they are combined with `&`. Thus `or` arguments should be supplied within one condition with `|`. 

{% highlight r %}
# subset to students with posttest math scores over 75 and are in the 10th grade
data %>% filter(posttest_grade == 10, posttest_subject == "math", posttest_score > 75) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_10_name </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_10_grade </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_10_version </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gifted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 87.17949 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 76.923077 </td>
   <td style="text-align:center;"> 33.33333 </td>
   <td style="text-align:center;"> 53.84615 </td>
   <td style="text-align:center;"> 46.15385 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 10.256410 </td>
   <td style="text-align:center;"> 71.79487 </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 55 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 2.564103 </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 33.33333 </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 62 </td>
   <td style="text-align:center;"> 76.92308 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 64.10256 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 53.84615 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 64 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 71.79487 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 94.87179 </td>
   <td style="text-align:center;"> 12.82051 </td>
   <td style="text-align:center;"> 71.79487 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
  </tr>
</tbody>
</table>
</div><p></p>

## Subsetting rows by row position
The `dplyr::slice()` function allows rows to be extracted by position.

{% highlight r %}
# extract the 25th-30th students in the data set
data %>% slice(25:30)
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_10_name </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_10_grade </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_10_version </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gifted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> science </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 10.25641 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 97.435897 </td>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> 10.25641 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 38.46154 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 28.20513 </td>
   <td style="text-align:center;"> 15.38462 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> 0.00000 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 0.00000 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 58.97436 </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 82.051282 </td>
   <td style="text-align:center;"> 28.20513 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 38.46154 </td>
   <td style="text-align:center;"> ss </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 12.82051 </td>
   <td style="text-align:center;"> 94.87179 </td>
   <td style="text-align:center;"> 33.333333 </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 87.17949 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 53.84615 </td>
   <td style="text-align:center;"> 53.846154 </td>
   <td style="text-align:center;"> 46.15385 </td>
   <td style="text-align:center;"> 64.10256 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 33.33333 </td>
   <td style="text-align:center;"> ss </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> 0.00000 </td>
   <td style="text-align:center;"> 87.179487 </td>
   <td style="text-align:center;"> 61.53846 </td>
   <td style="text-align:center;"> 94.87179 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
</tbody>
</table>
</div><p></p>

In terms of subsetting by rows, dplyr's filter function is  equivalent to base R's subset function. 

# dplyr::select()
The `dplyr::select()` function selects columns from a data set. To deselect columns, simply place a `-` before the name or special function call. 

## Select columns by name
Selecting columns by name is easy; just write out the name of the column(s), separated by commas - no need to wrap names with quotations or in a vector.  

{% highlight r %}
# select multiple columns by name
data %>% dplyr::select(posttest_score, posttest_grade, d_gender, posttest_subject) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> posttest_subject </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> read </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> ss </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 56.41026 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> science </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> math </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> read </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# deselect multiple columns by name
data %>% dplyr::select(-posttest_score, -posttest_grade, -posttest_subject) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_10_name </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_10_grade </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_10_version </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gifted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> 79.487179 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> 71.794872 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 66.666667 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> 94.871795 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>

## Select columns by numeric position or column name

Say we want to extract columns from a data frame using a vector of column names or positions. For this example, let's try to select the demographics columns corresponding to race. 

For numeric position values, just pass the vector as an argument to the select function.

{% highlight r %}
# select based on column position
var_pos <- 25:29 
data %>% dplyr::select(var_pos) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>

For character names, wrap the helper function `one_of()` around the character vector and pass this to the select function.

{% highlight r %}
# select based on column name
var_names <- c("d_black", "d_hispanic", "d_asian", "d_native")
data %>% dplyr::select(one_of(var_names)) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>

## Select columns using regex

Helper functions such as `matches()`, `starts_with()`, and `ends_with()` are perhaps the most powerful feature of the select function. For example, let's start with extracting the pretest score columns. 

See the [regular expression post][regex_link]{:target="blank"} for more on regex. Notice that this method is generic (no matter what the pretest number it will qualify) and reuseable. 

{% highlight r %}
# use matches to find all pretest score columns
data %>% dplyr::select(matches("pretest_\\d+_score")) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> 79.487179 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> 71.794872 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 66.666667 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> 7.692308 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> 94.871795 </td>
  </tr>
</tbody>
</table>
</div><p></p>

The helper functions `starts_with()` and `ends_with()` are similar to `matches()` but is specialized in that it only looks at the beginning or the end of the string for a pattern match.

Let's use `starts_with()` and `ends_with()` to extract (1) all posttest information and (2) all test score columns.

{% highlight r %}
# extract all posttest information
data %>% dplyr::select(starts_with("posttest")) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> posttest_grade </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> ss </td>
   <td style="text-align:center;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 56.41026 </td>
   <td style="text-align:center;"> science </td>
   <td style="text-align:center;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 10 </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# extract all test score columns
data %>% dplyr::select(ends_with("_score")) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> 79.487179 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> 71.794872 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 56.41026 </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 66.666667 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> 7.692308 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> 94.871795 </td>
  </tr>
</tbody>
</table>
</div><p></p>

For added functionality, the `matches()`, `starts_with()`, and `ends_with()` function works even when the regex string is stored as a variable. This tends to be useful when developing functions that runs on any data set, where the regex string can be passed as a parameter. 

## Combining selection techniques
Finally let's select multiple columns using a variety of the select methods we just learned. Simply separate out each call with a comma; use `-` to deselect columns.

{% highlight r %}
# select multiple columns
data %>% dplyr::select(student_id, matches("pretest_\\d+_score"), d_gender, starts_with("d_")) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gifted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> 79.487179 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> 71.794872 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> 66.666667 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> 94.871795 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# select all pretest info and then deselect pretest 10 info
no_good <- paste0("pretest_10_", c("name", "score", "version", "grade"))
data %>% dplyr::select(student_id, starts_with("pretest_"), -one_of(no_good)) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_11_version </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 79.487179 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 71.794872 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 66.666667 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 94.871795 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
  </tr>
</tbody>
</table>
</div><p></p>


Sometimes when I have very wide data, I use `dplyr::select()` to roughly reorganize columns. This is pretty handy, especially if I eventually have to save results in a csv file for review at a later time.

{% highlight r %}
# shuffle up column positions
order <- sample(1:ncol(data))
unorganized_data <- dplyr::select(data, order)

# organize columns: id, then posttest info, pretest info, demographics info
unorganized_data %>% dplyr::select(student_id, matches("posttest"), matches("pretest"), d_gender, d_gifted, everything()) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> pretest_10_name </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_10_version </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_10_grade </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_gifted </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_asian </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 79.487179 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> ss </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 71.794872 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 56.41026 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> science </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 66.666667 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 94.871795 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>

When reorganizing columns, if the selectors are too specific, you run the risk of losing data. This is where the helper function `everything()` can be useful; `everything()` selects all variables. Including `everything()` at the end of the selection specifications ensures that columns that aren't accounted for in the ordering are included in the returned data frame. 
To move columns to the end of the list, deselect the column and then include `everything()`. 

{% highlight r %}
# move demographic information to the furthest right
unorganized_data %>% dplyr::select(-starts_with("d_"), everything()) %>% head
{% endhighlight %}
<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> pretest_10_name </th>
   <th style="text-align:center;"> pretest_8_score </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_8_name </th>
   <th style="text-align:center;"> pretest_10_version </th>
   <th style="text-align:center;"> pretest_8_grade </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> pretest_10_score </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_10_grade </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_8_version </th>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_gifted </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_asian </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 28.205128 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 79.487179 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 89.74359 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 82.05128 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 43.589744 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 71.794872 </td>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 43.58974 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> ss </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 12.820513 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 66.666667 </td>
   <td style="text-align:center;"> 56.41026 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 51.28205 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 23.07692 </td>
   <td style="text-align:center;"> science </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 48.717949 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 7.692308 </td>
   <td style="text-align:center;"> 92.30769 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 30.76923 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> CompSci367 </td>
   <td style="text-align:center;"> 5.128205 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> Math222 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 94.871795 </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 25.64103 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div><p></p>

Overall, I think dplyr's `select()` function is very useful when doing data work. Columns can be selected easily without having to wrap column names in quotations or `c()`, unlike base R's subset function. Deselecting is more consistent with the simple `-` negation, and matching column groups are much simpler with the help of special functions. 

# Challenge round
Let's do something a little more challenging to see the power of dplyr. We want to clean up this data set to remove all pretest information that does not correspond to the ACT or SAT. In addition, we only want information regarding to students who took the math or reading posttest in the 12th grade. 


{% highlight r %}
# grade and subject query of interest
grade_query <- 12
subject_query <- c("math", "read")

# obtains pretest number corresponding to pretests of the ACT and SAT category
pretest_numbers <- data %>% 
  # select all pretest columns
  dplyr::select(matches("pretest_\\d+_name")) %>% 
  # obtain unique test names per column
  apply(2, unique) %>% 
  # filter to elements that contain either ACT or SAT
  jn.general::refine(function(x) any(str_detect(x, "ACT|SAT"))) %>% 
  # obtain the names
  names %>% 
  # extract the pretest number
  str_extract("\\d+") 

# generates the names of the pretest information 
## matches doesn't allow multiple matches so we have to regenerate the names of the pretests information
pretests_of_interest <- paste0("pretest_", pretest_numbers) %>% 
  # interact the pretest names with the values name score and grade
  interaction(c("name", "score", "grade", "version"), sep = "_") %>% 
  # extract the unique names
  levels

# selects posttest, ACT/SAT pretests, demographics and subsets by the grade/subject of interest
final <- data %>% 
  dplyr::select(student_id, starts_with("posttest_"), one_of(pretests_of_interest), starts_with("d_")) %>% 
  dplyr::filter(posttest_grade %in% grade_query, posttest_subject %in% subject_query)
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> posttest_subject </th>
   <th style="text-align:center;"> posttest_grade </th>
   <th style="text-align:center;"> pretest_11_grade </th>
   <th style="text-align:center;"> pretest_7_grade </th>
   <th style="text-align:center;"> pretest_9_grade </th>
   <th style="text-align:center;"> pretest_11_name </th>
   <th style="text-align:center;"> pretest_7_name </th>
   <th style="text-align:center;"> pretest_9_name </th>
   <th style="text-align:center;"> pretest_11_score </th>
   <th style="text-align:center;"> pretest_7_score </th>
   <th style="text-align:center;"> pretest_9_score </th>
   <th style="text-align:center;"> pretest_11_version </th>
   <th style="text-align:center;"> pretest_7_version </th>
   <th style="text-align:center;"> pretest_9_version </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gifted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 94.87179 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 20.51282 </td>
   <td style="text-align:center;"> 17.94872 </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 15.38462 </td>
   <td style="text-align:center;"> 35.89744 </td>
   <td style="text-align:center;"> 28.20513 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 38.46154 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 33.33333 </td>
   <td style="text-align:center;"> 84.61538 </td>
   <td style="text-align:center;"> 100.00000 </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 76.92308 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 48.71795 </td>
   <td style="text-align:center;"> 94.87179 </td>
   <td style="text-align:center;"> 53.84615 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> A </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 66.66667 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> ACT </td>
   <td style="text-align:center;"> SAT </td>
   <td style="text-align:center;"> 69.23077 </td>
   <td style="text-align:center;"> 41.02564 </td>
   <td style="text-align:center;"> 10.25641 </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> C </td>
   <td style="text-align:center;"> B </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
</tbody>
</table>
</div><p></p>

Note: The `jn.general::refine()` function used here is a wrapper function for `Filter()`. 



# Additional Resources
Subsetting functions are only a fraction of what the dplyr package offers for data work. Here are a few links to the additional resources on the dplyr package:  
[dplyr cheatsheet][dplyr_cheatsheet_link]{:target="blank"}

[magrittr_link]: https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html
[jn.general_link]: https://github.com/jnnguyen2/jn.general
[regex_link]: http://jnguyen92.github.io/nhuyhoa//2015/07/Regular-Expressions.html
[dplyr_cheatsheet_link]: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
