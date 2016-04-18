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

# In R



This is the example data set we will use.

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
   <td style="text-align:center;"> 0.0755 </td>
   <td style="text-align:center;"> -0.0939 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math 12 male </td>
   <td style="text-align:center;"> -0.0252 </td>
   <td style="text-align:center;"> -0.0809 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 11 female </td>
   <td style="text-align:center;"> 0.0377 </td>
   <td style="text-align:center;"> 0.0468 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 11 male </td>
   <td style="text-align:center;"> 0.0074 </td>
   <td style="text-align:center;"> 0.0572 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read 12 female </td>
   <td style="text-align:center;"> -0.0535 </td>
   <td style="text-align:center;"> 0.0426 </td>
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
The `slice()` function can be used to obtain certain records. For example, we can obtain the records of that obtain the maximum test score for various subgroups. 


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
   <td style="text-align:center;"> 252 </td>
   <td style="text-align:center;"> 122 </td>
   <td style="text-align:center;"> 130 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 245 </td>
   <td style="text-align:center;"> 125 </td>
   <td style="text-align:center;"> 120 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 241 </td>
   <td style="text-align:center;"> 116 </td>
   <td style="text-align:center;"> 125 </td>
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
   <td style="text-align:center;"> 0.0267 </td>
   <td style="text-align:center;"> 1.019 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 0.0223 </td>
   <td style="text-align:center;"> 1.057 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -0.0109 </td>
   <td style="text-align:center;"> 1.024 </td>
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

### summarise_each and mutate_each 
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
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 0 </td>
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
</tbody>
</table>
</div><p></p>

How about something a little more complicated? Let's group by teacher and compute the weighted means of all our numeric variables, using the provided weights. (Note that I made a little change to $$d_gender$$ prior these calculations, splitting them into the boolean columns of $$d_gender_m$$ and $$d_gender_f$$).


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
   <td style="text-align:center;"> 0.1472 </td>
   <td style="text-align:center;"> -0.2464 </td>
   <td style="text-align:center;"> 0.1813 </td>
   <td style="text-align:center;"> 0.1517 </td>
   <td style="text-align:center;"> 0.1929 </td>
   <td style="text-align:center;"> 0.1584 </td>
   <td style="text-align:center;"> 0.5275 </td>
   <td style="text-align:center;"> 0.4725 </td>
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

### do and unnest
Sometimes `summarise()` and `mutate()` just isn't enough. Luckily, there is a function `do()` that is perfect for these scenarios. 

In our data set we have unique student-teacher linkages for each unique subject and grade combination. However, when we ignore subject and grade, we may have duplicated linkages. 


{% highlight text %}
## [1] 28
{% endhighlight %}

Ignoring the subject and grade, we want to remove the the linkage with the smallest weight. 


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

And here we see that those duplicates were indeed removed.

{% highlight text %}
## [1] 0
{% endhighlight %}

`do()` is versatile because it can handle a variety of different output types. 

Here I create summary tables of $$posttest.score$$ regressed against $$pretest.score$$ for each unique combination of subject and grade. 

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

This output isn't too meaningful, so we can use the `broom` package along with `tidyr::unnest()` to extract the model coefficients. 


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
   <td style="text-align:center;"> 0.0283 </td>
   <td style="text-align:center;"> 0.0645 </td>
   <td style="text-align:center;"> 0.4385 </td>
   <td style="text-align:center;"> 0.6614 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> 0.0176 </td>
   <td style="text-align:center;"> 0.0580 </td>
   <td style="text-align:center;"> 0.3032 </td>
   <td style="text-align:center;"> 0.7620 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> (Intercept) </td>
   <td style="text-align:center;"> 0.0204 </td>
   <td style="text-align:center;"> 0.0677 </td>
   <td style="text-align:center;"> 0.3016 </td>
   <td style="text-align:center;"> 0.7632 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> 0.0357 </td>
   <td style="text-align:center;"> 0.0620 </td>
   <td style="text-align:center;"> 0.5751 </td>
   <td style="text-align:center;"> 0.5657 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> (Intercept) </td>
   <td style="text-align:center;"> -0.0136 </td>
   <td style="text-align:center;"> 0.0659 </td>
   <td style="text-align:center;"> -0.2057 </td>
   <td style="text-align:center;"> 0.8372 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> pretest_score </td>
   <td style="text-align:center;"> -0.0763 </td>
   <td style="text-align:center;"> 0.0635 </td>
   <td style="text-align:center;"> -1.2001 </td>
   <td style="text-align:center;"> 0.2313 </td>
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
   <td style="text-align:center;"> 252 </td>
   <td style="text-align:center;"> 122 </td>
   <td style="text-align:center;"> 130 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 241 </td>
   <td style="text-align:center;"> 116 </td>
   <td style="text-align:center;"> 125 </td>
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
   <td style="text-align:center;"> 245 </td>
   <td style="text-align:center;"> 125 </td>
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

Split-apply-combine in SAS can be done within the `proc` statements. There is `by` or `class` clause that allows users to specify what they would like the data to be split by.

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

To combine the grouped summaries back into the main data, we would need to run a merge/join.

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

To combine the grouped summaries back into the main data, we would need to run a merge/join.
