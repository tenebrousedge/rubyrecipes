class CreateRecipesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.decimal :rating, precision: 3, scale: 2
      t.timestamps
    end
  end
end
