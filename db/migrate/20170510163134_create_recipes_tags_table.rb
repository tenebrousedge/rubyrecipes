class CreateRecipesTagsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes_tags do |t|
      t.belongs_to :recipe, index: true
      t.belongs_to :tag, index: true
    end
  end
end
