class AddGuestsAmountToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :guests_amount, :integer
  end
end
