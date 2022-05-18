class Recipe < ApplicationRecord
  # Validations

  validates :title, presence: true
  validates :cook_time, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :prep_time, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :ratings, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :image, presence: true

  # Associations

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
