#TODO: pictures

# initiate
recipes = list()

# alfredo
ingredients = list(
  Other = c("pasta", "alfredo sauce", "salt", "pepper", "garlic", "yellow onion"),
  Meat = "", 
  Veggies = c("alfredo", "spinach", "mushrooms"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Boil pasta and veggies",
  "Heat garlic & onion in a pot",
  "Add alfredo sauce and veggies to pot", 
  "Add salt & pepper",
  "Simmer until ready to serve"
))
recipes[["alfredo"]] = list(ingredients = ingredients, instructions = instructions)

#################################################################################################################################

# for proper display of ingredients
recipes <- map(recipes, function(x){
  m <- max(map_int(x$ingredients, length))
  x$display_ingredients <- map(x$ingredients, function(x) c(x, rep("", m - length(x)))) %>% as.data.frame()
  return(x)
})

# save recipes into a file  
save(recipes, file = "_source/data/recipes.Rdata")

# generate recipe files
make_script <- function(dish){
script <- c("---
layout: post
title: \"Alfredo\"
date: \"May 15, 2017\"
categories: ['recipes']
---

* TOC
{:toc}

```{r, echo = FALSE, warning = FALSE}
library(jn.general)
lib(data)
load('data/recipes.Rdata') 
current <- recipes[['", dish, "']] 
```

**Ingredients**

```{r, echo = FALSE}
current$display_ingredients %>% nhuyhoa_df_print(data = FALSE, attribute = \"class = \\\"presenttab\\\"\")
```

<br>
  
**Instructions**
  
```{r, echo = FALSE}
current$instructions %>% nhuyhoa_df_print(data = FALSE, attribute = \"class = \\\"presenttabnoh\\\"\")
```
") %>% paste(collapse = "")
write(script, file = paste0("_source/2017-05-15-", dish, ".Rmd"))
return(paste(script, "done"))
}
  
map(names(recipes), make_script)
