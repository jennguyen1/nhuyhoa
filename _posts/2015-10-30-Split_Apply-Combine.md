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


{% highlight text %}
## Error in loadNamespace(name): there is no package called 'pryr'
{% endhighlight %}



{% highlight text %}
## Error in to_be(class, view_duplicated, teacher_id, student_id, grade, : Input x must be a data frame
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'fix_duplicates' not found
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'fix_duplicates' not found
{% endhighlight %}



{% highlight text %}
## Error in setkeyv(x, cols, verbose = verbose, physical = physical): x is not a data.table
{% endhighlight %}

This is the example data set we will use.

<div class = "dftab">

{% highlight text %}
## Error in xj[i]: object of type 'closure' is not subsettable
{% endhighlight %}
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
<tbody>
  <tr>

  </tr>
</tbody>
</table>
</div>

## Using dplyr

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

{% highlight text %}
## Error in eval(expr, envir, enclos): unknown column 'subject'
{% endhighlight %}

<table>
 <thead>
  <tr>
   <th style="text-align:center;">  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> function (x, df1, df2, ncp, log = FALSE) </td>
  </tr>
  <tr>
   <td style="text-align:center;"> { </td>
  </tr>
  <tr>
   <td style="text-align:center;"> if (missing(ncp)) </td>
  </tr>
  <tr>
   <td style="text-align:center;"> .Call(C_df, x, df1, df2, log) </td>
  </tr>
  <tr>
   <td style="text-align:center;"> else .Call(C_dnf, x, df1, df2, ncp, log) </td>
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
## Error: data_frames can only contain 1d atomic vectors and lists
{% endhighlight %}

As an artificial example, let's standardize the posttest scores by grade and subject. 

{% highlight text %}
## Error in eval(expr, envir, enclos): unknown column 'subject'
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): unknown column 'subject'
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'class2' not found
{% endhighlight %}

These are the means and standard deviations before standardizing.

<div class = "dftab">

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'b4' not found
{% endhighlight %}
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

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'af' not found
{% endhighlight %}
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

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'd_gender' not found
{% endhighlight %}

<table>
 <thead>
  <tr>
   <th style="text-align:center;">  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> function (x, df1, df2, ncp, log = FALSE) </td>
  </tr>
  <tr>
   <td style="text-align:center;"> { </td>
  </tr>
  <tr>
   <td style="text-align:center;"> if (missing(ncp)) </td>
  </tr>
  <tr>
   <td style="text-align:center;"> .Call(C_df, x, df1, df2, log) </td>
  </tr>
  <tr>
   <td style="text-align:center;"> else .Call(C_dnf, x, df1, df2, ncp, log) </td>
  </tr>
</tbody>
</table>



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'd_black' not found
{% endhighlight %}
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

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'class3' not found
{% endhighlight %}
</div>

### do and unnest
Sometimes `summarise()` and `mutate()` just isn't enough. Luckily, there is a function `do()` that is perfect for these scenarios. 

In our data set we have unique student-teacher linkages for each unique subject and grade combination. However, when we ignore subject and grade, we may have duplicated linkages. 


{% highlight text %}
## Error in view_duplicated(., student_id, teacher_id): Columns specified not in input data
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

{% highlight text %}
## Error: data_frames can only contain 1d atomic vectors and lists
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'class_edit' not found
{% endhighlight %}
</div><p></p>

And here we see that those duplicates were indeed removed.

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'class_edit' not found
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
## Error in eval(expr, envir, enclos): unknown column 'subject'
{% endhighlight %}

This output isn't too meaningful, so we can use the `broom` package along with `tidyr::unnest()` to extract the model coefficients. (Try on your own browser).


{% highlight r %}
class %>% 
  # split: by subject and grade
  group_by(subject, grade) %>% 
  # apply: regression model on splits
  do(model = lm(posttest_score ~ pretest_score, data = .)) %>% 
  # apply: tidy up models into coefficient table
  mutate(tidy_df = llply(model, tidy)) %>%
  # combine coefficient tables across models
  unnest(tidy_df)
{% endhighlight %}

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

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'subject' not found
{% endhighlight %}
</div><p></p>

Now let's standardize the posttest scores by grade and subject. This is equivalent to `mutate()`.

{% highlight r %}
# split by subject & grade and standardize
classDT[, z_post := (posttest_score - mean(posttest_score)) / sd(posttest_score), by = list(subject, grade)]

# summarise results to see effect
classDT[, list(mean = mean(z_post), sd = sd(post)), by = list(subject, grade)]
{% endhighlight %}

<div class = "dftab">

{% highlight text %}
## Error in eval(expr, envir, enclos): object 'subject' not found
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): object 'subject' not found
{% endhighlight %}
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
