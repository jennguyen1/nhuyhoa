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
   <td style="text-align:center;"> 0.9692088 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -2.1143351 </td>
   <td style="text-align:center;"> -0.0225586 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> TRUE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 101 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0.1912601 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -0.4223724 </td>
   <td style="text-align:center;"> 0.8057023 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 0.7621515 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7630863 </td>
   <td style="text-align:center;"> 0.1451066 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 102 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 0.9346914 </td>
   <td style="text-align:center;"> read </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> -1.4333777 </td>
   <td style="text-align:center;"> 0.9451850 </td>
   <td style="text-align:center;"> male </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
   <td style="text-align:center;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 103 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0.7774452 </td>
   <td style="text-align:center;"> math </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> -0.7721108 </td>
   <td style="text-align:center;"> 0.5729674 </td>
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

split, llply

# Using dplyr

## mutate

## summarise

## mutate_each and summarise_each

## do
mutate, summarise, do, summarise each, mutate each
weighted mean using summarise each
do is in - given a data frame, how do we split it up? extract 1st row etc

# Using data.table


