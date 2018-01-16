---
layout: post
title: "Linux Basics"
date: "March 28, 2016"
categories: Software
tags: Basics
---

* TOC
{:toc}

**Cheatsheet:**

See [Linux Cheatsheet][linux_ref]{:target = "_blank"}

# Generic Commands

* `alias x='cmd'; x` to save a series of commands under a different name
* `|` to chain commands
* `xargs` reads items from standard input delimited by blanks and executes command multiple times
* `>` or `>>` divert all output to a file
* `&>` or `&>>` diverts outputs & errors to a file

{% highlight bash %}
# example: delete all *.txt files
find . -name *.txt | xargs rm

# example: package all *.jpg files 
find . -name *.jpg | xargs tar -zcf jpg.tar.gz

# example: batch rename
ls | grep \.jpg$ | sed 'p;s/\.jpg/\.png/' | xargs -n2 mv
{% endhighlight %}

* `echo` repeat text, can pipe into files
* `date` to obtain the date and time
* `head` and `tail` can be used to slice through a file

{% highlight bash %}
# example: slice through very large file quickly
tail -n +${start} file | head -n ${end - start + 1}
{% endhighlight %}

# Working With Files

## Editing Files

* `grep` for pattern matching (fastest implementation)
  * `grep -c` counts matches
  * `grep -i` ignores case
  * `grep -e` expanded regular expression (special characters such as )
  * `grep -w` matches the word
  * `grep pattern --color=auto` highlight the match
  * `grep -ABC n` returns n lines (A) after, (B) before, (C) A+B match
  * `grep --color -E "$1|$" "${@:2}"` (function) highlights match in text
* `uniq -c` for unique values and counts
* `wc -l` word counts, counts each line
* `diff -u` compare files line by line
* `column -s ',' -t` formats tables nicely based on delimiter

* `sort` sorting
{% highlight bash %}
# sort by 1st col, then 2nd, then 3rd ...
sort input.txt

# sort 2nd col as numbers, descending order; then sort 3rd col as strings ascending order
sort -k2,2nr -k3,3 input.txt
{% endhighlight %}

* `cut` cuts out selected portions of each line from each file and writes to standard output
{% highlight bash %}
# cut 1, 2, 3, 5, 7 columns
cut -f1-3,5,7 input.txt

# cut 3rd column w/ columns separated by a single space
cut -d "," -f 3 input.txt

# opposite: all but columns 1-3
cut -f1-3 --complement input.txt
{% endhighlight %}

* `paste` column binds two files
* `join -1 c1 -2 c2 file1 file2` merges tables of files together by 1 column

## Finding Files
{% highlight bash %}
find . -name *sample*
{% endhighlight %}

## Zipping Files

Some common action terms

`tar` options:

* `t` list the contents of an archive
* `c` create an archive
* `x` extract 
* `v` verbose mode
* `z` process through gzip
* `f` specify name of the $$.tar$$ files to create

{% highlight bash %}
# creating a tar file
tar -cvf file_name.tar file1 file2 ... filen

# create a gzip file
tar -czvf file_name.tar.gz file1 file2 ... filen

# unpack tar files
tar -xvf file_name.tar

# unpack tar.gz files
tar -xzvf file_name.tar.gz
{% endhighlight %}

`zip` options:

{% highlight bash %}
# zip files
zip file_name file1 file2 ... filen

# unzip files
unzip file_name.zip
{% endhighlight %}

`gzip` options:

{% highlight bash %}
# gzip files
gzip file_name file1 file2 ... filen

# unzip files
gunzip file_name.zip
{% endhighlight %}

Another option is to `bzip` which means block zip. It zippes files in blocks so that searching through the file is easier.

View or search through zipped files
{% highlight bash %}
zcat file_name
zgrep pattern file_name
{% endhighlight %}

## Changing Permissions of Files

Syntax: `chmod (user)(+-=)(rwx) (filename)`

Options for users: 

* `u` user (file owner)
* `g` group
* `o` others/world
* `a` all (if no characters given, all is assumed)

The `+-=` refers to assigning and removing permissions

File access options: 

* `r` read and open
* `w` write
* `e` executable

When listed via `ls`, the file access options from left to right are for owner, group, all. 

{% highlight bash %}
# make file readable by group
chmod g+r filepath

# make file executable by all
chmod +x filepath
{% endhighlight %}

## Printing Files

{% highlight bash %}
# obtain a list of available printers
lpstat -p -d

# print queue
lpq -P printer_name

# print file
lpr -P printer_name filename

# pass commands to printer: print two sides
lpr -o sides=two-sided-long-edge -Pprinter_name file_name
{% endhighlight %}

# My Computer and Other Servers 

**Log In Via ssh:**

{% highlight bash %}
ssh username@place
{% endhighlight %}
See [this link][ssh_login]{:target = "_blank"} to learn how to set up a ssh login without a password.

**Download from a Web Server:**
{% highlight bash %}
curl -o online_file_name
wget --no-check-certificate -q -O output_name website
{% endhighlight %}

**Download/Upload to a Server:**

{% highlight bash %}
# using rsync
rsync -a filename username@place:file_directory

# using scp 
scp original.file user@location.to.transfer:file_path

# using scp with directories
scp -rp file location.to.transfer
{% endhighlight %}

**Run on Background in Server:**

{% highlight bash %}
# add an & at the end of command
sh filename.sh >> output.txt 2> err.txt &
sh filename.sh &>> console.txt &

# check on currently running background commands; lists program in a file
top
top -b -n 1 -c -u username

# push to background after starting
sh filename.sh >> output.txt
# do cntrl + z
bg

# run regularly in background: crontab, check online for documentation of how to run regularly
crontab -e
# edit crontab file with commands to use
crontab -l

