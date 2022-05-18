require "rails_helper"

RSpec.describe Recipes::Importer do
  let(:source_path) { Rails.root.join("spec", "fixtures", "data", "recipes.json") }
  let(:file_content) { File.read(source_path) }
  let(:raw_recipes) { JSON.parse(file_content) }

  describe "#call" do
    context "given no limit option passed" do
      subject { described_class.new(raw_recipes: raw_recipes) }

      it "imports recipes in database" do
        expect { subject.call }.to change { Recipe.count }.by(2)
      end

      it "does not create duplicated ingredients" do
        expect { subject.call }.to change { Ingredient.count }.by(4)
      end
    end

    context "given a limit option passed" do
      subject { described_class.new(raw_recipes: raw_recipes, limit: 1) }

      it "imports recipes in database" do
        expect { subject.call }.to change { Recipe.count }.by(1)
      end
    end
  end
end
