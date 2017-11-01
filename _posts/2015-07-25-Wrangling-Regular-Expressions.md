---
layout: post
title: "Regular Expressions"
date: "July 25, 2015"
categories: Software
tags: Wrangling
---

* TOC
{:toc}



# Regex

To search for an exact pattern, simply search for the pattern.


{% highlight r %}
# detect the name Charlie
x %>% str_detect("Charlie")
{% endhighlight %}

## Character Classes

Rather than searching for a specific character, the regex engine can search for a class of characters. There are three classes or groups of characters in which there are special regex expressions for. 

pattern | matches
--------|---------
`\d`      | digit character
`\w`      | word character (letter, digit, '_')
`\s`      | space character (space, tab, new line)

## Metacharacters

To allow for greater flexibility, there are a number of metacharacters that convey special meaning in regex pattern matching.

pattern | matches
--------|-------------
`.`       | any single character
`\|`       | or (matches preceding or succeding string)
`(...)`   | used for backreference
`[...]`   | customized group of characters
`{...}`   | repetition quantifier
`*`      | matches previous character 0 or more times
`+`       | matches previous character 1 or more times
`?`     | matches previous character 0 or 1 times
`^`      | matches at the beginning of a string
`$`       | matches at the end of a string

Here are further specifications on several of the characters listed above.

**[...]**

`[...]` can be used to select from a customized group of characters. To specify characters, list them out inside the brackets. To not match a customized group of characters, add a negation character like so: `[^...]`. 

To specifically search for only uppercase letters, use `[A-Z]`; for lowercase letters `[a-z]`. To search for both uppercase and lowercase letters, use `[A-Za-z]`.

**{...}**

To match a character (or a group of characters) multiple times, repetition quantifiers come in handy: `{...}`, `*`, or `+`. 

pattern | matches
--------|---------
`{n}`     | matches previous character exactly n times
`{n,}`    | matches previous character n or more times
`{n, m}`  | matches previous character n to m times
`*`       | matches previous character 0 or more times
`+`       | matches previous character 1 or more times
`?`       | matches previous character 0 or 1 times

**(...)**

The metacharacters `(...)` are very useful in replacing strings. When wrapped around a string, it "remembers" the matched pattern. Then when specifying the replacement, it allows users to refer to the matched pattern by using `\n` where n refers to the nth wrapped expression. 

We can look at this example in R:

{% highlight r %}
x <- "Flintstone,Fred  *111-222-3333 fflinstone@gmail.com crane operator"
pattern <- "(\\w+)[, ]+(\\w+)\\s+([\\d-*]+)\\s+([\\w@.]+)\\s+(.+)"
## 1st () references the last name
## 2nd () references the first name
## 3rd () references the phone number
## 4th () references the email address
## 5th () references the person's occupation
x %>% str_replace(pattern = pattern, replacement = "\\2 \\1 is a \\5")
{% endhighlight %}



{% highlight text %}
## [1] "Fred Flintstone is a crane operator"
{% endhighlight %}

**^ and $**

The metacharacters `^` and `$` are used to match patterns at specific positions of a string. 

{% highlight r %}
grep "^\d"
grep "\w$"
{% endhighlight %}

**Using Metacharacters as Normal Characters**

To use these characters as regular characters, precede the character with escape characters or wrap then in square brackets. For example, to search for the character `+`, type `\+` or `[+]` into the search pattern string. 

# Implementation

## In R

In order to match these special regex expressions in R, type the backslashes twice, like so:


{% highlight r %}
# count the number of space characters in each string of x
x %>% str_count("\\s")
{% endhighlight %}

Function | Description
---------|--------------
`str_to_upper()`, `str_to_lower()`, `str_to_title()` | change string case
`str_dup()` | duplicate and concatenate character vector
`paste()` | join multiple strings into single string
`nchar()` | number of characters
`str_count()` | count number of matches in string
`str_sub()` | extract and replace substrings
`str_subset()` | keep strings matching a pattern
`str_detect()` | detect presence of a pattern
`str_locate()`, `str_locate_all()` | locate positions of patterns
`str_extract()`, `str_extract_all()` | extract pieces that match pattern
`str_match()`, `str_match_all()` | extract matched groups
`str_replace()`, `str_replace_all()` | replace matched patterns
`str_replace_na()` | replace NA
`str_split()` | split by pattern
`str_trim()` | trim white space
`str_pad()` | pad string
`str_wrap()` | wrap strings into formatted paragraphs
`word()` | extract words from sentence

## In SAS

Additional metacharacters for SAS

* `%` substitute for 0 or more characters

Function | Description
---------|---------------
`lengthn()` | length of string
`upcase()`, `lowcase()`, `propcase()` | change string case
`compbl()` | combines >1 blank to 1 blank
`compress()` | removes specified character/char class
`cat()` | concatenates characters
`cats()` | strips leading & trailing blanks before joining
`catx()` | concatenates characters, 1st arg is separator
`left()`, `trim()`, `strip()` | removes blanks from L, R, both sides
`find()` | finds characters
`findc()` | finds individual characters
`findw()` | finds words
`anyalnum()`, `anyalpha()`, `anydigit()`, `anyspace()` | finds any of listed; can also replace any with not
`substr()` | takes substring
`scan()` | scans string
`compare()` | compares strings
`translate()`| translates one to another

## In SQL

Regular expressions can be specified in SQL using the `where` clause. 

Here is an example of selecting names that start with vowels. 

{% highlight r %}
select * from table
where name like '[aeiou]%'
;
{% endhighlight %}

The metacharacters that can be used with SQL are a little different than those listed above. 

* `[...]` brackets, same as above (including negation)
* `%` substitute for 0 or more characters
* `_` substitute for a single character

## In Python

Function | Description
---------|--------------
`len()` | length of strings
`strip()`, `rstrip()`, `lstrip()` | remove trailing white space
`lower()`, `upper()`, `capitalize()` | change string case
`translate()` | map from one thing to another
`startswith()`, `endswith()` | checks for string at location
`isalpha()`, `isdigit()`, `isalnum()`, `isspace()` | tests string for type
`split()` | splits a string
`match()` | whether there is a match
`extract()` | extracts match
`findall()` | finds all matches in string
`replace()` | replace occurance of specificed string
`contains()` | searchs for pattern inside string
`count()` | counts occurances of specified string
`pad()` | adds white space
`join()`, `cat()` | combines strings
`cat()` | concatenates strings
`repeat()` | repeats values

The class `pd.Series.str` allows for vectorized string operations.
