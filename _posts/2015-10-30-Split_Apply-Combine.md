---
layout: post
title: "Split Apply Combine"
date: "October 30, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}



Say we are given a data set where we want to group by a given category and compute summary statistics based on that category. The general process is

1. Split: split by the variable
2. Apply: apply the function to each split
3. Combine: combine the results back into a single data structure

Collectively this is known as split-apply-combine.

# Example Data

{% highlight text %}
## Error: Invalid column specification
{% endhighlight %}



{% highlight text %}
## Error in setkeyv(x, cols, verbose = verbose, physical = physical): x is not a data.table
{% endhighlight %}

This is the example data set we will use.

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> teacher_id </th>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> weight </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_score </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 573 </td>
   <td style="text-align:center;"> 0.9293 </td>
   <td style="text-align:center;"> -0.7559 </td>
   <td style="text-align:center;"> -1.1649 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 166 </td>
   <td style="text-align:center;"> 0.3118 </td>
   <td style="text-align:center;"> 0.5962 </td>
   <td style="text-align:center;"> 1.6599 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 864 </td>
   <td style="text-align:center;"> 0.4707 </td>
   <td style="text-align:center;"> -0.6355 </td>
   <td style="text-align:center;"> -0.3411 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 480 </td>
   <td style="text-align:center;"> 0.0622 </td>
   <td style="text-align:center;"> -0.7151 </td>
   <td style="text-align:center;"> -0.7435 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 989 </td>
   <td style="text-align:center;"> 0.6870 </td>
   <td style="text-align:center;"> 1.7636 </td>
   <td style="text-align:center;"> -0.6811 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
</tbody>
</table>
</div>

# Using Apply Functions

The two main functions here are `split()` and `llply()`. 

Let's compute the mean posttest & pretest score for males and females for each grade and subject.

{% highlight r %}
class %>% 
  # split: by the subject, grade, and gender
  split(interaction(class$d_gender, class$grade, class$subject)) %>% 
  # apply: compute mean posttest & pretest score for each split
  llply(function(x){
    data.frame(descr = unique(paste(x$subject, x$grade, x$d_gender)), 
               post = mean(x$posttest_score), 
               pre = mean(x$pretest_score))
  }) %>% 
  # combine: rbind the results together as a vector
  rbindlist()
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> descr </th>
   <th style="text-align:center;"> post </th>
   <th style="text-align:center;"> pre </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math 11 female </td>
   <td style="text-align:center;"> -0.1455 </td>
   <td style="text-align:center;"> -0.0367 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math 11 male </td>
   <td style="text-align:center;"> -0.0726 </td>
   <td style="text-align:center;"> -0.0445 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math 12 female </td>
   <td style="text-align:center;"> 0.0673 </td>
   <td style="text-align:center;"> -0.0867 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math 12 male </td>
   <td style="text-align:center;"> -0.0415 </td>
   <td style="text-align:center;"> -0.0886 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 11 female </td>
   <td style="text-align:center;"> 0.0377 </td>
   <td style="text-align:center;"> 0.0468 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 11 male </td>
   <td style="text-align:center;"> 0.0000 </td>
   <td style="text-align:center;"> 0.0473 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 12 female </td>
   <td style="text-align:center;"> -0.0614 </td>
   <td style="text-align:center;"> 0.0253 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 12 male </td>
   <td style="text-align:center;"> 0.0350 </td>
   <td style="text-align:center;"> -0.1185 </td>
  </tr>
</tbody>
</table>
</div>

# Using dplyr
The dplyr package provides a easier framework to split data, apply functions, and combine results.

## summarise
The `summarise()` function summarises data into a single row of values. 

Let's count the number of males and females in each grade and subject.

