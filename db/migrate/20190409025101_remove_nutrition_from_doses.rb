class RemoveNutritionFromDoses < ActiveRecord::Migration[5.2]
  def change
    remove_reference :doses, :nutrition, foreign_key: true
  end
end
