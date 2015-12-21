---
layout: post
title: "R Cool Functions List"
date: "July 24, 2015"
categories: R
---

* TOC
{:toc}



# Links

* [R reference][r_ref]{:target = "_blank"}
* [dplyr cheatsheet][dplyr_ref]{:target = "_blank"}
* [data.table cheatsheet][data.table_ref]{:target = "_blank"}

[r_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMMWN5dmhaT05IRkk/view?usp=sharing
[dplyr_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMblBxTjEwRWZXYjQ/view?usp=sharing
[data.table_ref]: https://drive.google.com/file/d/0B5VF_idvHAmMYUtxVHVUVFVDbGc/view?usp=sharing

The `broom` package has three main functions that deal with a variety of modeling functions

* `tidy`: extracts the model estimates and p-values
* `glance`: extracts the model statistics ($$R^2$$, etc)
* `augment`: extracts the individual data point statistics (fitted values, residuals, leverages, etc)


data.tables:
with = FALSE: j is a vector of names or positions to select (similar to data frames)
rbindlist: massive rbind of lists of df
DT[, .SD[which.max(i)], by = j]: saves the row that corresponds to max i for each unique j


* assign
* interaction
* na.omit
* complete.cases
* model.matrix
