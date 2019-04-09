class RemoveNutritionFromGoals < ActiveRecord::Migration[5.2]
  def change
    remove_reference :goals, :nutrition, foreign_key: true
  end
end
