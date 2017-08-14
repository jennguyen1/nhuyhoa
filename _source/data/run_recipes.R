# Run Recipes - wrapper
# Date: July 2017
# Author: Jenny Nguyen
# Email: jennifernguyen1992@gmail.com

# initiate
library(jn.general)
lib(data)
source("_source/data/Recipes.R")

# display ingredients as a dataframe; so make each ingredient sublist same length
recipes <- map(recipes, function(x){
  m <- max(map_int(x$ingredients, length))
  x$display_ingredients <- map(x$ingredients, function(x) c(x, rep("", m - length(x)))) %>% as.data.frame()
  return(x)
})

# find the picture(s) for the recipe
for(n in names(recipes)){
  pics <- list.files("figure/food/", pattern = n %>% str_replace(" \\(.*", ""))
  recipes[[n]]$pics <- pics %>% str_subset("JPG") # can i handle movies?
}

# save recipes database into a file
save(recipes, file = "_source/data/recipes.Rdata")
save(recipes, file = "~/Desktop/recipe_finder/recipes.Rdata")

# generate recipe RMD files for website
make_script <- function(i){
  dish <- names(recipes)[i]

  # recipe pictures
  pic <- recipes[[i]]$pics %>%
    paste0("![pic", 1:length(.), "](http://jnguyen92.github.io/nhuyhoa/figure/food/", ., ")") %>%
    paste(collapse = "\n\n")
  pic <- ifelse(length(recipes[[i]]$pics) == 0, "", pic)

  # RMD template
  script <- c("---
layout: post
title: \"", dish, "\"
date: \"May 15, 2017\"
categories: ['recipes', '", recipes[[i]]$meal, "']
---

* TOC
{:toc}

```{r, echo = FALSE, warning = FALSE}
library(jn.general)
lib(data)
load('data/recipes.Rdata')
current <- recipes[['", dish, "']]
```

", pic,"

**Ingredients**

```{r, echo = FALSE}
current$display_ingredients %>% nhuyhoa_df_print(head = 100, data = FALSE, attribute = \"class = \\\"presenttab\\\"\")
```

<br>

**Instructions**

```{r, echo = FALSE}
current$instructions %>% nhuyhoa_df_print(head = 100, data = FALSE, attribute = \"class = \\\"presenttabnoh\\\"\")
```
") %>% paste(collapse = "")

  # save file
  file_name <- paste0("_source/2017-05-15-", dish %>% str_replace_all(" ", "-"), ".Rmd")
  write(script, file = file_name)
  return(script)
}

# make RMD script for each recipe
map(1:length(recipes), make_script)