{% highlight r %}
class %>% 
  # split: by subject & grade
  group_by(subject, grade) %>%
  # apply: count functions
  summarise(
    n_students = n(),
    n_male = sum(d_gender == "male"),
    n_female = sum(d_gender == "female")
  )
  # combine: dplyr does this automatically
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> n_students </th>
   <th style="text-align:center;"> n_male </th>
   <th style="text-align:center;"> n_female </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 256 </td>
   <td style="text-align:center;"> 122 </td>
   <td style="text-align:center;"> 134 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 255 </td>
   <td style="text-align:center;"> 124 </td>
   <td style="text-align:center;"> 131 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 246 </td>
   <td style="text-align:center;"> 126 </td>
   <td style="text-align:center;"> 120 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 243 </td>
   <td style="text-align:center;"> 116 </td>
   <td style="text-align:center;"> 127 </td>
  </tr>
</tbody>
</table>
</div>

## mutate
The `mutate()` function makes a new columns and appends them to the data frame. It can be used for SAC or just to generate new columns on the fly.


{% highlight r %}
# make new columns
class %>% 
  mutate(
    # current year
    year = 2015,
    # gives a score of proficient if posttest score is in the top quantile
    proficient = ifelse(posttest_score > quantile(posttest_score)[4], "proficient", "not_proficient")
  ) %>% 
  colnames
{% endhighlight %}



{% highlight text %}
##  [1] "teacher_id"     "student_id"     "weight"        
##  [4] "posttest_score" "pretest_score"  "grade"         
##  [7] "subject"        "d_gender"       "d_black"       
## [10] "d_hispanic"     "d_asian"        "d_native"      
## [13] "year"           "proficient"
{% endhighlight %}

As an artificial example, let's standardize the posttest scores by grade and subject. 


These are the means and standard deviations before standardizing.

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> mean </th>
   <th style="text-align:center;"> sd </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.1108 </td>
   <td style="text-align:center;"> 1.003 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 0.0144 </td>
   <td style="text-align:center;"> 1.024 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0.0184 </td>
   <td style="text-align:center;"> 1.057 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -0.0154 </td>
   <td style="text-align:center;"> 1.021 </td>
  </tr>
</tbody>
</table>
</div><p></p>

{% highlight r %}
# standardize by grade & subject
class <- class %>% 
  # split: by grade & subject
  group_by(subject, grade) %>% 
  # apply: standardize the posttest score
  mutate(z_post = (posttest_score - mean(posttest_score)) / sd(posttest_score))
  # combine: dplyr does this automatically
{% endhighlight %}

These are the means and standard deviations after standardizing.

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> mean </th>
   <th style="text-align:center;"> sd </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div>

## summarise_each and mutate_each 
The `summarise_each()` and `mutate_each()` allows you to simultaneous apply a function to all columns at once. It is insanely convenient and efficient.

A few notes:

* wrap functions in `funs()`
* for functions with additional arguments, do `funs(my_func(., addnl_args))`
* by default these functions will be applied to all columns; to specify or despecify columns `dplyr::select` special functions can be used after the `funs()` argument

Let's convert all the boolean variables to numeric variables. 
{% highlight r %}
class %>% 
  # select the boolean variables
  dplyr::select(starts_with("d_"), -d_gender) %>% 
  # convert all columns to numeric
  mutate_each(funs(as.numeric)) %>% 
  # print
  head
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div><p></p>

How about something a little more complicated? Let's group by teacher and compute the weighted means of all our numeric variables, using the provided weights. (Note that I made a little change to d_gender prior these calculations, splitting them into the boolean columns of d_gender_m and d_gender_f).

