class AddQuantityColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients_recipes, :quantity, :text
  end
end
