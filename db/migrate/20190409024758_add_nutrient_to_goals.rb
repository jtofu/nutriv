class AddNutrientToGoals < ActiveRecord::Migration[5.2]
  def change
    add_reference :goals, :nutrient, foreign_key: true
  end
end
