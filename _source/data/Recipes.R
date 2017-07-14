# Recipes
# Date: July 2017
# Author: Jenny Nguyen
# Email: jennifernguyen1992@gmail.com

recipes = list()

###################
# salad
ingredients = list(
  Other = c("sugar", "apple cider vinegar", "salt", "pepper"),
  Meat = "",
  Veggies = c("yellow onion", "lettuce"),
  Fruit = c("tomato")
)
instructions = data.frame(Instructions = c(
  "In a small bowl, mix sugar, apple cider vinegar, sliced yellow onion, and pinch of black pepper", 
  "Mix, taste, and adjust to liking", 
  "Slice tomatoes and sprinkle with salt and sugar", 
  "Cut lettuce to bite-sided pieces", 
  "Mix tomatoes, lettuce and sauce", 
  "Serve with rice and a meat dish"
))
recipes[["Salad"]] = list(ingredients = ingredients, instructions = instructions)
###################
# pad thai
ingredients = list(
  Other = c("sugar", "fish sauce", "tamarind concentrate", "noodles"),
  Meat = c("any", "eggs"),
  Veggies = c("any", "shallots", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Soak the noodles in warm water", 
  "Make the sauce by nearly boiling 3:1:1 ratio of sugar, fish sauce, tamarind concentrate", 
  "Fry half of the shallots and garlic on medium heat", 
  "Cook the meats on medium", 
  "Once meats done cooking, remove them from the heat and place aside", 
  "Fry the second half of the shallots and garlic", 
  "Add the noodles to the pan and stir around with a little water", 
  "Stir in a bit of the sauce", 
  "Make some room in the pan, sprinkle oil and eggs", 
  "Scramble the eggs and mix in with the noodles", 
  "Stir in the rest of the sauce", 
  "Mix in the meats and veggies", 
  "Let sit for few minutes to finish cooking"
))
recipes[["Pad Thai"]] = list(ingredients = ingredients, instructions = instructions)
###################
# fruit tart
ingredients = list(
  Other = c("graham crackers", "sugar", "margarine", "cinnamon", "salt", "whole milk", "vanilla", "flour", "cornstarch", "eggs"),
  Meat = "",
  Veggies = "",
  Fruit = c("any")
)
instructions = data.frame(Instructions = c(
  "Crust",
  "Finely crush about graham crackers",
  "Stir 1.5 cups graham cracker crumbs, 0.25 cup sugar, 0.5 tsp cinnamon and pinch of salt in large bowl",
  "Stir in 6 tbsp of melted margarine",
  "Ensure that the mixture has consistency of cookie dough (not too dry or wet)",
  "Press mixture to bottom of muffin pan with hands",
  "Freeze for 1 hour or bake at 325 degrees for 10 min then cool before filling",
  "Pastry Cream",
  "Mix together 0.25 cups of sugar and 3 eggs",
  "Add 2 tbsp flour and 2 tbsp cornstarch",
  "Mix to you get a smooth paste",
  "In a saucepan, add 1.25 cups whole milk and 1 tsp vanilla extract and bring to just boiling",
  "Remove milk mixture and slowly add to egg mixture, whisking constantly to prevent curdling",
  "Pour egg mixture into saucepan and cook over medium heat until boiling, whisking constantly",
  "When it boils, whisk mixture constantly for a minute until it becomes thick",
  "Remove from heat and whisk in 2 tbsp of margarine",
  "Pour into clean bowl and immediately cover with plastic wrap, with a few holes poked through",
  "Refridgerate for 2 hours before using",
  "Beat or whisk custard before using to remove any lumps",
  "Assembly",
  "Place custard on crust then add fruit"
))
recipes[["Fruit Tart"]] = list(ingredients = ingredients, instructions = instructions)
###################
# suon or thit ram
ingredients = list(
  Other = c("salt", "pepper", "sugar", "soy sauce", "corn starch"),
  Meat = c("pork spare ribs", "pork belly"),
  Veggies = c("shallots", "yellow onion", "green onions"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Cut pork spare ribs (suon) into squares or pork belly into slices",
  "Marinate meat with salt, pepper, and minced shallots",
  "Fry meat on medium high heat with thin layer of oil until brown",
  "Once meat is mostly cooked, turn heat down to medium low",
  "Add 2.5 spoons of sugar",
  "Add a solution of 3:4 ratio of soy sauce to water",
  "Sprinkle in a little bit of corn starch",
  "Turn heat down to low",
  "Add in sliced yellow onion and chopped green onions",
  "Wait a few minutes to fully cook"
))
recipes[["Suon or Thit Ram"]] = list(ingredients = ingredients, instructions = instructions)
###################
# green beans
ingredients = list(
  Other = c("salt", "pepper", "mushroom seasoning", "hoisin sauce"),
  Meat = "",
  Veggies = c("green beans", "mushrooms", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Heat minced garlic in pan with oil",
  "Add green beans and mushrooms",
  "Add small bowl of water",
  "Sprinkle in salt, pepper, mushroom seasoning or hoisin sauce",
  "Let cook until beans and mushrooms have softened"
))
recipes[["Fried Green Beans and Mushrooms"]] = list(ingredients = ingredients, instructions = instructions)
###################
# crab cake
ingredients = list(
  Other = c("bread crumbs", "mayo", "salt"),
  Meat = c("crab", "eggs"),
  Veggies = "",
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Extract crab meat from the body",
  "Add 1 egg to crab",
  "Add a spoonful of mayo and a pinch of salt",
  "Mix in bread crumbs",
  "Put in fridge for half hour",
  "Form patties and cover with bread crumbs",
  "Fry crab cakes carefully",
  "Place in sandwich bun"
))
recipes[["Crab Cake"]] = list(ingredients = ingredients, instructions = instructions)
###################
# fish sauce
ingredients = list(
  Other = c("nuoc mam", "sugar", "water", "vinegar"),
  Meat = "",
  Veggies = c("garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Mix nuoc mam, sugar and water at a 1:1:4 ratio",
  "Add a tiny amount of vinegar",
  "Adjust taste as necessary",
  "Mix in minced garlic"
))
recipes[["Nuoc Mam"]] = list(ingredients = ingredients, instructions = instructions)
###################
# fried fish
ingredients = list(
  Other = c("salt", "pepper", "nuoc mam"),
  Meat = c("catfish"),
  Veggies = c("shallots", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Mince shallots and garlic",
  "Cut catfish approximately 3 in long",
  "Marinate fish in salt, pepper, shallots, and garlic",
  "Let fish sit for half hour",
  "Fry fish on medium high heat with thin layer of oil",
  "Flip fish and fry other side on medium low heat",
  "Let sit for a few minutes to fully cook",
  "Eat with nuoc mam"
))
recipes[["Ca Chien (Fried Fish)"]] = list(ingredients = ingredients, instructions = instructions)
###################
# sushi
ingredients = list(
  Other = c("seaweed paper", "rice", "eel sauce", "rolling mat"),
  Meat = c("crab", "shrimp", "pork belly", "eggs"),
  Veggies = c("cucumber", "carrot", "spinach", "asparagus", "shallots", "yellow onion"),
  Fruit = c("avocado")
)
instructions = data.frame(Instructions = c(
  "Press 3/4 of the seaweed paper with rice with flip over with empty rice side near body",
  "Place sushi fillings in row",
  "Using rolling mat, tightly roll",
  "Filling options:",
  "avocado, carrot, cucumber, crab, shrimp, eel sauce, topped with fried shallots",
  "avocado, carrot, cucumber, crab, eel sauce, topped with fried shallots/onions",
  "avocado, carrot, cucumber, shrimp, eel sauce, topped with fried shallots/onions",
  "carrots, spinach, thin egg omelette, crab"
))
recipes[["Sushi"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Ga Chien (Fried Chicken)"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Rau Muong Xao Toi (Spinach Stir Fry)"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Dau Xiao Hanh (Tofu Green Onions Stir Fry)"]] = list(ingredients = ingredients, instructions = instructions)
###################
# spring rolls
ingredients = list(
  Other = c("Go Gai rice paper", "medium thick noodles", "housin sauce", "peanut butter", "salt"),
  Meat = c("pork belly", "jumbo shrimp"),
  Veggies = c("cucumber", "lettuce", "mint", "thai basil"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Boil pork belly with salt on medium high heat for 45 min (no pink juices when pierce), move to ice bath when done",
	"Boil shrimp on medium heat for 1-3 minutes until it turns pink, move to ice bath when done",
	"Slice pork belly and shrimp",
	"Prepare the noodles",
	"Clean and prepare the veggies",
	"To make sauce, dilute hoisin sauce & peanut butter with broth until the taste is right",
	"Make rolls"
))
recipes[["Goi Cuon (Spring Rolls)"]] = list(ingredients = ingredients, instructions = instructions)
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
  Veggies = c("green onions", "yellow onion", "cilantro", "dill"),
  Fruit = c("tomato")
)
instructions = data.frame(Instructions = c(
	"Heat yellow onion and tomatoes in pot on medium heat with sprinkle of oil",
	"When tomatoes have softened, add 1 bowl of water",
	"Add cilantro, green onions, dill",
	"Add tofu (fried if desired), pork chops, or cha ca",
	"Add 2 packs of wonton soup base",
	"Simmer for 15 minutes"
))
recipes[["Tomato Soup"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Dau Sot Ca Chua (Tofu and Tomatoes)"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Bap Cai Luoc (Cabbage and Egg Sauce)"]] = list(ingredients = ingredients, instructions = instructions)
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
	"Cook on low heat for 0.5 hour to reduce 50% of liquid"
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
recipes[["Canh Khoai Tay Suon (Taro and Pork Rib Soup)"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Canh Chua Ca (Sweet and Sour Fish Soup)"]] = list(ingredients = ingredients, instructions = instructions)
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
recipes[["Com Chien (Fried Rice)"]] = list(ingredients = ingredients, instructions = instructions)
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

