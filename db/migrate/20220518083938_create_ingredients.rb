class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :title, null: false, index: {unique: true}

      t.timestamps
    end

    enable_extension "pg_trgm"
    add_index :ingredients, :title, using: :gist, opclass: :gist_trgm_ops, name: :index_ingredients_on_title_tgrm
  end
end
