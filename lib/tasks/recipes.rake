namespace :recipes do
  desc "Import al recipes for a JSON source file"
  task import: :environment do
    source_path = Rails.root.join("data", "recipes-en.json")
    file_content = File.read(source_path)
    raw_recipes = JSON.parse(file_content)

    limit = ENV["RECIPES_IMPORT_LIMIT"].present? ? ENV["RECIPES_IMPORT_LIMIT"].to_i : nil

    Recipes::Importer.new(raw_recipes: raw_recipes, limit: limit).call
  end
end
