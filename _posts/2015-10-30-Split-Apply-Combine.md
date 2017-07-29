---
layout: post
title: "Split Apply Combine"
date: "October 30, 2015"
categories: ['data wrangling']
---

* TOC
{:toc}


{% highlight text %}
## Warning in `[.data.table`(., , `:=`((args), TRUE), with = FALSE):
## with=FALSE ignored, it isn't needed when using :=. See ?':=' for
## examples.
{% endhighlight %}

Obtaining summary statistics for a given group can be done using the general process:

1. Split: split by the variable
2. Apply: apply the function to each split
3. Combine: combine the results back into a single data structure

Collectively this is known as split-apply-combine.

# In R



The example data set:

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> teacher_id </th>
   <th style="text-align:center;"> weight </th>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_score </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 100 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 0.9692 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -2.1143 </td>
   <td style="text-align:center;"> -0.0226 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 101 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0.1913 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -0.4224 </td>
   <td style="text-align:center;"> 0.8057 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 0.7622 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7631 </td>
   <td style="text-align:center;"> 0.1451 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 0.9347 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -1.4334 </td>
   <td style="text-align:center;"> 0.9452 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 103 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0.7774 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7721 </td>
   <td style="text-align:center;"> 0.5730 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
</tbody>
</table>
</div>

## Using Apply Functions

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

## Using dplyr

### slice
The `slice()` function can be used to obtain records by row index. For example, to obtain the records of the maximum test score for various subgroups. 


{% highlight r %}
class %>% 
  # split: subject and grade
  group_by(subject, grade) %>% 
  # apply: obtain records that correspond to the highest posttest score
  slice(which.max(posttest_score))
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> teacher_id </th>
   <th style="text-align:center;"> weight </th>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_score </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 601 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0.1050 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2.676 </td>
   <td style="text-align:center;"> -1.6189 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 156 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 0.4288 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2.446 </td>
   <td style="text-align:center;"> 1.2828 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 521 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0.5170 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2.351 </td>
   <td style="text-align:center;"> -0.1639 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 356 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 0.4526 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3.810 </td>
   <td style="text-align:center;"> 2.3506 </td>
   <td style="text-align:center;"> female </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
</tbody>
</table>
</div>

### summarise
The `summarise()` function summarises data into a single row of values. 

Let's count the number of males and females in each grade and subject.


{% highlight r %}
class %>% 
  # split: by subject & grade
  group_by(subject, grade) %>%
  # apply: count functions
  # combine: dplyr does this automatically
  summarise(
    n_students = n(),
    n_male = sum(d_gender == "male"),
    n_female = sum(d_gender == "female")
  ) 
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

### mutate
The `mutate()` function makes a new columns and appends them to the data frame. It can be used for SAC or just to generate new columns on the fly.


{% highlight r %}
# make new columns
class %>% 
  mutate(
    # current year
    year = 2015,
    # gives a score of proficient if posttest score is in the top quantile
    proficient = ifelse(posttest_score > quantile(posttest_score, 0.75), "proficient", "not_proficient")
  ) %>% 
  colnames %>% 
  tail
{% endhighlight %}



{% highlight text %}
## [1] "d_black"    "d_hispanic" "d_asian"    "d_native"   "year"      
## [6] "proficient"
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
  # combine: dplyr does this automatically
  mutate(z_post = (posttest_score - mean(posttest_score)) / sd(posttest_score))
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

### summarise_all and mutate_all 
The `summarise_all()` and `mutate_all()` simultaneously applies a function to all columns at once. 

A few notes:

* wrap functions in `funs()`
* for functions with additional arguments, do `funs(my_func(., addnl_args))`
* to apply a function to select variables with the functions `summarise_at()` and `mutate_at()`
* to apply a function to variables that satisfy certain conditions with the functions `summarise_if()` and `mutate_if()`

Let's convert all the boolean variables to numeric variables. 

{% highlight r %}
class %>% 
  # convert all boolean vars to numeric
  mutate_if(is.logical, as.numeric) %>% 
  # print
  head
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> teacher_id </th>
   <th style="text-align:center;"> weight </th>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_score </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 100 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 0.9692 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -2.1143 </td>
   <td style="text-align:center;"> -0.0226 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 101 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0.1913 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -0.4224 </td>
   <td style="text-align:center;"> 0.8057 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 0.7622 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7631 </td>
   <td style="text-align:center;"> 0.1451 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 0.9347 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -1.4334 </td>
   <td style="text-align:center;"> 0.9452 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 103 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0.7774 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7721 </td>
   <td style="text-align:center;"> 0.5730 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div><p></p>

### do and unnest
`do()` is versatile because it can handle a variety of different output types. 

