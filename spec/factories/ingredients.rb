FactoryBot.define do
  factory :ingredient do
    sequence :title do |n|
      "#{n} cups of rice"
    end
  end
end
