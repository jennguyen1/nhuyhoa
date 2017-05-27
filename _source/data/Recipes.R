
# initiate
library(jn.general)
lib(data)
recipes = list()
###################
# alfredo
ingredients = list(
  Other = c("pasta", "alfredo sauce", "salt", "pepper"),
  Meat = "",
  Veggies = c("asparagus", "spinach", "mushrooms", "yellow onion", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Boil pasta and veggies",
  "Heat garlic & onion in a pot",
  "Add alfredo sauce and veggies to pot",
  "Add salt & pepper",
  "Simmer until ready to serve"
))
recipes[["Alfredo"]] = list(ingredients = ingredients, instructions = instructions)
###################
# cha ca
ingredients = list(
  Other = "",
  Meat = c("Lee's Seafood Co cha ca dac biet fish paste"),
  Veggies = c("dill"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Defrost the cha ca fish paste",
  "Mix fish paste with dill",
  "Fry on low heat with thin layer of oil, flipping when golden",
  "Let sit for a few minutes to fully cook"
))
recipes[["Cha Ca"]] = list(ingredients = ingredients, instructions = instructions)
###################
# fried chicken
ingredients = list(
  Other = c("salt", "pepper", "soy sauce"),
  Meat = c("chicken legs or wings"),
  Veggies = c("shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Marinate chieck with salt, pepper, shallots, and soy sauce",
  "Fry chicken on medium low heat with thin layer of oil",
  "Let sit for a few minutes to fully cook"
))
recipes[["Ga Chien"]] = list(ingredients = ingredients, instructions = instructions)
###################
# stir fried spinach
ingredients = list(
  Other = c("salt", "sugar", "nuoc mam", "oyster sauce"),
  Meat = "",
  Veggies = c("spinach", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Heat chopped garlic on medium heat with a little oil",
  "Add a lot of spinach (a lot, will shrink)",
  "Stir and add salt, sugar, nuoc mam",
  "Stir and add oyster sauce",
  "Stir for a few minutes"
))
recipes[["Rau Muong Toi"]] = list(ingredients = ingredients, instructions = instructions)
###################
# stir fried tofu
ingredients = list(
  Other = c("nuoc mam"),
  Meat = c("tofu"),
  Veggies = c("green onions", "shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Cut shallots and green onions",
	"Make a mixture of water and nuoc mam in a small bowl",
	"Fry tofu",
	"In saucer, golden the shallots",
	"Add green onions and stir until they soften",
	"Add tofu and stir",
	"Add sauce mixture and stir",
	"Heat for approximately 5 min"
))
recipes[["Dau Xiao Hanh"]] = list(ingredients = ingredients, instructions = instructions)
###################
# spring rolls
ingredients = list(
  Other = c("Go Gai rice paper", "medium thick noodles", "housin sauce", "peanut butter", "salt"),
  Meat = c("pork belly", "jumbo shrimp"),
  Veggies = c("cucumber", "lettuce", "mint", "thai basil"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Boil pork belly with salt on medium heat for 30 min (no pink juices when pierce), move to ice bath when done",
	"Boil shrimp on medium heat for 1-3 minutes until it turns pink, move to ice bath when done",
	"Slice pork belly and shrimp",
	"Prepare the noodles",
	"Clean and prepare the veggies",
	"To make sauce, dilute hoisin sauce & peanut butter with broth until the taste is right",
	"Make rolls"
))
recipes[["Goi Cuon"]] = list(ingredients = ingredients, instructions = instructions)
###################
# bo bia
ingredients = list(
  Other = c("Go Gai rice paper", "medium thick noodles", "housin sauce", "peanut butter"),
  Meat = c("chinese pork sausages", "eggs"),
  Veggies = c("cucumber", "lettuce", "mint", "thai basil"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Boil chinese sausages for 15 min, move to ice bath when done",
	"Make thin egg omeletes, one egg at a time",
	"Slice sausages and eggs",
	"Prepare the noodles",
	"Clean and prepare the veggies",
	"To make sauce, dilute hoisin sauce & peanut butter with broth until the taste is right",
	"Make rolls"
))
recipes[["Bo Bia"]] = list(ingredients = ingredients, instructions = instructions)
###################
# tofu tomato soup
ingredients = list(
  Other = c("wonton soup base"),
  Meat = c("tofu", "pork ribs tips", "Lee's Seafood Co cha ca dac biet fish paste"),
  Veggies = c("green onions", "yellow onion", "cilantro"),
  Fruit = c("tomato")
)
instructions = data.frame(Instructions = c(
	"Heat yellow onion and tomatoes in pot on medium heat with sprinkle of oil",
	"When tomatoes have softened, add 1 bowl of water",
	"Add cilantro, green onions",
	"Add chopped tofu (may be fried if desired)",
	"Add prepared pork ribs or cha ca (optional)",
	"Add 2 packs of wonton soup base",
	"Simmer for 15 minutes"
))
recipes[["Tofu Tomato Soup"]] = list(ingredients = ingredients, instructions = instructions)
###################
# tofu tomato sauce
ingredients = list(
  Other = c("fish sauce"),
  Meat = c("tofu"),
  Veggies = c("green onions", "yellow onion"),
  Fruit = c("tomato")
)
instructions = data.frame(Instructions = c(
	"Fry tofu",
	"Heat yellow onion and tomatoes in pot on medium heat with sprinkle of oil",
	"When tomatoes have softened, add very small bowl of water",
	"Add fried tofu",
	"Add green onions",
	"Add with nuoc mam and water for flavor",
	"Simmer for 15 minutes"
))
recipes[["Dau Sot Ca Chua"]] = list(ingredients = ingredients, instructions = instructions)
###################
# cabbage and egg
ingredients = list(
  Other = c("fish sauce"),
  Meat = c("eggs"),
  Veggies = c("cabbage"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Hard boil egg for 15 min",
	"Cut up and boil cabbage",
	"Mash up egg and add fish sauce & water"
))
recipes[["Bap Cai Luoc"]] = list(ingredients = ingredients, instructions = instructions)
###################
# Pork or Chicken Broth
ingredients = list(
  Other = c("wonton soup base", "salt", "pepper"),
  Meat = c("pork ribs tips", "chicken wing tips"),
  Veggies = c("shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Marinate the meat in salt, pepper, shallots",
	"Boil water on medium heat",
	"Add meat",
	"When foam starts to form, lower heat and remove foam",
	"When foam all clear, turn to medium high heat and cover loosely with lid",
	"Add wonton soup base",
	"The meat and broth can be combined with other options such as canh, etc"
))
recipes[["Pork or Chicken Broth"]] = list(ingredients = ingredients, instructions = instructions)
###################
# nui
ingredients = list(
  Other = c("macaroni", "wonton soup base", "salt", "pepper"),
  Meat = c("pork ribs tips"),
  Veggies = c("mustard greens", "shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Marinate the pork in salt, pepper, shallots",
	"Boil water on medium heat",
	"Add pork rib tips",
	"When foam starts to form, lower heat and remove foam",
	"When foam all clear, turn to medium high heat and cover loosely with lid",
	"Add 2 packs of wonton soup base",
	"Boil mustard greens separately",
	"Make noodles separately",
	"Combine noodles, mustard greens, and soup broth with pork in a bowl"
))
recipes[["Nui"]] = list(ingredients = ingredients, instructions = instructions)
###################
# thit kho
ingredients = list(
  Other = c("salt", "pepper", "nuoc mam", "nuoc mau"),
  Meat = c("pork belly", "eggs"),
  Veggies = c("shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Clean pork belly with water and salt, trim excess fat",
	"Cut pork belly into cubes",
	"Marinate pork belly with salt, pepper, and shallots",
	"Hard boil eggs",
	"Cook pork belly in pan on low heat",
	"Drizzle 3-4 spoons of nuoc mau",
	"After pork belly done sizzling, add water up to top level of pork",
	"Cook on low for 1.5 - 2 hours, removing meat foam",
	"Add eggs",
	"Add nuoc mam for flavor",
	"Cook on low heat for 0.5 hour"
))
recipes[["Thit Kho"]] = list(ingredients = ingredients, instructions = instructions)
###################
# ca kho
ingredients = list(
  Other = c("salt", "pepper", "nuoc mam", "nuoc mau"),
  Meat = c("catfish"),
  Veggies = c("shallots", "yellow onion"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Coat pan with oil",
	"Layer the pan bottom with yellow onion strips and sprinkle in pepper",
	"Clean catfish with water and salt",
	"Marinate catfish with salt, pepper, and shallots",
	"Place fish on top of onions",
	"Drizzle 3-4 spoons of nuoc mau",
	"Heat on low for a little bit",
	"Pour in just enough water to cover fish",
	"Boil on medium heat",
	"After 30 min add nuoc mam for flavoring",
	"Cook for another 30 min"
))
recipes[["Ca Kho"]] = list(ingredients = ingredients, instructions = instructions)
###################
# nuoc mau
ingredients = list(
  Other = c("sugar"),
  Meat = "",
  Veggies = "",
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Add a lot of sugar to pot (no oil)",
	"Heat on high power until dissolved and bubbles start to form",
	"Turn off heat",
	"Quickly add small cup of water",
	"Once cooled, save in a glass container"
))
recipes[["Nuoc Mau"]] = list(ingredients = ingredients, instructions = instructions)
###################
# taro soup
ingredients = list(
  Other = c("wonton soup base", "salt", "pepper"),
  Meat = c("pork rib tips"),
  Veggies = c("taro or yam", "rice paddy herbs"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Marinate the pork in salt, pepper, shallots",
	"Boil water on medium heat",
	"Add pork rib tips",
	"When foam starts to form, lower heat and remove foam",
	"When foam all clear, turn to medium high heat and cover loosely with lid",
	"Add 2 packs of wonton soup base",
	"Boil taro or yam in a separate pot",
	"Add taro or yam to pork broth",
	"Add rice paddy herbs"
))
recipes[["Canh Khoai Tay Suon"]] = list(ingredients = ingredients, instructions = instructions)
###################
# catfish soup
ingredients = list(
  Other = c("tamarind pulp", "salt", "pepper", "sugar", "nuoc mam"),
  Meat = c("catfish"),
  Veggies = c("elephant ear stem", "rice paddy herbs", "green onions", "bean sprouts"),
  Fruit = c("tomato", "pineapple")
)
instructions = data.frame(Instructions = c(
	"Cut up tomatoes, pineapple, elephant ear stem, herbs into small chunks",
	"Pour boiling water into 1.5 spoonfuls of smashed tamarind pulp in a bowl",
	"Marinate catfish with salt and pepper",
	"Fry some garlic until golden then remove and save for later",
	"Add some water to a pot",
	"Drain liquid from tamarind into pot, discard excess pulp",
	"Add 4 spoons of sugar",
	"Add 4 spoons of nuoc mam",
	"Add catfish and boil for 10ish min",
	"Remove catfish from stew",
	"Add in veggies and cook",
	"Put the catfish back into the stew",
	"Adjust tastes as necessary",
	"Add the garlic"
))
recipes[["Canh Chua Ca"]] = list(ingredients = ingredients, instructions = instructions)
###################
# spaghetti
ingredients = list(
  Other = c("spaghetti", "Rinaldi sauce"),
  Meat = c("ground beef"),
  Veggies = c("mushrooms", "spinach", "yellow onion", "shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Prepare the noodles",
  "Cook shallots in pot with oil",
  "Cook ground beef and drain meat fat",
  "Add Rinaldi pasta sauce",
  "Simmer",
  "Add nuoc mam for taste",
  "Add mushrooms and onions",
  "Simmer"
))
recipes[["Spaghetti"]] = list(ingredients = ingredients, instructions = instructions)
###################
# fried rice
ingredients = list(
  Other = c("rice", "salt", "pepper", "soy sauce"),
  Meat = c("any", "eggs"),
  Veggies = c("any", "garlic", "shallots", "yellow onion"),
  Fruit = c("any")
)
instructions = data.frame(Instructions = c(
  "Make rice day before with less water, refrigerate for 1 day",
  "Prepare the meat and veggies, thoroughly dry",
  "Cook shallots, garlic, onions in pan with oil until golden",
  "Add eggs on low power",
  "Add salt, pepper, soy sauce",
  "Mix in rice",
  "Add seasonings to liking",
  "Stir in meat and veggies"
))
recipes[["Com Chien"]] = list(ingredients = ingredients, instructions = instructions)
###################
# sweet potato fries
ingredients = list(
  Other = c("cornstarch", "salt", "garlic powder"),
  Meat = "",
  Veggies = c("sweet potato"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Cut sweet potato fries into strips",
  "Soak in water for 45 min",
  "Dry off potatoes",
  "Cover in cornstarch",
  "Sprinkle in garlic powder and oil",
  "Spread out on baking pan",
  "Cook at 400 degrees F for 30 min, flip in between",
  "Take out and sprinkle with salt"
))
recipes[["Sweet Potato Fries"]] = list(ingredients = ingredients, instructions = instructions)

