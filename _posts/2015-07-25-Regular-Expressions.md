---
layout: post
title: "Regular Expressions"
date: "July 25, 2015"
categories: ['r programming']
---

* TOC
{:toc}



Being able to manipulate text is very important when it comes to data wrangling. A lot of the data cleaning I do requires performing some sort of fuzzy match rather than exact matches. Regular expressions (regex) make pattern matching possible. Here, I will outline R's regex symbols that I find useful.

# Example Data
Let's start by generating some sample text to play with. 



{% highlight r %}
x = c("Brown, Charlie    *608-445-2392 cbrown@wisc.edu student", 
      "Jetsons,Judy *842-419-5238 jjetsons@gmail.com sales associate",
      "Flintstone,Fred  *111-222-3333 fflinstone@gmail.com crane operator",
      "Sparrow,Jack *959-494-5943 jsparrow@blackpearl.com  pirate"
      )
{% endhighlight %}

For this post, I will use the package stringr, developed by Hadley Wickham, to handle the  pattern matching operations. More information about the stringr package can be found [here][stringr_link]{:target="_blank"}.

{% highlight r %}
library(stringr)
{% endhighlight %}

# Basics

To search for an exact pattern, simply pass it to a stringr or grep function in R.


{% highlight r %}
# detect the name Charlie
x %>% str_detect("Charlie")
{% endhighlight %}



{% highlight text %}
## [1]  TRUE FALSE FALSE FALSE
{% endhighlight %}



{% highlight r %}
# extract contact information of anybody who is a pirate
x %>% str_subset("pirate")
{% endhighlight %}



{% highlight text %}
## [1] "Sparrow,Jack *959-494-5943 jsparrow@blackpearl.com  pirate"
{% endhighlight %}

# Character Classes

Now let's get a little more general. Rather than searching for a specific character, the regex engine can search for a class of characters. There are three classes or groups of characters in which there are special regex expressions for. 


|pattern |matches                                  |
|:-------|:----------------------------------------|
|\d      |digit character: 0123456789              |
|\w      |word character: letter, digit, or '_'    |
|\s      |space character: space, tab, or new line |

In order to match these special regex expressions in R, type the backslashes twice, like so:


{% highlight r %}
# count the number of space characters in each string of x
x %>% str_count("\\s")
{% endhighlight %}



{% highlight text %}
## [1] 7 4 5 4
{% endhighlight %}

# Metacharacters

To allow for greater flexibility, there are a number of metacharacters that convey special meaning in regex pattern matching.


|pattern |matches                                    |
|:-------|:------------------------------------------|
|.       |any single character                       |
|\       |escape character                           |
|&#124;  |or                                         |
|(...)   |used for backreference                     |
|[...]   |customized group of characters             |
|{...}   |repetition quantifier                      |
|*       |matches previous character 0 or more times |
|+       |matches previous character 1 or more times |
|^       |matches at the beginning of a string       |
|$       |matches at the end of a string             |

### |
The pipe character `|` is useful when for matching a variety of different patterns at once. 

{% highlight r %}
# find contact information for all Jack's or Judy's
x %>% str_subset("Jack|Judy")
{% endhighlight %}



{% highlight text %}
## [1] "Jetsons,Judy *842-419-5238 jjetsons@gmail.com sales associate"
## [2] "Sparrow,Jack *959-494-5943 jsparrow@blackpearl.com  pirate"
{% endhighlight %}

### [...]
`[...]` can be used to select from a customized group of characters. To not match a customized group of characters, add a negation character like so: `[^...]`. 


{% highlight r %}
# extract all digits, '-', '*', and '+' characters 
x %>% str_extract_all("[\\d-*]")
{% endhighlight %}



{% highlight text %}
## [[1]]
##  [1] "*" "6" "0" "8" "-" "4" "4" "5" "-" "2" "3" "9" "2"
## 
## [[2]]
##  [1] "*" "8" "4" "2" "-" "4" "1" "9" "-" "5" "2" "3" "8"
## 
## [[3]]
##  [1] "*" "1" "1" "1" "-" "2" "2" "2" "-" "3" "3" "3" "3"
## 
## [[4]]
##  [1] "*" "9" "5" "9" "-" "4" "9" "4" "-" "5" "9" "4" "3"
{% endhighlight %}

To specifically search for only uppercase letters, use `[A-Z]`; for lowercase letters `[a-z]`. To search for both uppercase and lowercase letters, use `[A-Za-z]`.


{% highlight r %}
# extracts people's intials
x %>% str_extract_all("[A-Z]")
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "B" "C"
## 
## [[2]]
## [1] "J" "J"
## 
## [[3]]
## [1] "F" "F"
## 
## [[4]]
## [1] "S" "J"
{% endhighlight %}

### Repetition
The previous extraction for Fred Flinstone's phone number returned a vector of single characters. But when we need to match a character (or a group of characters) multiple times, repetition quantifiers come in handy: `{...}`, `*`, or `+`. 


|pattern |matches                                    |
|:-------|:------------------------------------------|
|{n}     |matches previous character exactly n times |
|{n, }   |matches previous character n or more times |
|{n,m}   |matches previous character n to m times    |
|*       |matches previous character 0 or more times |
|+       |matches previous character 1 or more times |


{% highlight r %}
# extracts the telephone number (sequence of numbers & dashes) from all people
x %>% str_extract("[\\d-*]+")
{% endhighlight %}



{% highlight text %}
## [1] "*608-445-2392" "*842-419-5238" "*111-222-3333" "*959-494-5943"
{% endhighlight %}

