module ImportRecipes
  def import_recipes_from(source_path)
    full_source_path = source_path ? base_recipes_source_path.join(source_path) : default_recipes_source_path
    file_content = File.read(full_source_path)
    raw_recipes = JSON.parse(file_content)

    Recipes::Importer.new(raw_recipes: raw_recipes).call
  end

  def default_recipes_source_path
    base_recipes_source_path.join("recipes.json")
  end

  def base_recipes_source_path
    Rails.root.join("spec", "fixtures", "data")
  end
end

RSpec.configure do |config|
  config.include ImportRecipes
end
