class AddNutrientToDoses < ActiveRecord::Migration[5.2]
  def change
    add_reference :doses, :nutrient, foreign_key: true
  end
end
