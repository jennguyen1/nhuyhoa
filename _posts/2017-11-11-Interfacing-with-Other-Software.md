---
layout: post
title: "Interfacing with Other Software"
date: "November 11, 2017"
categories: Software
tags: Pipelines
---

* TOC
{:toc}



# SQLite

SQLite is a SQL database engine that reads and writes directly to ordinary disk files (don't need a server!).

**R**

{% highlight r %}
library(RSQLite)
connect <- dbConnect(drv = SQLite(), dbname = db)
df <- RSQLite::dbGetQuery(conn = connect, statement = query)
RSQLite::dbDisconnect(conn = connect)
{% endhighlight %}

**Python**

{% highlight python %}
import sqlite3

with sqlite3.connection(db, isolation_level = None) as connection:
  c = connection.cursor()
  
  # write to table
  c.execute("INSERT INTO table VALUES ('z', 0, 'x')")
  c.executemany("INSERT INTO table VALUES (?, ?, ?)", 
    [('a', 1, 'x'), 
    ('b', 2, 'x'),
    ('c', 3, 'x')]
  )

  # read from table
  c.execute('select * from table')
  c.fetchone()
  c.fetchall()

  # execute a script
  script = """
  SELECT * from table;
  SELECT id from table;
  """
  c.executescript(script)
  
  # make a function
  connection.create_function("f", nargs, py_function)
  c.execute("select f(id) from table")
  connection.create_aggregate("agg", nargs, py_class)
{% endhighlight %}


# JSON

JSON (JavaScript Object Notation) is a file format for data. It's format is similar to that of Python's dictionary. 

JSON supports the following data types

* numbers
* strings (double quotes)
* dictionaries {"key": "value"}
* arrays ["value"]
* miscellaneous: true, false, null

**R**

{% highlight r %}
library(rjson)
fromJSON(file = "file.json")
write(toJSON(obj), file = "file.json")
{% endhighlight %}

**Python**

{% highlight python %}
import json
with open("file.json", 'r') as f:
  d = json.load(f)
with open("file.json", 'w') as f:
  json.dump(d, f)
{% endhighlight %}

