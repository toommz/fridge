require "rails_helper"

RSpec.describe Recipes::FindWithIngredients do
  before do
    source_path = Rails.root.join("spec", "fixtures", "data", "desserts.json")
    file_content = File.read(source_path)
    raw_recipes = JSON.parse(file_content)

    Recipes::Importer.new(raw_recipes: raw_recipes).call
  end

  describe "#new" do
    context "given no ingredients" do
      it "raises a Recipes::FindWithIngredients::EmptyIngredientsError" do
        expect { described_class.new(ingredients: []) }.to raise_error(Recipes::FindWithIngredients::EmptyIngredientsError)
      end
    end
  end

  describe "#call" do
    context "given unknown ingredients" do
      subject { described_class.new(ingredients: ["zugar", "weat"]) }

      it "returns nothing" do
        expect(subject.call).to be_empty
      end
    end

    context "given 1 known ingredient" do
      subject { described_class.new(ingredients: ["red beans"]) }

      it "returns recipes containing this ingredient" do
        results = subject.call

        expect(results.length).to eq(1)
      end

      it "sorts recipes by relevance"
    end

    context "given 3 known ingredients" do
      subject { described_class.new(ingredients: ["sugar", "flour", "chocolate"]) }

      it "returns recipes containing some of those ingredients" do
        results = subject.call

        expect(results.length).to eq(3)
      end

      it "sorts recipes by relevance"
    end
  end
end
