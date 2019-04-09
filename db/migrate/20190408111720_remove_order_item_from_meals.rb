class RemoveOrderItemFromMeals < ActiveRecord::Migration[5.2]
  def change
    remove_reference :meals, :order_item, foreign_key: true
  end
end