# run regularly in background: watch
watch -n secs cmd
{% endhighlight %}

**Communicate Results via Email**

{% highlight bash %}
echo script | mail -s "subject line" email_address
{% endhighlight %}

# Shell Scripting

Start scripts out with the following statements (depending on programming language), so that it can be run as an executable. Don't forget to change the permissions of the file to make it executable.

{% highlight bash %} 
#!/usr/bin/env bash
#!/usr/bin/env sh
#!/usr/bin/env Rscript
#!/usr/bin/env python3
{% endhighlight %}


## Variables

**Setting Variables:**

{% highlight bash %}
# set variable, note no spaces
VAR="value"
VAR2=25
VAR3=$(echo ${statement} | sed 's/\(<\/*[a-z0-9]*>\)[A-Za-z0-9\t ]*/\1/g')

# array variables
declare -a NAME
NAME=(val2 val2 ... valN)
NAME[index]=value

# set environmental vars so child processes can inherit
export VAR2="value2"
{% endhighlight %}

**Call Variables:**

{% highlight bash %}
# call a variable (brackets are not required but convention)
cmd ${VAR}

# call arrays (should include [], otherwise only prints first element)
cmd ${NAME[0]}
cmd ${NAME[@]}

# find the length of a variable
cmd ${#VAR[@]}
{% endhighlight %}

**Substitution Operators:**

If the variable is not set:

{% highlight bash %}
# return another value
echo "${TMP:-value}"

# return another value and set to value
echo "${TMP:=value}"

# abort
echo "${TMP:?value}"
{% endhighlight %}

Obtaining substrings
{% highlight bash %}
# obtain everything after 4th char
echo ${STR:4}

# start at 6th char and obtain a string fo length 5
echo ${STR:6:5}

# obtain portion of string that isn't name
echo ${STR%name}
{% endhighlight %}

## Doing Math
{% highlight bash %}
# using double parenthesis
a=$((4 + 5))
c=$(($a + 2))
((a++))
((a+=4))
echo $((5+3))
{% endhighlight %}


## Conditions

{% highlight bash %}
# returns 0 for true; 1 for false

# test for equality with strings
[ 'hi' = 'hello' ]; echo $?

# test for equality with numbers
[ 1 -eq 1 ]; echo $?
[ 1 -ne 1 ]; echo $?
[ 1 -lt 1 ]; echo $?
[ 1 -le 1 ]; echo $?
[ 1 -gt 1 ]; echo $?
[ 1 -ge 1 ]; echo $?

# test multiple commands
[ 'hi' != 'hello' ] && test [ 'hi' = 'hi' ]; echo $?
[ ${var} = 'hello' ] || test[ 'hi' = 'hi' ]; echo $?

# check empty argument: empty (z) and not empty (n)
[ -z "" ]; echo $?
[ -n "" ]; echo $?

# test for existence (e) or non-emptiness (s)
[ -e file.txt ]; echo $?
[ -s file.txt ]; echo $?

# test permissions: readable (r), writable (w), executable (x)
[ -r file.txt ]; echo $?
[ -w file.txt ]; echo $?
[ -x file.txt ]; echo $?

# test lifetime of files: newer (nt) and older (ot)
[ oldfile.txt -nt newfile.txt ]; echo $?
[ oldfile.txt -ot newfile.txt ]; echo $?
{% endhighlight %}

# Sed

Sed is a command line tool to conduct regular expressions commands.

**Search and Replace Text:**

`(address)s/(search)/(replacement)/(modifier)`

* Addresses are specified: `start, end`
* Both search and replacement are strings
* Modifiers: 
  * `g`: global, replace for all occurances on the line
  * `p`: print only the lines where replacement occurs
  * `w`: write to a file

{% highlight bash %}
# example: addresses
sed '1,2s/heart/love/' test.txt

# example: global modifier
echo "hi, hi, hi" | sed 's/hi/hello/'
echo "hi, hi, hi" | sed 's/hi/hello/g'

# example: different print modifier, prints original and edit
sed 'p;s/heart/love/' test.txt

# example: print out lines by number; -n suppresses printing of other lines
sed -n '2,5p' test.txt

# example: regex and backreferences
sed 's/\([1-9]*\) \(#\)/ \2 \1/' test.txt

# example: & as the matched string
sed 's/^[AEIOU][a-z]*/\*&\*/' test.txt

# example: write results out
sed 's/^[AEIOU][a-z]*/\*&\*/w output.txt' test.txt

# example: trim lead & trailing whitespaces
sed 's/^[ \t]*//;s/[ \t]*$//' test.txt

# example: delete blank lines
sed '/^$/d' test.txt
{% endhighlight %}

* Edit the document in place using sed
{% highlight bash %}
sed -i 's/old/new/' test.txt
{% endhighlight %}

# Awk
Awk is a scripting language used for text extraction and processing. 

{% highlight bash %}
# form strings
ls -l | awk '{print "my username is " $3}'

# choose rows where col 3 larger than col 5
awk '$3>$5' input.txt > output.txt

# extract col 2, 4, 5, last col - 1, last col
awk '{print $2, $4, $5, $(NF-1), $NF}' input.txt

# import simple csv
awk -F , '{print $1, $2}'

# import tab delimited
awk -F '\t' '{print $1, $2}'

# export from a tab-separated file (OFS = output field separator)
awk 'BEGIN{OFS="\t"}{print $2, $4, $5}' input.txt

# show rows between 20th and 80th rows (NR = row number)
awk 'NR>=20&&NR<=80' input.txt

# awk filter 2nd column that equals variable $t
awk -v var=$t '($2==var){print}'
{% endhighlight %}

[linux_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMeXJRRWdFTFQzMEU/view?usp=sharing
[ssh_login]: http://www.linuxproblem.org/art_9.html
