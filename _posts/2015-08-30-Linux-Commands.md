---
layout: post
title: "Linux Commands"
date: "October 30, 2015"
---

* TOC
{:toc}

**Cheatsheet:**

See [Linux Cheatsheet][linux_ref]{:target = "_blank"}

# Generic Commands

* `|` to chain commands
* `xargs` reads items from standard input delimited by blanks and executes command multiple times


{% highlight r %}
# example: delete all *.txt files
find . -name "*.txt" | xargs rm

# example: package all *.jpg files 
find . -name "*.jpg" | xargs tar -zcf jpg.tar.gz
{% endhighlight %}

* `echo` repeat your own text, can pipe into files
* `printf` for formatting text


{% highlight r %}
# strings
printf "Hello my name is %s.\n" Jenny

# integers
printf "I am %d years old" 2

# floating point values
printf "I am %f years old" 2.4

# formatting: floating points
printf "%.2f\n" 3

# formatting: add 4 spaces before digit
printf "%4d" 15

# formatting: add a bunch of 0s
printf "%04d" 15
{% endhighlight %}

# Working With Files

## Editing Files

* `grep` for pattern matching
  * `grep -c` counts matches
  * `grep -i` ignores case
  * `grep -e` expanded regular expression 
  * `grep -v` opposite of the match
  * special characters: `^`, `$`, `*`
* `tr 'abc' 'ABC'` translate lower case to upper case
  * `tr a b < file` translate a to b in the file
  * `tr -d 'aeiou'` delete specific characters
* `uniq` for unique values
* `sort` sorting
* `wc` word counts
* `cut` cuts out selected portions of each line from each file and writes to standard output
* `paste` merges lines of files together
* `join` merges tables of files together by a given column
* `diff` compare files line by line
* `expand` converts tabs to spaces
* `unexpand` converts spaces to tabs
* `fold` prints out content in more readable format
* `colrm` removes columns from being printed


{% highlight r %}
# find the 10 most common words
cat temp.txt | tr "[A-Z]" "[a-z]" | tr -c "[:alnum:]" "[\n*]" | sort | uniq -c | sort -nr | head -10
{% endhighlight %}


## Finding Files

{% highlight r %}
find directory -type (f/d) \(-name "." -(and/or/not) -name "."\)
{% endhighlight %}

## Zipping Files

Some common action terms

`tar` options:

* `c` create an archive
* `t` list the contents of an archive
* `x` extract 
* `v` verbose mode
* `z` process through gzip
* `f` specify name of the $$.tar$$ files you want to create


{% highlight r %}
# creating a tar file
tar -cvf file_name.tar file1 file2 ... filen

# create a gzip file
tar -czvf file_name.tar.gz file1 file2 ... filen

# unpack tar files
tar -xvf file_name.tar

# unpack tar.gz files
tar -xzf file_name.tar.gz
{% endhighlight %}

`zip` options:


{% highlight r %}
# zip files
zip file_name file1 file2 ... filen

# unzip files
unzip file_name.zip
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

When listed via `ls`, the file access options from left to right are for owner, group, then all. 


{% highlight r %}
# make file readable by group
chmod g+r filepath

# make file executable by all
chmod +x filepath
{% endhighlight %}

## Printing Files


{% highlight r %}
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


{% highlight r %}
ssh username@place
{% endhighlight %}

**Upload to a Server:**


{% highlight r %}
# using rsync
rsync -a filename username@place:file_directory

# using scp 
scp original.file user@location.to.transfer:file_path

# using scp with directories
scp -rp file location.to.transfer
{% endhighlight %}

# Shell Scripting

A shell script is a file containing lines for the shell to execute. Everything that you can do on the command line, you can put into a shell script. Shell scripts should be short. Longer scripts can be written using other languages and then run using a few lines of a shell script.

**Start scripts with the statement:**


{% highlight r %}
#!/bin/sh
{% endhighlight %}