{% highlight r %}
class %>% 
  # split: by teacher
  group_by(teacher_id) %>% 
  # apply: weighted mean using weights on numeric columns
  summarise_each(funs(weighted.mean(., weight)), -student_id, -weight, -subject, -grade) %>% 
  # combine: dplyr does this automatically
  head()
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> teacher_id </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_score </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
   <th style="text-align:center;"> d_gender_f </th>
   <th style="text-align:center;"> d_gender_m </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0.0939 </td>
   <td style="text-align:center;"> -0.2635 </td>
   <td style="text-align:center;"> 0.2028 </td>
   <td style="text-align:center;"> 0.1550 </td>
   <td style="text-align:center;"> 0.2102 </td>
   <td style="text-align:center;"> 0.1535 </td>
   <td style="text-align:center;"> 0.5230 </td>
   <td style="text-align:center;"> 0.4770 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> -0.0166 </td>
   <td style="text-align:center;"> 0.0116 </td>
   <td style="text-align:center;"> 0.3079 </td>
   <td style="text-align:center;"> 0.1636 </td>
   <td style="text-align:center;"> 0.2652 </td>
   <td style="text-align:center;"> 0.2538 </td>
   <td style="text-align:center;"> 0.3892 </td>
   <td style="text-align:center;"> 0.6108 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0.0858 </td>
   <td style="text-align:center;"> 0.2858 </td>
   <td style="text-align:center;"> 0.1215 </td>
   <td style="text-align:center;"> 0.2372 </td>
   <td style="text-align:center;"> 0.1140 </td>
   <td style="text-align:center;"> 0.2828 </td>
   <td style="text-align:center;"> 0.7434 </td>
   <td style="text-align:center;"> 0.2566 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> -0.0043 </td>
   <td style="text-align:center;"> -0.0057 </td>
   <td style="text-align:center;"> 0.2619 </td>
   <td style="text-align:center;"> 0.1414 </td>
   <td style="text-align:center;"> 0.2204 </td>
   <td style="text-align:center;"> 0.2401 </td>
   <td style="text-align:center;"> 0.4237 </td>
   <td style="text-align:center;"> 0.5763 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> -0.0622 </td>
   <td style="text-align:center;"> 0.0285 </td>
   <td style="text-align:center;"> 0.1725 </td>
   <td style="text-align:center;"> 0.1368 </td>
   <td style="text-align:center;"> 0.1862 </td>
   <td style="text-align:center;"> 0.1801 </td>
   <td style="text-align:center;"> 0.4066 </td>
   <td style="text-align:center;"> 0.5934 </td>
  </tr>
</tbody>
</table>
</div>

## do
Sometimes `summarise()` and `mutate()` just isn't enough. Luckily, there is a function `do()` that is perfect for these scenarios. 

In our data set we have unique student-teacher linkages for each unique subject and grade combination. However, when we ignore subject and grade, we may have duplicated linkages. 


{% highlight r %}
class %>%
  # subset to the duplicates
  view_duplicated(student_id, teacher_id) %>% 
  # subset to the unique linkages that are duplicated
  distinct(student_id, teacher_id) %>% 
  # find the number of duplicated linkages
  nrow
{% endhighlight %}



{% highlight text %}
## [1] 34
{% endhighlight %}

Ignoring the subject and grade, we want to remove the the linkage with the smallest weight. 

{% highlight r %}
class_edit <-  class %>%
  # order descending by weight
  arrange(desc(weight)) %>% 
  # split: by student teacher linkage
  group_by(student_id, teacher_id) %>%
  # apply: extract the first row from each split
  do(extract(., 1, )) 
  # combine: dplyr does this automatically
class_edit %>% head
{% endhighlight %}

<div class = "dftab">

{% highlight text %}
## Error: Invalid column specification
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'class_edit' not found
{% endhighlight %}
</div><p></p>

And here we see that those duplicates were indeed removed.

{% highlight r %}
class_edit %>%
  # subset to the duplicates
  view_duplicated(student_id, teacher_id) %>% 
  # subset to the unique linkages that are duplicated
  distinct(student_id, teacher_id) %>% 
  # find the number of duplicated linkages
  nrow
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'class_edit' not found
{% endhighlight %}

`do()` is versatile because it can handle a variety of different output types. 

Here I create summary tables of posttest_score regressed against pretest_score for each unique combination of subject and grade. 

{% highlight r %}
class %>% 
  # split: by subject and grade
  group_by(subject, grade) %>% 
  # apply: regression model on splits
  # combine: dplyr does this automatically
  do(model = lm(posttest_score ~ pretest_score, data = .))
{% endhighlight %}



