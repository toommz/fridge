module Recipes
  class FindWithIngredients
    class EmptyIngredientsError < StandardError; end

    def initialize(ingredients:)
      raise EmptyIngredientsError if ingredients.empty?

      @ingredients = ingredients
      @base_query = Recipe.joins(:ingredients)
    end

    def call
      query = base_query.where("ingredients.title ILIKE ?", "%#{ingredients.pop}%")

      ingredients.each do |ingredient|
        query = query.or(base_query.where("ingredients.title ILIKE ?", "%#{ingredient}%"))
      end

      query.all.uniq
    end

    private

    attr_reader :ingredients, :base_query
  end
end
