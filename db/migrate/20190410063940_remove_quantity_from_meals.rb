class RemoveQuantityFromMeals < ActiveRecord::Migration[5.2]
  def change
    remove_column :meals, :quantity, :integer
    add_column :meals, :quantity, :float
  end
end
