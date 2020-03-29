#' Change storage of recipes from R list to SQL database
#' One-time parse of my original R code
#' JN
#' 2017/10/25

import re
import pandas as pd
import sqlite3

#' parse ingredients
class Ingredients:

  def __init__(self, other, meat, veggie, fruit):
    self.other = self.__extract_ingredients(other.replace("Other =", "").strip(), 'other')
    self.meat = self.__extract_ingredients(meat.replace("Meat =", "").strip(), 'meat')
    self.veggie = self.__extract_ingredients(veggie.replace("Veggies =", "").strip(), 'veggie')
    self.fruit = self.__extract_ingredients(fruit.replace("Fruit =", "").strip(), 'fruit')

  def __extract_ingredients(self, s, type):
    if 'c(' in s:
      out_s = s.strip().replace('c(', '').replace('),', '').replace(')', '').replace('"', '').split(',')
      values = pd.Series(out_s).str.strip()
      df = pd.DataFrame({'type': type, 'ingredients': values})
    else:
      values = None
      df = pd.DataFrame({})
    return df

  @property
  def recipe(self):
    return self._recipe

  @recipe.setter
  def recipe(self, value):
    self._recipe = value

  def get_db_data(self):
    df = pd.concat([self.other, self.meat, self.veggie, self.fruit])
    df['recipe'] = self._recipe
    df = df[['recipe', 'type', 'ingredients']]
    rows = [tuple(x) for i,x in df.iterrows()]
    return rows


#' parse instructions
class Instructions:
  def __init__(self, args):
    self.instructions = pd.Series(args).str.replace(',$', '').str.replace('"', '')

  @property
  def recipe(self):
    return self._recipe

  @recipe.setter
  def recipe(self, value):
    self._recipe = value

  def get_db_data(self):
    df = pd.DataFrame({'recipe': self._recipe, 'instructions': self.instructions})
    df = df[['recipe', 'instructions']]
    rows = [(r, int(idx), ins) for idx, r, ins in df.itertuples()]
    return rows


#' read in a new line
def get_line(f):
  return f.readline().strip()


#' parse my recipes
db = 'recipes.db'
with sqlite3.connect(db, isolation_level = None) as connection:

  c = connection.cursor()

  #' initiate tables
  c.execute("""CREATE TABLE recipes (
    recipe TEXT PRIMARY KEY,
    meal_type TEXT NOT NULL,
    youtube TEXT
  )""")
  c.execute("""CREATE TABLE ingredients (
    recipe TEXT,
    type TEXT NOT NULL,
    ingredients TEXT NOT NULL,
    FOREIGN KEY(recipe) REFERENCES recipes(recipe)
  )""")
  c.execute("""CREATE TABLE instructions (
    recipe TEXT,
    idx INTEGER,
    instructions TEXT NOT NULL,
    PRIMARY KEY(recipe, idx),
    FOREIGN KEY(recipe) REFERENCES recipes(recipe)
  )""")

  with open("Recipes.R", 'r') as f:

    cont = True
    while cont:

      l = get_line(f)

      # save ingredients
      if l.startswith('ingredients'):
        other = get_line(f)
        meat = get_line(f)
        veggie = get_line(f)
        fruit = get_line(f)
        ingredients = Ingredients(other = other, meat = meat, veggie = veggie, fruit = fruit)

      # save instructions
      elif l.startswith('instructions'):
        ins = []
        sub_line = get_line(f)
        while '))' not in sub_line:
          ins.append(sub_line)
          sub_line = get_line(f)
        instructions = Instructions(ins)

      # extract recipe info
      elif l.startswith('recipes'):
        recipe_info = pd.Series(l)
        r = recipe_info.str.extract('recipes\[\[\"(.+)\"\]\].*')[0]
        meal_type = recipe_info.str.extract('.?meal = \"(.+)\",.*')[0]
        youtube = recipe_info.str.extract('.?youtube =(.*)\)').str.replace('"', '').str.strip()[0]
        youtube = youtube if len(youtube) > 0 else None

        ingredients.recipe = r
        instructions.recipe = r

        # make recipe database
        c.execute('INSERT INTO recipes VALUES (?,?,?)', (r, meal_type, youtube))
        c.executemany('INSERT INTO ingredients VALUES (?,?,?)', ingredients.get_db_data())
        c.executemany('INSERT INTO instructions VALUES (?,?,?)', instructions.get_db_data())

      # finish up at blank line
      elif l == '':
        cont = False

