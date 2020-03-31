class AddInfoToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :ingredient, :string, array: true, default: []
    add_column :recipes, :prep_time, :integer
    add_column :recipes, :cook_time, :integer
    add_column :recipes, :prep_step, :string, array: true, default: []
  end
end