#################################################################################################################################

# for proper display of ingredients
recipes <- map(recipes, function(x){
  m <- max(map_int(x$ingredients, length))
  x$display_ingredients <- map(x$ingredients, function(x) c(x, rep("", m - length(x)))) %>% as.data.frame()
  return(x)
})

# for uploading the images
for(n in names(recipes)){

  pics <- list.files("figure/food/", pattern = n)
  recipes[[n]]$pics <- pics %>% str_subset("JPG") # can i handle movies?
  
}

# save recipes into a file
save(recipes, file = "_source/data/recipes.Rdata")
save(recipes, file = "~/Desktop/recipe_finder/recipes.Rdata")

# generate recipe files
make_script <- function(i){
  dish <- names(recipes)[i]
  pic <- recipes[[i]]$pics %>% 
    paste0("![pic", 1:length(.), "](http://jnguyen92.github.io/nhuyhoa/figure/food/", ., ")") %>% 
    paste(collapse = "\n")
  pic <- ifelse(length(recipes[[i]]$pics) == 0, "", pic)
  
  script <- c("---
layout: post
title: \"", dish, "\"
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
  write(script, file = paste0("_source/2017-05-15-", dish %>% str_replace_all(" ", "-"), ".Rmd"))
  return(paste(script, "done"))
}

map(1:length(recipes), make_script)

