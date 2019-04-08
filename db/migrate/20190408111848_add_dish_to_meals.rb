class AddDishToMeals < ActiveRecord::Migration[5.2]
  def change
    add_reference :meals, :dish, foreign_key: true
  end
end
