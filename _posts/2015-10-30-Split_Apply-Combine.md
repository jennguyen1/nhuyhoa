---
layout: post
title: "Split Apply Combine"
date: "October 30, 2015"
categories: R data_wrangling
---

* TOC
{:toc}



Say we are given a data set where we want to group by a given category and compute summary statistics based on that category. This is the process for computing these statistics.

1. Split: split by the variable
2. Apply: apply the function to each split
3. Combine: combine the results back into a single data structure

Collectively this is known as split-apply-combine.

# Example Data


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



{% highlight text %}
##             descr      post      pre
## 1: math 11 female -0.145541 -0.03667
## 2:   math 11 male -0.072560 -0.04452
## 3: math 12 female  0.075495 -0.09386
## 4:   math 12 male -0.025222 -0.08092
## 5: read 11 female  0.037746  0.04683
## 6:   read 11 male  0.007443  0.05718
## 7: read 12 female -0.053470  0.04255
## 8:   read 12 male  0.034990 -0.11847
{% endhighlight %}

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
##  [1] "student_id"     "teacher_id"     "weight"        
##  [4] "subject"        "grade"          "posttest_score"
##  [7] "pretest_score"  "d_gender"       "d_black"       
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

## summarise_each and mutate_each 
The `summarise_each()` and `mutate_each()` allows you to simultaneous apply a function to all columns at once. It is insanely convenient and efficient.

A few notes:

* wrap functions in `funs()`
* for functions with additional arguments, do `funs(my_func(., addnl_args))`
* to remove columns from being included in calculations, list column names after the `funs()` argument with a `-` in front of each name

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

Let's try something a little more complicated. Let's group by teacher and compute the weighted means of all our numeric variables, using the provided weights.

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

## do
do
do is in - given a data frame, how do we split it up? extract 1st row etc

# Using data.table


