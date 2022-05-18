FactoryBot.define do
  factory :recipe_ingredient do
    association :recipe, strategy: :build
    association :ingredient, strategy: :build
  end
end