### (...)
The metacharacters `(...)` are very useful in replacing strings. When wrapped around a string, it "remembers" the matched pattern. Then when specifying the replacement, it allows us to refer to the matched pattern by using `"\\n"` where n refers to the nth wrapped expression. 


{% highlight r %}
# regex expression for the strings in x
pattern <- "(\\w+)[, ]+(\\w+)\\s+([\\d-*]+)\\s+([\\w@.]+)\\s+(.+)"

# notice that:
## 1st () references the last name
## 2nd () references the first name
## 3rd () references the phone number
## 4th () references the email address
## 5th () references the person's occupation

# what does each person do?
x %>% str_replace(pattern = pattern, replacement = "\\2 \\1 is a \\5")
{% endhighlight %}



{% highlight text %}
## [1] "Charlie Brown is a student"         
## [2] "Judy Jetsons is a sales associate"  
## [3] "Fred Flintstone is a crane operator"
## [4] "Jack Sparrow is a pirate"
{% endhighlight %}


{% highlight r %}
# email contact information
x %>% str_replace(pattern = pattern, replacement = "Email \\1, \\2 at \\4")
{% endhighlight %}



{% highlight text %}
## [1] "Email Brown, Charlie at cbrown@wisc.edu"       
## [2] "Email Jetsons, Judy at jjetsons@gmail.com"     
## [3] "Email Flintstone, Fred at fflinstone@gmail.com"
## [4] "Email Sparrow, Jack at jsparrow@blackpearl.com"
{% endhighlight %}

### ^ and $
The metacharacters `^` and `$` are used to match patterns at specific positions of a string. Here are two examples illustrating why these two metacharacters can be useful.



For this first example, let's remove all leading 0's.

{% highlight r %}
# generate values
grade <- sample(c("07", "08", "8", "HS"), 10, replace = TRUE)
grade
{% endhighlight %}



{% highlight text %}
##  [1] "08" "08" "8"  "HS" "07" "HS" "HS" "8"  "8"  "07"
{% endhighlight %}



{% highlight r %}
grade %>% str_replace("^0(\\d)", "\\1")
{% endhighlight %}



{% highlight text %}
##  [1] "8"  "8"  "8"  "HS" "7"  "HS" "HS" "8"  "8"  "7"
{% endhighlight %}

Now for the second example, let's change all "pre" values to "pre1" to keep a consistent naming system. 

{% highlight r %}
# generate values
pre_name <- sample(c("pre", "pre1", "pre2"), 10, replace = TRUE)
pre_name
{% endhighlight %}



{% highlight text %}
##  [1] "pre"  "pre"  "pre2" "pre1" "pre2" "pre1" "pre2" "pre2" "pre1"
## [10] "pre2"
{% endhighlight %}



{% highlight r %}
## try (1)
# this command inadvertently changed "pre1" and "pre2" to "pre11" and "pre12" respectively
pre_name %>% str_replace("pre", "pre1")
{% endhighlight %}



{% highlight text %}
##  [1] "pre1"  "pre1"  "pre12" "pre11" "pre12" "pre11" "pre12" "pre12"
##  [9] "pre11" "pre12"
{% endhighlight %}



{% highlight r %}
## try (2)
pre_name %>% str_replace("pre$", "pre1")
{% endhighlight %}



{% highlight text %}
##  [1] "pre1" "pre1" "pre2" "pre1" "pre2" "pre1" "pre2" "pre2" "pre1"
## [10] "pre2"
{% endhighlight %}

### Using Metacharacters as Normal Characters

To use these characters as regular characters, precede the character with double escape characters or wrap then in square brackets. For example, to search for the character `+`, type `\\+` or `[+]` into the search pattern string. 


{% highlight r %}
# split these two strings up into the individual numbers
add <- "1+2"

# two different ways of splitting; same results
add %>% str_split("\\+")
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "1" "2"
{% endhighlight %}



{% highlight r %}
add %>% str_split("[+]")
{% endhighlight %}



{% highlight text %}
## [[1]]
## [1] "1" "2"
{% endhighlight %}

Whether it is subsetting, selecting or reshaping data, the versatility of regex characters can make most data cleaning tasks much simpler. 

# Useful StringR Functions

|function                                                  |description                                |
|:---------------------------------------------------------|:------------------------------------------|
|str_to_upper(s); str_to_lower(s); str_to_title(s)         |change string case                         |
|str_dup(s, times)                                         |duplicate & concatenate char vector        |
|str_c(s, sep=, collapse=)                                 |join multiple strings into a single string |
|str_length()                                              |number of chars                            |
|str_count(s, pattern=)                                    |count number of matches in a string        |
|str_sub(s, start, end)                                    |extract & replace substrings               |
|str_subset(s, pattern=)                                   |keep strings matching a pattern            |
|str_detect(s, pattern=)                                   |detect presence of pattern                 |
|str_locate(s, pattern=); str_locate_all()                 |locate positions of patterns               |
|str_extract(s, pattern=); str_extract_all()               |extract piece(s) that match pattern        |
|str_match(s, pattern=); str_match_all()                   |extract matched groups                     |
|str_replace(s, pattern=, replacement=); str_replace_all() |replace matched patterns                   |
|str_replace_na(s, replacement=)                           |replace NA with others                     |
|str_split(s, pattern=)                                    |split by pattern                           |
|str_trim(s, side=)                                        |trim white space                           |
|str_pad(s, width, side=, pad=)                            |pad string                                 |
|str_wrap()                                                |wrap strings into formatted paragraphs     |
|word(s, start=, end=, sep=)                               |extract words from sentence                |

[stringr_link]: https://cran.r-project.org/web/packages/stringr/index.html
