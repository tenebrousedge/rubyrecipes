class CreateIngredientsRecipesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients_recipes do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :recipe, index:true
      t.timestamps
    end
  end
end
