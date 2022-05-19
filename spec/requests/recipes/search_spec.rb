require "rails_helper"

RSpec.describe "Recipes::Searches", type: :request do
  describe "GET /index" do
    context "without passing any ingredients in params" do
      before { get recipes_search_index_url(ingredients: [], format: :json) }

      it "returns http bad request" do
        expect(response).to have_http_status(:bad_request)
      end

      it "returns the error in json" do
        error = JSON.parse(response.body)

        expect(error).to eq({"error" => "please provide at least one ingredient"})
      end
    end

    context "with ingredients passed in params" do
      before do
        import_recipes_from("desserts.json")

        get recipes_search_index_url(ingredients: ["sugar", "chocolate"], format: :json)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the recipes in json" do
        data = JSON.parse(response.body)
        recipe = data.first

        expect(recipe).to match({"id" => Integer, "image" => String, "ingredients" => Array, "score" => Integer, "title" => String})
      end
    end
  end
end
