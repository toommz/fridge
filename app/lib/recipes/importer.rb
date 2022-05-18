module Recipes
  class Importer
    def initialize(raw_recipes: [], limit: nil)
      @raw_recipes = raw_recipes
      @limit = limit
    end

    def call
      Recipe.transaction do
        raw_recipes.each(&method(:create_recipe))
      end
    end

    private

    attr_reader :limit

    def raw_recipes
      @raw_recipes_with_limit ||= limit ? @raw_recipes.take(limit) : @raw_recipes
    end

    def create_recipe(raw_recipe)
      Recipe.create!(recipe_attributes(raw_recipe)).tap do |recipe|
        associate_ingredients(raw_recipe, recipe)
      end
    end

    def create_ingredients(raw_recipe)
      raw_recipe["ingredients"].map do |ingredient|
        Ingredient.find_or_create_by!(title: ingredient.downcase)
      end
    end

    def recipe_attributes(raw_recipe)
      {
        title: raw_recipe["title"],
        cook_time: raw_recipe["cook_time"],
        prep_time: raw_recipe["prep_time"],
        ratings: raw_recipe["ratings"],
        image: raw_recipe["image"]
      }
    end

    def associate_ingredients(raw_recipe, recipe)
      recipe.ingredients << create_ingredients(raw_recipe)
    end
  end
end
