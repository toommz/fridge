require "rails_helper"

RSpec.describe Ingredient, type: :model do
  describe "validations" do
    subject { build(:ingredient) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end

  describe "associations" do
    it { is_expected.to have_many(:recipe_ingredients) }
    it { is_expected.to have_many(:recipes).through(:recipe_ingredients) }
  end
end
