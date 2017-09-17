# Recipes - database
# Date: July 2017
# Author: Jenny Nguyen
# Email: jennifernguyen1992@gmail.com

recipes = list()



#----------------------------------------------------------------------------------------------------------
# canh muop mong toi
ingredients = list(
  Other = c("salt", "pepper", "fried shrimp", "wonton soup base"),
  Meat = "",
  Veggies = c("luffa", "spinach", "shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Soak fried shrimp in hot water and mash fried shrimp", 
  "Wash and cut the luffa (chinese/taiwanese okra), spinach, shallots", 
  "Stir fry luffa & shallots with salt & pepper", 
  "Add bowl of fried shrimp & additional water",
  "Add wonton soup base",
  "Add spinach (asian spinach) prior to boiling",
  "Adjust to taste as necessary", 
  "", 
  "Canh spoils easily, so refridgerate when cool"
))
recipes[["Canh Muop Mong Toi"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# thit heo luoc cham tom mam
ingredients = list(
  Other = c("salt", "pepper", "tom mam"),
  Meat = c("pork belly"),
  Veggies = "",
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Marinate pork belly with salt and pepper",
  "Boil pork belly on medium high heat for 60 min, move to ice bath when done",
  "Slice pork belly", 
  "Serve with tom mam sauce"
))
recipes[["Thit Heo Luoc Cham Tom Mam"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# che thai
ingredients = list(
  Other = c("nata de coco", "half & half"),
  Meat = "",
  Veggies = c("water chestnuts"),
  Fruit = c("longan", "lychee", "jackfruit")
)
instructions = data.frame(Instructions = c(
  "Cut the jackfruit into strips, water chestnuts into small cubes",
  "Combine longan, lychee, jackfruit, water chestnuts, and nata de coco in a big container", 
  "Add half of the syrup form the (fruit) cans and 2 cups of half & half",
  "Mix well and serve with crushed ice"
))
recipes[["Che Thai"]] = list(ingredients = ingredients, instructions = instructions, meal = "dessert", youtube = "")
#----------------------------------------------------------------------------------------------------------
# tofu mushroom stir fry
ingredients = list(
  Other = c("soy sauce", "sugar"),
  Meat = c("tofu"),
  Veggies = c("shallots", "garlic", "mushrooms", "bean sprouts", "green onions"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Fry tofu",
  "Heat minced shallots and garlic in oil on medium heat",
  "Stir in sliced mushrooms",
  "Stir in soy sauce & sugar",
  "Stir in fried tofu",
  "Stir in bean sprouts & green onions",
  "Adjust to taste with soy sauce & sugar"
))
recipes[["Tofu Mushroom Stir Fry"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# bourbon chicken
ingredients = list(
  Other = c("soy sauce", "brown sugar", "cornstarch"),
  Meat = c("chicken thighs"),
  Veggies = c("shallots", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Heat minced shallots & garlic in oil on medium heat",
  "Add chicken and cook until brown",
  "Stir in a 2:2:1 mixture of soy sauce, brown sugar and water",
  "Add some cornstarch to thicken sauce",
  "Add green onions"
))
recipes[["Bourbon Chicken"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# 7 layer bar
ingredients = list(
  Other = c("graham crackers", "sweetened condensed milk", "coconut flakes", "chocolate chips", "butterscotch chips", "chopped nuts", "margarine"),
  Meat = "",
  Veggies = "",
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Preheat oven to 350 degrees F",
  "Melt butter and coat pan",
  "Mix in graham cracker crumbs and press mixture into pan",
  "Evely pour on sweetened condensed milk over graham cracker layer",
  "Layer with coconut flakes, chocolate chips, butterscotch chips, and nuts",
  "Evenly press mixture down on milk",
  "Bake for 25-30 min",
  "Cool and cut bars",
  "Store at room temp"
))
recipes[["7 Layer Bar"]] = list(ingredients = ingredients, instructions = instructions, meal = "dessert", youtube = "")
#----------------------------------------------------------------------------------------------------------
# wonton soup
ingredients = list(
  Other = c("wonton wrappers", "egg noodles", "wonton soup base", "salt", "pepper"),
  Meat = c("chicken broth", "ground pork", "shrimp", "pork xa xiu"),
  Veggies = c("water chestnuts", "shallots", "green onions", "bok choy"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Make chicken broth according to chicken broth recipe (as an alternative mix 4 parts chicken broth to 1.5 part water and wonton soup base)",
  "Clean & cut up bok choy, green onions, xa xiu",
  "Make wontons according to fried wonton recipe ",
  "Add wontons to pot of boiling water, once it has floated to the surface cook for 2-3 more min",
  "Cook egg noodle soup per instructions (boil for 2-3 min)",
  "Assemble bowl with noodles, veggies, wontons and xa xiu",
  "Pour boiling broth into bowl",
  "Sprinkle with fried shallots"
))
recipes[["Wonton Soup (Mi Hoanh Thanh)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# potstickers
ingredients = list(
  Other = c("wonton wrappers", "salt", "pepper", "sugar", "soy sauce", "vinegar"),
  Meat = c("ground pork", "shrimp"),
  Veggies = c("water chestnuts", "shallots", "green onions"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Put raw shrimp into a food processor, pulse a few times, do not grind to a paste form",
  "Mix 2 parts shrimp 1 part ground pork into a bowl",
  "Add minced water chestnuts and shallots",
  "Sprinkle a bit of salt and pepper",
  "Wrap small spoonful of mix into circular wonton wrappers (Twin Marquis brand)",
  "Fry both sides of potstickers in a pan with some oil",
  "Add a small bowl of water and cover to steam potstickers" ,
  "Ensure the meats inside are fully cooked before removing from pan",
  "To make the sauce, mix diluted soy sauce, bit of vinegar, pinch of sugar, bit of stir fried green onions"
))
recipes[["Wonton Fried"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Salad"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# pad thai
ingredients = list(
  Other = c("sugar", "nuoc mam", "tamarind concentrate", "noodles"),
  Meat = c("any", "eggs"),
  Veggies = c("any", "shallots", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Soak the noodles in warm water",
  "Make the sauce by nearly boiling 3:1:1 ratio of sugar, nuoc mam, tamarind concentrate",
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
recipes[["Pad Thai"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
  "Stir 1 pack of graham cracker crumbs, 0.25 cup sugar, 0.5 tsp cinnamon and pinch of salt in large bowl",
  "Slowly stir in 5 tbsp of melted margarine",
  "Ensure that the mixture has consistency of cookie dough (not too dry or wet)",
  "Press mixture to bottom of muffin pan with hands",
  "Freeze for 1 hour or bake at 325 degrees for 10 min then cool before filling",
  "", 
  "Pastry Cream",
  "Mix together 1 tbsp + 1 tsp of sugar and 1 egg",
  "Add 2 tsp flour and 2 tsp cornstarch",
  "Mix to you get a smooth paste",
  "In a saucepan, add 6 tbsp + 2 tsp whole milk and 0.33 tsp vanilla extract and bring to just boiling",
  "Remove milk mixture and slowly add to egg mixture, whisking constantly to prevent curdling",
  "Pour egg mixture into saucepan and cook over medium heat until boiling, whisking constantly",
  "When it boils, whisk mixture constantly for a minute until it becomes thick",
  "Remove from heat and whisk in 2 tsp of margarine",
  "Pour into clean bowl and immediately cover with plastic wrap, with a few holes poked through",
  "Refridgerate for 2 hours before using",
  "Beat or whisk custard before using to remove any lumps",
  "", 
  "Assembly",
  "Place custard on crust then add fruit"
))
recipes[["Fruit Tart"]] = list(ingredients = ingredients, instructions = instructions, meal = "dessert", youtube = "")
#----------------------------------------------------------------------------------------------------------
# suon or thit ram
ingredients = list(
  Other = c("salt", "pepper", "sugar", "soy sauce", "cornstarch"),
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
  "Sprinkle in a little bit of cornstarch",
  "Turn heat down to low",
  "Add in sliced yellow onion and chopped green onions",
  "Wait a few minutes to fully cook"
))
recipes[["Suon or Thit Ram"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Fried Green Beans and Mushrooms"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Crab Cake"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# nuoc mam pha
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
recipes[["Nuoc Mam Pha"]] = list(ingredients = ingredients, instructions = instructions, meal = "other", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Ca Chien (Fried Fish)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Sushi"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# alfredo
ingredients = list(
  Other = c("pasta", "alfredo sauce", "salt", "pepper", "garlic salt"),
  Meat = c("chicken", "shrimp"),
  Veggies = c("asparagus", "spinach", "mushrooms", "yellow onion", "garlic"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Boil pasta and veggies",
  "Heat garlic & onion in a pot",
  "Cook the chicken and shrimp",
  "Add alfredo sauce and veggies to pot",
  "Add salt, pepper & garlic salt",
  "Simmer until ready to serve"
))
recipes[["Alfredo"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Cha Ca"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Ga Chien (Fried Chicken)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# stir fried spinach
ingredients = list(
  Other = c("mam tom"),
  Meat = "",
  Veggies = c("spinach", "garlic", "shallots"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
  "Heat minced garlic and shallots on medium heat with a little oil",
  "Add a lot of spinach",
  "If using watch spinach (ong choy, rau muong), blanch (boil and ice bath) before frying",
  "Stir in diluted mam tom",
  "Stir for a few minutes"
))
recipes[["Rau Muong Xao Toi (Spinach Stir Fry)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Dau Xiao Hanh (Tofu Green Onions Stir Fry)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# spring rolls
ingredients = list(
  Other = c("Go Gai rice paper", "noodles", "hoisin sauce", "peanut butter", "salt"),
  Meat = c("pork belly", "jumbo shrimp"),
  Veggies = c("cucumber", "lettuce", "mint", "thai basil"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Boil pork belly with salt on medium high heat for 60 min (no pink juices when pierce), move to ice bath when done",
	"Boil shrimp on medium heat for 1-3 minutes until it turns pink, move to ice bath when done",
	"Slice pork belly and shrimp",
	"Prepare the noodles",
	"Clean and prepare the veggies",
	"To make sauce, dilute hoisin sauce & peanut butter with broth until the taste is right",
	"Make rolls"
))
recipes[["Goi Cuon (Spring Rolls)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# bo bia
ingredients = list(
  Other = c("Go Gai rice paper", "noodles", "hoisin sauce", "peanut butter"),
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
recipes[["Bo Bia"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# Canh cha ca
ingredients = list(
  Other = c("wonton soup base", "nuoc mam pha"),
  Meat = c("Lee's Seafood Co cha ca dac biet fish paste"),
  Veggies = c("green onions", "yellow onion", "shallots", "dill"),
  Fruit = c("tomato")
)
instructions = data.frame(Instructions = c(
  "Heat yellow onion, shallots, and tomatoes in pot on medium heat with sprinkle of oil",
  "When tomatoes have softened, add 1 bowl of water",
  "Add cha ca",
  "Add green onions and dill",
  "Add wonton soup base and nuoc mam pha, adjust to taste",
  "Simmer for 15 minutes"
))
recipes[["Canh Cha Ca"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# tofu tomato soup
ingredients = list(
  Other = c("wonton soup base", "nuoc mam pha"),
  Meat = c("tofu", "pork ribs tips"),
  Veggies = c("green onions", "yellow onion", "shallots", "cilantro"),
  Fruit = c("tomato")
)
instructions = data.frame(Instructions = c(
	"Heat yellow onion, shallots, and tomatoes in pot on medium heat with sprinkle of oil",
	"When tomatoes have softened, add 1 bowl of water",
	"Add cilantro, green onions, etc",
	"Add tofu (fried if desired), pork chops, or cha ca",
	"Add 2 packs of wonton soup base and nuoc mam pha",
	"Simmer for 15 minutes"
))
recipes[["Tofu Tomato Soup"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# tofu tomato sauce
ingredients = list(
  Other = c("nuoc mam"),
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
recipes[["Dau Sot Ca Chua (Tofu and Tomatoes)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
# cabbage and egg
ingredients = list(
  Other = c("nuoc mam"),
  Meat = c("eggs"),
  Veggies = c("cabbage"),
  Fruit = ""
)
instructions = data.frame(Instructions = c(
	"Hard boil egg for 15 min",
	"Cut up and boil cabbage",
	"Mash up egg and add nuoc mam & water"
))
recipes[["Bap Cai Luoc (Cabbage and Egg Sauce)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Pork or Chicken Broth"]] = list(ingredients = ingredients, instructions = instructions, meal = "other", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Nui"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Thit Kho"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Ca Kho"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Nuoc Mau"]] = list(ingredients = ingredients, instructions = instructions, meal = "other", youtube = "ZGQHPZQSH_s")
#----------------------------------------------------------------------------------------------------------
# taro soup
ingredients = list(
  Other = c("wonton soup base", "salt", "pepper"),
  Meat = c("pork rib tips"),
  Veggies = c("taro", "yam", "rice paddy herbs"),
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
recipes[["Canh Khoai Tay Suon (Taro and Pork Rib Soup)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Canh Chua Ca (Sweet and Sour Fish Soup)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "hrJyKrzsjNs")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Spaghetti"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Com Chien (Fried Rice)"]] = list(ingredients = ingredients, instructions = instructions, meal = "meal", youtube = "")
#----------------------------------------------------------------------------------------------------------
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
recipes[["Sweet Potato Fries"]] = list(ingredients = ingredients, instructions = instructions, meal = "dessert", youtube = "")

