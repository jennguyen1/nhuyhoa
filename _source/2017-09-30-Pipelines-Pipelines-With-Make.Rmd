---
layout: post
title: "Pipelines with Make"
date: "September 30, 2017"
categories: ['pipelines']
---

* TOC
{:toc}

Pipeline managers automatically knows what step of the pipeline needs to be run. It will check the time stamp and make sure that the target was compiled after the dependencies. To update only the time stamp of a file do `touch file`.

Files like input files and code scripts should go in the dependencies section whereas output files should go into the targets section. It is also helpful to name the code scripts by the order in which they are called, for better readability. It is also best practice to have an `all` rule at the top of the pipeline (which makes all targets in the pipeline).


# Snakemake

A snakemake pipeline is written into a Snakefile.

**Format**

THe following is an example of a rule

{% highlight python %}
CMD = "python3"
lib = {'a':4, 'b': "data2.txt"}

rule rule_name:
  message: "Summary message"
  params: 
    p1 = "FJIW837",
    p2 = lambda wildcards: "a" if wildcards.v1 == "1" else "b"
  input: 
    script = os.path.join(SCRIPTS, "1_run_this.py"),
    in1 = "data{v1}.txt",
    in2 = lib['b']
  output:
    out1 = "plots{v1}.pdf"
  shell:
    "{CMD} {input.script} {input.in1} {wildcards.v1} {params.p1} {lib[a]}"
  onsuccess:
    shell("mail -s 'Success!' email@address.com")
  onerror:
    shell("mail -s 'Error! See logs' email@address.com")
{% endhighlight %}

A few notes on the format:

* Arguments are entered in python fashion: strings, lists, functions
* Arguments may be named or unnamed, they are accessed in shell section by the name or index
* Wildcards in the input/output allow for flexibility 
* Commands can be sent to the shell within the `shell` section or with the function `shell()` in other sections
* Variables declared outside of a rule can be used in the rule (python syntax) and shell command (use brackets)

**Special Functions**

* `expand("pattern", var1 = VAR1, var2 = VAR2)` generates all possible combinations
* `expand("pattern1 pattern2".split(), zip, var1 = VAR1, var2 = VAR2)` vectorized paste
* `protected("filename")` in output, write-protects file after rule is completed
* `temp("filename")` in output, deletes file after all rules that use it as inputs is completed
* `touch("filename")` in output, touches and generates a file after command finishes

**Configuration**

Configuration files allow for additional customization of a pipeline. 

Config files should be in JSON (or YAML) format
{% highlight json %}
{
  "key":"value", 
  "type":"a"
}
{% endhighlight %}

Config files can be imported into a Snakefile with the line

{% highlight python %}
configfile: "config.json"
{% endhighlight %}

This saves the configuration settings into a dictionary called `config`, which can then be accessed in the Snakefile.

**Running Snakemake**

{% highlight linux %}
# run and print out shell cmds
snakemake -p

# outputs a dry run (does not execute)
snakemake -np

# add a timestamp
snakemake -T

# prints out reason for rerun
snakemake -r

# forces execution of a rule / all rules
snakemake -f rule
snakemake -F

# shows all available rules
snakemake -l
snakemake -Fnp

# running in parallel (jobs that don't rely on each other)
snakemake --cores n

# prints summary
snakemake -S
snakemake -D
{% endhighlight %}


# GNU Make

**Format**

The format of a make command is 

{% highlight make %}
targets : dependencies
  actions
{% endhighlight %}

Fake targets can be generated like so
{% highlight make %}
.PHONY : clean
clean :
  rm -f *
{% endhighlight %}

It can be useful when calling with wildcards. In the example below, an action is not required.

{% highlight make %}
.PHONY : all
all : target target2
{% endhighlight %}

**Set Variables**

To set and call variables
{% highlight make %}
R=/home/bin/Rscript
$(R)
{% endhighlight %}

Variables can be set in an external file and incorporated into the Makefile.

{% highlight make %}
include configure.mk
{% endhighlight %}

**Automatic Variables**

* `$@` target
* `$^` dependencies
* `$<` first dependency
* `$*` pattern match to %
* `$(@D)` directory of target dir/foo -> dir
* `$(@F)` file of target dir/foo -> foo
* `$(<D)`
* `$(<F)` dir/file of first dependency
* `$(^D)`
* `$(^F)` dir/file of dependencies

**Wildcards**

Wildcard rules can be declared like so

{% highlight make %}
%.dat : books/%.txt wc.py
	python wc.py $< $*.dat
{% endhighlight %}

`%` can only be used in targets/dependencies, `$*` can be used to match `%`.

It can be called with an actual file name

{% highlight make %}
all : something.dat
{% endhighlight %}

**Functions**

* `$(subst from, to, text)` replace each occurrence of from to to in text
* `$(patsubst pattern, replacement, text)` replaces pattern in text with replacement; only changes it once; could be % which is a wildcard
* `$(strip string)` removes whitespace on ends
* `$(findstring find, in)` searches for find in in
* `$(filter pattern, text)` returns all words in text that matches pattern
* `$(filter-out pattern, text)` opposite of filter
* `$(sort list)` sorts the list
* `$(word n, text)` returns nth word of text; start from 1
* `$(wordlist s, e, text)` returns list of words in text starting with word s and ending with e
* `$(words text)` number of words in text
* `$(firstword names)` first word in list
* `$(lastword names)` last word in list

* `$(dir names)` directory
* `$(notdir names)` filename
* `$(suffix names)` file suffixes
* `$(basename names)` file name w/o suffix
* `$(addsuffix suffix, names)` adds a suffix to file names
* `$(addprefix prefix, names)` adds a prefix to file names
* `$(join list1, list2)` vectorized paste
* `$(wildcard pattern)` regex

* `$(shell cmd)` run a shell command

**Running Make**

{% highlight linux %}
# run the Makefile
make

# writes out specific commands that need to be run
make -n

# runs a specific rule called help
make help
{% endhighlight %}

**Example**

{% highlight make %}
include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))

## all         : Generate Zipf summary table and plots of word counts.
.PHONY : all
all : results.txt $(PNG_FILES)

## results.txt : Generate Zipf summary table.
results.txt : $(DAT_FILES) $(ZIPF_SRC)
	$(ZIPF_EXE) $(DAT_FILES) > $@

## dats        : Count words in text files.
.PHONY : dats
dats : $(DAT_FILES)

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $@

## pngs        : Plot word counts.
.PHONY : pngs
pngs : $(PNG_FILES)

%.png : %.dat $(PLOT_SRC)
	$(PLOT_EXE) $< $@

## clean       : Remove auto-generated files.
.PHONY : clean
clean :
	rm -f $(DAT_FILES)
	rm -f $(PNG_FILES)
	rm -f results.txt

## variables   : Print variables.
.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)
	@echo PNG_FILES: $(PNG_FILES)

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
{% endhighlight %}