{% highlight text %}
## Source: local data frame [4 x 3]
## Groups: <by row>
## 
##   subject grade   model
##    (fctr) (int)   (chr)
## 1    math    11 <S3:lm>
## 2    math    12 <S3:lm>
## 3    read    11 <S3:lm>
## 4    read    12 <S3:lm>
{% endhighlight %}

This output isn't too meaningful, so we can use the `broom` package to extract more useful output.


{% highlight r %}
class %>% 
  # split: by subject and grade
  group_by(subject, grade) %>% 
  # apply: regression model on splits
  # combine: the model coefficients
  do(tidy(lm(posttest_score ~ pretest_score, data = .)))
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> term </th>
   <th style="text-align:center;"> estimate </th>
   <th style="text-align:center;"> std.error </th>
   <th style="text-align:center;"> statistic </th>
   <th style="text-align:center;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> (Intercept) </td>
   <td style="text-align:center;"> -0.1128 </td>
   <td style="text-align:center;"> 0.0628 </td>
   <td style="text-align:center;"> -1.7965 </td>
   <td style="text-align:center;"> 0.0736 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> -0.0501 </td>
   <td style="text-align:center;"> 0.0613 </td>
   <td style="text-align:center;"> -0.8161 </td>
   <td style="text-align:center;"> 0.4152 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> (Intercept) </td>
   <td style="text-align:center;"> 0.0161 </td>
   <td style="text-align:center;"> 0.0644 </td>
   <td style="text-align:center;"> 0.2503 </td>
   <td style="text-align:center;"> 0.8025 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> 0.0195 </td>
   <td style="text-align:center;"> 0.0581 </td>
   <td style="text-align:center;"> 0.3361 </td>
   <td style="text-align:center;"> 0.7371 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> (Intercept) </td>
   <td style="text-align:center;"> 0.0165 </td>
   <td style="text-align:center;"> 0.0675 </td>
   <td style="text-align:center;"> 0.2448 </td>
   <td style="text-align:center;"> 0.8068 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> 0.0395 </td>
   <td style="text-align:center;"> 0.0618 </td>
   <td style="text-align:center;"> 0.6395 </td>
   <td style="text-align:center;"> 0.5231 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> (Intercept) </td>
   <td style="text-align:center;"> -0.0185 </td>
   <td style="text-align:center;"> 0.0655 </td>
   <td style="text-align:center;"> -0.2824 </td>
   <td style="text-align:center;"> 0.7779 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> -0.0724 </td>
   <td style="text-align:center;"> 0.0631 </td>
   <td style="text-align:center;"> -1.1475 </td>
   <td style="text-align:center;"> 0.2523 </td>
  </tr>
</tbody>
</table>
</div><p></p>

# Using data.table
The data.table package has optimized data frames to be able to handle large amounts of data. 

Let's split by grade and subject and count the number of males and females in each grade and subject. This is equivalent to using `summmarise()`.

{% highlight r %}
# make a data table
classDT <- data.table(class)
# split by subject & grade and compute the total number of students
classDT[, list(total_students = .N), by = list(subject, grade)]
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> n_students </th>
   <th style="text-align:center;"> n_male </th>
   <th style="text-align:center;"> n_female </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 255 </td>
   <td style="text-align:center;"> 124 </td>
   <td style="text-align:center;"> 131 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 246 </td>
   <td style="text-align:center;"> 126 </td>
   <td style="text-align:center;"> 120 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 256 </td>
   <td style="text-align:center;"> 122 </td>
   <td style="text-align:center;"> 134 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 243 </td>
   <td style="text-align:center;"> 116 </td>
   <td style="text-align:center;"> 127 </td>
  </tr>
</tbody>
</table>
</div><p></p>

Now let's standardize the posttest scores by grade and subject. This is equivalent to `mutate()`.

{% highlight r %}
# split by subject & grade and standardize
classDT[, z_post := (posttest_score - mean(posttest_score)) / sd(posttest_score), by = list(subject, grade)]

# summarise results to see effect
classDT[, list(mean = mean(z_post), sd = sd(post)), by = list(subject, grade)]
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> mean </th>
   <th style="text-align:center;"> sd </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div>
