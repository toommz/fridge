class Ingredient < ApplicationRecord
  # Validations

  validates :title, presence: true, uniqueness: {case_sensitive: false}

  # Associations

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  # Scopes

  scope :by_title, ->(title) { where("ingredients.title ILIKE ?", "%#{title}%") }
end
