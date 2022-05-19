class Recipes::SearchController < ActionController::API
  def index
    results = Recipes::FindWithIngredients.new(ingredients: search_params).call

    render json: results
  rescue Recipes::FindWithIngredients::EmptyIngredientsError, ActionController::ParameterMissing
    render json: { error: "please provide at least one ingredient" }, status: :bad_request
  end

  private

  def search_params
    params.require(:ingredients)
  end
end
