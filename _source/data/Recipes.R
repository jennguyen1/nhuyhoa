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

# spaghetti

# for proper display of ingredients
recipes <- map(recipes, function(x){
  m <- max(map_int(x$ingredients, length))
  x$display_ingredients <- map(x$ingredients, function(x) c(x, rep("", m - length(x)))) %>% as.data.frame()
  return(x)
})
save(recipes, file = "_source/data/recipes.Rdata")