In the example data set, there are unique student-teacher linkages for each unique subject and grade combination. However ignoring subject and grade, there may be  duplicated linkages. 


{% highlight text %}
## [1] 0
{% endhighlight %}

Ignoring the subject and grade, remove the the linkage with the smallest weight. 


{% highlight r %}
class_edit <-  class %>%
  # order descending by weight
  arrange(desc(weight)) %>% 
  # split: by student teacher linkage
  group_by(student_id, teacher_id) %>%
  # apply: extract the first row from each split
  do(marittr::extract(., 1, )) 
  # combine: dplyr does this automatically
class_edit %>% head
{% endhighlight %}

<div class = "dftab">
<table>
 <thead>
  <tr>
   <th style="text-align:center;"> student_id </th>
   <th style="text-align:center;"> teacher_id </th>
   <th style="text-align:center;"> weight </th>
   <th style="text-align:center;"> subject </th>
   <th style="text-align:center;"> grade </th>
   <th style="text-align:center;"> posttest_score </th>
   <th style="text-align:center;"> pretest_score </th>
   <th style="text-align:center;"> d_gender </th>
   <th style="text-align:center;"> d_black </th>
   <th style="text-align:center;"> d_hispanic </th>
   <th style="text-align:center;"> d_asian </th>
   <th style="text-align:center;"> d_native </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 100 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 0.9692 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -2.1143 </td>
   <td style="text-align:center;"> -0.0226 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 101 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0.1913 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -0.4224 </td>
   <td style="text-align:center;"> 0.8057 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 0.7622 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7631 </td>
   <td style="text-align:center;"> 0.1451 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 0.9347 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -1.4334 </td>
   <td style="text-align:center;"> 0.9452 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 103 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0.7774 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7721 </td>
   <td style="text-align:center;"> 0.5730 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
  </tr>
</tbody>
</table>
</div><p></p>

Those duplicates were indeed removed.

{% highlight text %}
## [1] 0
{% endhighlight %}

Here are summary tables of $$posttest.score$$ regressed against $$pretest.score$$ for each unique combination of subject and grade. 

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
## # A tibble: 4 × 3
##   subject grade    model
## *  <fctr> <int>   <list>
## 1    math    11 <S3: lm>
## 2    math    12 <S3: lm>
## 3    read    11 <S3: lm>
## 4    read    12 <S3: lm>
{% endhighlight %}

This output isn't too meaningful; the `broom` package along with `tidyr::unnest()` can be used to extract the model coefficients. 


{% highlight r %}
class %>% 
  # split: by subject and grade
  group_by(subject, grade) %>% 
  # apply: regression model on splits and tidy into coef table
  do(tidy_df = tidy(lm(posttest_score ~ pretest_score, data = .))) %>%   
  # combine coefficient tables across models
  unnest(tidy_df)
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

## Using data.table
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
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 243 </td>
   <td style="text-align:center;"> 116 </td>
   <td style="text-align:center;"> 127 </td>
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
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 246 </td>
   <td style="text-align:center;"> 126 </td>
   <td style="text-align:center;"> 120 </td>
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
   <td style="text-align:center;"> 12 </td>
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
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table>
</div>

# In SAS

Split-apply-combine in SAS can easily be done using `proc sql` statements. These statements would group and apply the same way that it is done in SQL. 

Alternatively, this can be done in SAS with the `proc` statements. There is `by` or `class` clause that allows users to specify what they would like the data to be split by.

Here are a few examples.


{% highlight r %}
proc sort; by GROUP.VAR;

proc rank ASCENDING/DESCENDING;
by GROUP.VAR;
var ORDER.VAR;
ranks NEW.RANK.COL;
run;
{% endhighlight %}

Proc means has a number of different options. See SAS documentation for more information.

{% highlight r %}
proc means OPTIONS;
class GROUP.VAR;
var MEANS.VAR;
output out = OUTNAME OPTIONS = VARNAME;
run;
{% endhighlight %}


{% highlight r %}
proc standard OPTIONS;
by GROUP.VAR;
var VARNAMES;
run;
{% endhighlight %}

To combine the grouped summaries back into the main data, run a merge/join.

# In SQL

SQL allows split apply combine using the following phrases

* `group by`
* `having`

Aggregate functions tend to be used along with the `group by` command. These functions include

* `count( * )`
* `count( distinct A )`
* `sum( distinct A )`
* `avg( distinct A )`
* `max( A )`
* `min( A )`
* `first( A )`
* `last( A )`

Below is an example of this type of SQL statement.
{% highlight sql %}
SELECT COUNT(DISTINCT COL1) as C
from TAB1
group by COLG
having COL1 > 5
order by C
;
{% endhighlight %}

To combine the grouped summaries back into the main data, run a merge/join.
