module Recipes
  class FindWithIngredients
    class EmptyIngredientsError < StandardError; end

    def initialize(ingredients:)
      raise EmptyIngredientsError if ingredients.empty?
      @ingredients = ingredients
    end

    def call
      query = ingredients.map do |ingredient|
        Recipe.with_ingredient(ingredient).to_sql
      end.join(" intersect ")

      Recipe.find_by_sql(query).map do |recipe|
        recipe_ingredients = recipe.ingredients.pluck(:title)

        max_score = recipe_ingredients.length
        matching_score = ingredients.length

        score = matching_score - (max_score - matching_score)

        {score: score, recipe: recipe}
      end.sort { |a, b| b[:score] <=> a[:score] }
    end

    private

    attr_reader :ingredients
  end
end
