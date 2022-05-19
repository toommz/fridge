require "rails_helper"

RSpec.describe Recipes::FindWithIngredients do
  before do
    import_recipes_from("desserts.json")
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

        expect(results.length).to eq(2)
      end

      it "sorts recipes by relevance" do
        results = subject.call
        titles = results.map { |r| r[:recipe] }.map(&:title)

        expect(titles)
          .to eq([
            "Chili sin carne",
            "Japanese Chocolate and vanilla cake"
          ])
      end
    end

    context "given 3 known ingredients" do
      subject { described_class.new(ingredients: ["sugar", "flour", "chocolate"]) }

      it "returns recipes containing all those ingredients" do
        results = subject.call

        expect(results.length).to eq(3)
      end

      it "sorts recipes by relevance" do
        results = subject.call
        titles = results.map { |r| r[:recipe] }.map(&:title)

        expect(titles)
          .to eq([
            "Chocolate cake",
            "Chocolate and vanilla cake",
            "Japanese Chocolate and vanilla cake"
          ])
      end

      it "sets a relevance score on recipes" do
        results = subject.call
        scores = results.map { |r| r[:score] }

        expect(scores).to eq([3, 0, -2])
      end
    end
  end
end