The rest of the script can be populated with a list of commands or comments (#). 

**Execute script:**


{% highlight r %}
# using source
source script_name

# using bash
bash script_name

# using sh
sh script_name
{% endhighlight %}

## Variables

**Setting Variables:**


{% highlight r %}
# set variable, note no spaces
VAR="value"
VAR2=25

# set environmental vars so child processes can inherit
export VAR2="value2"
{% endhighlight %}

**Call Variables:**


{% highlight r %}
# call a variable (brackets are not required but convention)
cmd ${VAR}

# find the length of a variable
cmd ${#VAR}
{% endhighlight %}

**View and Remove Variables:**


{% highlight r %}
# view list of variables
set

# remove variable
unset VAR
{% endhighlight %}

**Substitution Operators:**

If the variable is not set:


{% highlight r %}
# return another value
echo "${TMP:-value}"

# return another value and set to value
echo "${TMP:=value}"

# abort
echo "${TMP:?value}"
{% endhighlight %}

## Passing Parameters to Scripts

**Call a Script:**


{% highlight r %}
script_name param1 param2 param3
{% endhighlight %}

**Access Parameters in Script:**

* The first argument is `${1}`, the second `${2}`, and so on
* The name of the script is accessed with `${0}`
* If the argument is not specified, the shell takes it in as `null`
* The number of arguments: `$#`
* Access all arguments at once: `#@`

## Input/Output of Data


{% highlight r %}
# input data
to_file < from_file

# input user data
read var1 var2 var3
read -p "a message for you:" var1

# input user data as passwords
stty -echo
read password1
stty echo

# output data
from_file > to_file

# append data
from_file >> to_file

# output error emssages
program_with_error 2> to_file
{% endhighlight %}

## If/Else, Loops & Functions

**If and Else:**

Conditions

{% highlight r %}
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

Format for if/else

{% highlight r %}
if cmd; then
  # stuff
elif cmd; then
  # stuff
else
    # stuff
fi
{% endhighlight %}


{% highlight r %}
# example
if [ ${value} -eq 1 ] || [ ${value} -eq 2 ]; then
  echo "1 or 2"
elif [ ${value} -gt 5 ]; then
  echo "greater than 5"
else
  echo "something else"
fi
{% endhighlight %}

Format for switch statments

{% highlight r %}
case ${var} in 
  options)
    # stuff
    ;;
  options)
    # stuff
    ;;
esac
{% endhighlight %}


{% highlight r %}
# example
caste ${value} in 
  [aeiouAEIOU]*)
    echo "your name starts with a vowel!"
  ;;
  0|9)
    echo "where does your name start with 0 or 9?"
  ;;
  [1-9]*) 
    echo "actually why are there even numbers in a name?"
  ;;
  [a-zA-Z]*) 
    echo "ok that's makes sense now"
  ;;
esac
{% endhighlight %}

**Loops:**

For loops

{% highlight r %}
# loop through a list
for var in list
do
  # stuff
done

# loop through numbers
for (( i=1; i <=5; i++ ))
do
  # stuff
done

for i in $(seq 1 10)
do
  # stuff
done
{% endhighlight %}


{% highlight r %}
# example
count=1
for fruit in "apple" "orange" "banna"
do
  echo "I like to eat eat eat ${fruit}."
  ((count=count+1))
done

# example: loop over arguments
for i in $@
do
  # stuff
done

# example: loop over files
for file in ./*
do
  # stuff
done
{% endhighlight %}

While loops

{% highlight r %}
while [ condition ]
do
  # stuff
done
{% endhighlight %}

Control within loops

* Skip to next iteration: `continue`
* Exit loop: `break`

**Functions and Aliasing:**


{% highlight r %}
# save the shortcut
alias shortcut="cd ~Desktop; nano temp.txt"

# run shortcut
shortcut

# remove alias
unalias shortcut

# view list of aliases
alias
{% endhighlight %}

## Sed

Sed is a command line tool to conduct regular expressions commands.

**Search and Replace Text:**

`(address)s/(search)/(replacement)/(modifier)`

* Addresses are specified: `start, end`
* Both search and replacement are strings
* Modifiers: 
  * `g`: global, replace for all occurances on the line
  * `p`: print only the lines where replacement occurs
  * `w`: write to a file
  * `I`: ignore case (only in Windows)


{% highlight r %}
# example: addresses
sed '1,2s/heart/love/' test.txt

# example: global modifier
echo "hi, hi, hi" | sed 's/hi/hello/'
echo "hi, hi, hi" | sed 's/hi/hello/g'

# example: print modifier
sed 's/heart/love/p' test.txt

# example: regex and backreferences
sed 's/\([1-9]*\) \(#\)/ \2 \1/' test.txt

# example: & as the matched string
sed 's/^[AEIOU][a-z]*/\*&\*/' test.txt

# example: write results out
sed 's/^[AEIOU][a-z]*/\*&\*/w output.txt' test.txt
{% endhighlight %}

* Apply a sequence of commands using a sed script

{% highlight r %}
# sed script
s/blue/black/g
s/windows/mac/g
s/square/circle/g

# call script
sed -f sed_script test.txtou
{% endhighlight %}

## Awk
Awk is a scripting language used for text extraction and processing. 

**Format of .awk File:**


{% highlight r %}
BEGIN{
  // initialize variables: executes only once
}
{
  /pattern/ {action}
  // runs every input line that matches optional pattern
}
END{
  // cleanup: executed once after file is exhausted
}
{% endhighlight %}


{% highlight r %}
# example
BEGIN{
  printf "Just getting started\n";
  n = 0;
}

{
  print ${0} // prints the line
  if(4 == 4) {++n} // increment n 
}

END{
  printf "We are at the end:" n; 
}

# run awk script
awk -f awk_script.awk test.txt
{% endhighlight %}


# Useful Locations

desk22.stat.wisc.edu:public/html

[linux_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMeXJRRWdFTFQzMEU/view?usp=sharing
