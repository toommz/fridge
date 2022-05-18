FactoryBot.define do
  factory :recipe do
    title { "Chili sin carne" }
    cook_time { 45 }
    prep_time { 10 }
    ratings { 4.2 }
    image { "https://assets.afcdn.com/recipe/20190320/89689_w1200h911c1cx2736cy1824cxb5466cyb3641.webp" }
  end
end
