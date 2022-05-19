json.array! @data do |entry|
  recipe = entry[:recipe]
  score = entry[:score]

  json.id recipe.id
  json.title recipe.title
  json.score score
  json.ingredients(recipe.ingredients) do |ingredient|
    json.id ingredient.id
    json.title ingredient.title
  end
end
