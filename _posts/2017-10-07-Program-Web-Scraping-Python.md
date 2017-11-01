---
layout: post
title: "Web Scraping with Python"
date: "October 17, 2017"
categories: Software
tags: Pipelines
---

* TOC
{:toc}




# Requests

{% highlight python %}
import requests

# get a webpage
r = requests.get(url)
r.url
r.status_code
r.history

# get cookies from a site
requests.get(url).cookies['requests-is']

# send cookies
cookies = {'cookies_are':'working'}
requests.get(url, cookies = cookies)

# logins
requests.get(url, auth = ('user', 'pass'))

# timeout
requests.get(url, timeout = secs)
{% endhighlight %}

# BeautifulSoup

This module is used for web scraping

{% highlight python %}
import requests
from bs4 import BeautifulSoup

page = requests.get(url)
soup = BeautifulSoup(page.content, 'html.parser')
{% endhighlight %}

Tags, classes, ids, etc can be extracted from the object.

{% highlight python %}
list(soup.children)
soup.find(tag)
soup.find_all(tag).text.strip()
soup.find_all(tag, "class", id = "id")
soup.find_all(tag, class_="class", id = "id", string="pattern or pattern_function")
{% endhighlight %}








r = requests.get('http://google.com/search',
	param = ('q': 'how long does a walrus lives?',
	'btnl': 'I'm feeling lucking))

rows= soup.find_all('tr', attrs=('class': 'clickablerow'))

soup.findAll()

soup.get_text()

