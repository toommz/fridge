require "rails_helper"

RSpec.describe Recipe, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:cook_time) }
    it { is_expected.to validate_numericality_of(:cook_time).is_greater_than_or_equal_to(0).only_integer }

    it { is_expected.to validate_presence_of(:prep_time) }
    it { is_expected.to validate_numericality_of(:prep_time).is_greater_than_or_equal_to(0).only_integer }

    it { is_expected.to validate_presence_of(:ratings) }
    it { is_expected.to validate_numericality_of(:ratings).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_presence_of(:image) }
  end

  describe "associations" do
    it { is_expected.to have_many(:recipe_ingredients) }
    it { is_expected.to have_many(:ingredients).through(:recipe_ingredients) }
  end
end
