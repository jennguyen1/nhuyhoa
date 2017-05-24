#TODO: pictures

# initiate
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
recipes[["Fried Chicken"]] = list(ingredients = ingredients, instructions = instructions)
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
  Veggies = c("green onions", "shallot"),
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
recipes[["Fried Tofu Stir Fry with Green Onions"]] = list(ingredients = ingredients, instructions = instructions)
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
  Meat = c("chinese sausages", "eggs"), 
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
  Meat = c("tofu", "pork ribs tips"), 
  Veggies = c("green onions", "yellow onions", "cilantro"),
  Fruit = c("tomatoes")
)
instructions = data.frame(Instructions = c(
	"Heat yellow onions and tomatoes in pot on medium heat with sprinkle of oil", 
	"When tomatoes have softened, add 1 bowl of water", 
	"Add cilantro, green onions",
	"Add chopped tofu (may be fried if desired)", 
	"Add prepared pork ribs (optional)", 
	"Add 2 packs of wonton soup base", 
	"Simmer for 15 minutes"
))
recipes[["Tofu Tomato Soup"]] = list(ingredients = ingredients, instructions = instructions)
###################
# tofu tomato sauce
ingredients = list(
  Other = c("fish sauce"),
  Meat = c("tofu"), 
  Veggies = c("green onions", "yellow onions"),
  Fruit = c("tomatoes")
)
instructions = data.frame(Instructions = c(
	"Fry tofu",
	"Heat yellow onions and tomatoes in pot on medium heat with sprinkle of oil", 
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
  Meat = c("egg"), 
  Veggies = c("cabbage"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Hard boil egg for 15 min",
	"Cut up and boil cabbage", 
	"Mash up egg and add fish sauce & water", 
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
	"When foam starts to form, lower heat and remove foam"
	"When foam all clear, turn to medium high heat and cover loosely with lid", 
	"Add wonton soup base",
	"The meat and broth can be combined with other options such as canh, etc", 
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
	"When foam starts to form, lower heat and remove foam"
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
  Veggies = c("shallots", "yellow onions"),
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
